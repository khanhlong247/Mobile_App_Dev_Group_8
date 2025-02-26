import 'package:blog_app/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'dart:io' show File;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'package:blog_app/models/post.dart';

class AddPostScreen extends StatefulWidget {
  final String topicId;
  const AddPostScreen({Key? key, required this.topicId}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  bool showSpinner = false;

  // Trước đây:
  // late DatabaseReference postRef = FirebaseDatabase.instance
  //     .ref()
  //     .child('Topics')
  //     .child(widget.topicId)
  //     .child('Post List');
  //
  // Giờ thay thế:
  final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  late DatabaseReference postRef = FirebaseDatabase.instance
      .ref()
      .child('Users')
      .child(userId)
      .child('Topics')
      .child(widget.topicId)
      .child('Post List');

  FirebaseAuth _auth = FirebaseAuth.instance;

  List<File> _images = [];
  List<Uint8List> _imagesBytes = [];

  final picker = ImagePicker();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController modeController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController reviewsController = TextEditingController();

  Future<void> getImageGallery() async {
    final List<XFile>? pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      if (kIsWeb) {
        for (var file in pickedFiles) {
          Uint8List bytes = await file.readAsBytes();
          setState(() {
            _imagesBytes.add(bytes);
          });
        }
      } else {
        setState(() {
          _images
              .addAll(pickedFiles.map((xfile) => File(xfile.path)).toList());
        });
      }
    } else {
      print('No image selected');
    }
  }

  Future<void> getCameraImage() async {
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      if (kIsWeb) {
        Uint8List bytes = await pickedFile.readAsBytes();
        setState(() {
          _imagesBytes.add(bytes);
        });
      } else {
        setState(() {
          _images.add(File(pickedFile.path));
        });
      }
    } else {
      print('No image selected');
    }
  }

  void dialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: SizedBox(
            height: 140,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.camera),
                  title: const Text('Camera'),
                  onTap: () {
                    getCameraImage();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () {
                    getImageGallery();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  Future<List<String>> uploadImages(List<Uint8List> imagesBytes) async {
    List<String> uploadedUrls = [];
    for (var i = 0; i < imagesBytes.length; i++) {
      int date = DateTime.now().microsecondsSinceEpoch;
      var uri = Uri.parse('https://api.cloudinary.com/v1_1/dp7jxi0ej/upload');
      var request = http.MultipartRequest('POST', uri);
      request.fields['upload_preset'] = 'unsigned_preset';
      request.fields['public_id'] = 'post_${date}_$i';
      request.files.add(http.MultipartFile.fromBytes('file', imagesBytes[i],
          filename: 'upload_$i.jpg'));
      var response = await request.send();
      if (response.statusCode == 200) {
        var resStream = await response.stream.bytesToString();
        var jsonResponse = json.decode(resStream);
        var newUrl = jsonResponse['secure_url'];
        uploadedUrls.add(newUrl);
      } else {
        throw Exception('Image upload failed: ${response.statusCode}');
      }
    }
    return uploadedUrls;
  }

  Future<List<String>> uploadImagesMobile(List<File> imageFiles) async {
    List<String> uploadedUrls = [];
    for (var i = 0; i < imageFiles.length; i++) {
      int date = DateTime.now().microsecondsSinceEpoch;
      Uint8List bytes = await imageFiles[i].readAsBytes();
      var uri = Uri.parse('https://api.cloudinary.com/v1_1/dp7jxi0ej/upload');
      var request = http.MultipartRequest('POST', uri);
      request.fields['upload_preset'] = 'unsigned_preset';
      request.fields['public_id'] = 'post_${date}_$i';
      request.files.add(
          http.MultipartFile.fromBytes('file', bytes, filename: 'upload_$i.jpg'));
      var response = await request.send();
      if (response.statusCode == 200) {
        var resStream = await response.stream.bytesToString();
        var jsonResponse = json.decode(resStream);
        var newUrl = jsonResponse['secure_url'];
        uploadedUrls.add(newUrl);
      } else {
        throw Exception('Image upload failed: ${response.statusCode}');
      }
    }
    return uploadedUrls;
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Upload Trip', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.deepOrange,
          elevation: 5,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    dialog(context);
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                        child: Text("Tap to add images",
                            style: TextStyle(fontSize: 16))),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: kIsWeb ? _imagesBytes.length : _images.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: kIsWeb
                            ? Image.memory(_imagesBytes[index],
                                width: 100, height: 100, fit: BoxFit.cover)
                            : Image.file(_images[index],
                                width: 100, height: 100, fit: BoxFit.cover),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: titleController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'Title',
                              hintText: 'Enter trip title',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: descriptionController,
                            keyboardType: TextInputType.text,
                            minLines: 1,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              labelText: 'Description',
                              hintText: 'Enter trip description',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: dateController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'Date',
                              hintText: 'Enter date',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: durationController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Duration',
                              hintText: 'Enter duration (in day)',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: modeController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'Vehicle',
                              hintText: 'Enter your vehicle',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: ratingController,
                            keyboardType:
                                const TextInputType.numberWithOptions(decimal: true),
                            decoration: const InputDecoration(
                              labelText: 'Rating',
                              hintText: 'Enter rating (1-5 stars)',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: reviewsController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'Reviews',
                              hintText: 'Enter number of reviews',
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
                  title: 'Upload',
                  onPress: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      int date = DateTime.now().microsecondsSinceEpoch;
                      List<String> uploadedUrls = [];
                      if (kIsWeb) {
                        if (_imagesBytes.isNotEmpty) {
                          uploadedUrls = await uploadImages(_imagesBytes);
                        } else {
                          toastMessage('No image selected');
                          setState(() {
                            showSpinner = false;
                          });
                          return;
                        }
                      } else {
                        if (_images.isNotEmpty) {
                          uploadedUrls = await uploadImagesMobile(_images);
                        } else {
                          toastMessage('No image selected');
                          setState(() {
                            showSpinner = false;
                          });
                          return;
                        }
                      }
                      final User? user = _auth.currentUser;
                      Post newPost = Post(
                        pId: date.toString(),
                        pImages: uploadedUrls,
                        pTime: date.toString(),
                        pTitle: titleController.text,
                        pDescription: descriptionController.text,
                        pEmail: user!.email.toString(),
                        uid: user.uid.toString(),
                        pDate: dateController.text,
                        pDuration:
                            int.tryParse(durationController.text) ?? 0,
                        pMode: modeController.text,
                        pRating:
                            double.tryParse(ratingController.text) ?? 0.0,
                        pReviews:
                            int.tryParse(reviewsController.text) ?? 0,
                      );
                      await postRef.child(date.toString()).set(newPost.toMap()).then((value) {
                        toastMessage('Trip Published');
                        setState(() {
                          showSpinner = false;
                        });
                      }).onError((error, stackTrace) {
                        toastMessage(error.toString());
                        setState(() {
                          showSpinner = false;
                        });
                      });
                    } catch (e) {
                      setState(() {
                        showSpinner = false;
                      });
                      toastMessage(e.toString());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
