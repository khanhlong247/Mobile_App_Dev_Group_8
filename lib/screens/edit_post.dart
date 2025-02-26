import 'package:blog_app/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'dart:io' show File;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:blog_app/models/post.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditPostScreen extends StatefulWidget {
  final String topicId;
  final String postId;
  final Map postData;

  const EditPostScreen({Key? key, required this.topicId, required this.postId, required this.postData}) : super(key: key);

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  bool showSpinner = false;
  late DatabaseReference postRef = FirebaseDatabase.instance
      .ref()
      .child('Topics')
      .child(widget.topicId)
      .child('Post List')
      .child(widget.postId);
  FirebaseAuth _auth = FirebaseAuth.instance;

  List<String> existingImages = [];
  List<File> newImages = []; 
  List<Uint8List> newImagesBytes = []; 

  final picker = ImagePicker();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController modeController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController reviewsController = TextEditingController();

  @override
  void initState(){
    super.initState();
    Post postObj = Post.fromMap(widget.postData);
    titleController.text = postObj.pTitle;
    descriptionController.text = postObj.pDescription;
    existingImages = postObj.pImages;
    dateController.text = postObj.pDate;
    durationController.text = postObj.pDuration.toString();
    modeController.text = postObj.pMode;
    ratingController.text = postObj.pRating.toString();
    reviewsController.text = postObj.pReviews.toString();
  }

  void toastMessage(String message) {
    Fluttertoast.showToast(msg: message, backgroundColor: Colors.white, textColor: Colors.black);
  }

  Future<void> pickNewImages() async {
    final List<XFile>? pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      if (kIsWeb) {
        for (var file in pickedFiles) {
          Uint8List bytes = await file.readAsBytes();
          setState(() {
            newImagesBytes.add(bytes);
          });
        }
      } else {
        setState(() {
          newImages.addAll(pickedFiles.map((xfile) => File(xfile.path)).toList());
        });
      }
    } else {
      print('No new image selected');
    }
  }

  Future<void> pickNewCameraImage() async {
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      if (kIsWeb) {
        Uint8List bytes = await pickedFile.readAsBytes();
        setState(() {
          newImagesBytes.add(bytes);
        });
      } else {
        setState(() {
          newImages.add(File(pickedFile.path));
        });
      }
    }
  }

  void dialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          content: SizedBox(
            height: 140,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.camera),
                  title: const Text('Camera'),
                  onTap: (){
                    pickNewCameraImage();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: (){
                    pickNewImages();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  Future<List<String>> uploadNewImages() async {
    List<String> uploadedUrls = [];
    if (kIsWeb) {
      for (var i = 0; i < newImagesBytes.length; i++) {
        int date = DateTime.now().microsecondsSinceEpoch;
        var uri = Uri.parse('https://api.cloudinary.com/v1_1/your_cloud_name/upload');
        var request = http.MultipartRequest('POST', uri);
        request.fields['upload_preset'] = 'your_unsigned_upload_preset';
        request.fields['public_id'] = 'post_${date}_$i';
        request.files.add(
          http.MultipartFile.fromBytes('file', newImagesBytes[i], filename: 'upload_$i.jpg')
        );
        var response = await request.send();
        if(response.statusCode == 200){
          var resStream = await response.stream.bytesToString();
          var jsonResponse = json.decode(resStream);
          var newUrl = jsonResponse['secure_url'];
          uploadedUrls.add(newUrl);
        } else {
          throw Exception('Image upload failed: ${response.statusCode}');
        }
      }
    } else {
      for (var i = 0; i < newImages.length; i++) {
        int date = DateTime.now().microsecondsSinceEpoch;
        Uint8List bytes = await newImages[i].readAsBytes();
        var uri = Uri.parse('https://api.cloudinary.com/v1_1/your_cloud_name/upload');
        var request = http.MultipartRequest('POST', uri);
        request.fields['upload_preset'] = 'your_unsigned_upload_preset';
        request.fields['public_id'] = 'post_${date}_$i';
        request.files.add(
          http.MultipartFile.fromBytes('file', bytes, filename: 'upload_$i.jpg')
        );
        var response = await request.send();
        if(response.statusCode == 200){
          var resStream = await response.stream.bytesToString();
          var jsonResponse = json.decode(resStream);
          var newUrl = jsonResponse['secure_url'];
          uploadedUrls.add(newUrl);
        } else {
          throw Exception('Image upload failed: ${response.statusCode}');
        }
      }
    }
    return uploadedUrls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Post', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepOrange,
        elevation: 5,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: existingImages.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(existingImages[index], width: 150, height: 150, fit: BoxFit.cover),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  existingImages.removeAt(index);
                                });
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: kIsWeb ? newImagesBytes.length : newImages.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: kIsWeb
                                ? Image.memory(newImagesBytes[index], width: 150, height: 150, fit: BoxFit.cover)
                                : Image.file(newImages[index], width: 150, height: 150, fit: BoxFit.cover),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  if(kIsWeb){
                                    newImagesBytes.removeAt(index);
                                  } else {
                                    newImages.removeAt(index);
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    dialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                  ),
                  child: const Text("Add New Images", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: titleController,
                            decoration: const InputDecoration(
                              labelText: 'Post Title',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: descriptionController,
                            decoration: const InputDecoration(
                              labelText: 'Post Description',
                              border: OutlineInputBorder(),
                            ),
                            minLines: 1,
                            maxLines: 5,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: dateController,
                            decoration: const InputDecoration(
                              labelText: 'Date',
                              hintText: 'Enter the date of post',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: durationController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Duration',
                              hintText: 'Enter the duration of your journey',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: modeController,
                            decoration: const InputDecoration(
                              labelText: 'Vehicle',
                              hintText: 'Enter the vehicle',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: ratingController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            decoration: const InputDecoration(
                              labelText: 'Rating',
                              hintText: 'Enter rating (1-5 stars)',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: reviewsController,
                            decoration: const InputDecoration(
                              labelText: 'Reviews',
                              hintText: 'Enter your reviews',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                RoundButton(
                  title: 'Update Post',
                  onPress: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      List<String> newUploadedUrls = await uploadNewImages();
                      List<String> finalImages = [];
                      finalImages.addAll(existingImages);
                      finalImages.addAll(newUploadedUrls);
                      
                      Post updatedPost = Post(
                        pId: widget.postId,
                        pImages: finalImages,
                        pTime: widget.postData['pTime'] ?? '',
                        pTitle: titleController.text,
                        pDescription: descriptionController.text,
                        pEmail: widget.postData['pEmail'] ?? '',
                        uid: widget.postData['uid'] ?? '',
                        pDate: dateController.text,
                        pDuration: int.tryParse(durationController.text) ?? 0,
                        pMode: modeController.text,
                        pRating: double.tryParse(ratingController.text) ?? 0.0,
                        pReviews: int.tryParse(reviewsController.text) ?? 0,
                      );
                      
                      await postRef.update(updatedPost.toMap()).then((value) {
                        toastMessage('Post Updated');
                        Navigator.pop(context);
                      }).onError((error, stackTrace) {
                        toastMessage(error.toString());
                      });
                    } catch(e) {
                      toastMessage(e.toString());
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await postRef.remove();
                    toastMessage('Post Deleted');
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                  ),
                  child: const Text('Delete Post', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
