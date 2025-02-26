import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:blog_app/widgets/custom_bottom_nav_bar.dart';
class EditTopicScreen extends StatefulWidget {
  final String topicId;
  final Map topicData;

  const EditTopicScreen({Key? key, required this.topicId, required this.topicData}) : super(key: key);

  @override
  _EditTopicScreenState createState() => _EditTopicScreenState();
}

class _EditTopicScreenState extends State<EditTopicScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;

  @override
  void initState(){
    super.initState();
    titleController.text = widget.topicData['tTitle'] ?? '';
    descriptionController.text = widget.topicData['tDescription'] ?? '';
  }

  void toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.white,
      textColor: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Travel', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepOrange,
        elevation: 5,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Travel Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value!.isEmpty ? 'Enter travel title' : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Travel Description',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value!.isEmpty ? 'Enter travel description' : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        setState(() { isLoading = true; });
                        try {
                          DatabaseReference topicRef = FirebaseDatabase.instance
                              .ref()
                              .child('Topics')
                              .child(widget.topicId);
                          await topicRef.update({
                            'tTitle': titleController.text,
                            'tDescription': descriptionController.text,
                          });
                          toastMessage('Travel Updated');
                          Navigator.pop(context);
                        } catch(e){
                          toastMessage(e.toString());
                        }
                        setState(() { isLoading = false; });
                      }
                    },
                    child: const Text('Update Travel', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}
