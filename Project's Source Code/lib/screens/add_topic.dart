import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:blog_app/screens/home_screen.dart';
import 'package:blog_app/widgets/custom_bottom_nav_bar.dart';

class AddTopicScreen extends StatefulWidget {
  const AddTopicScreen({Key? key}) : super(key: key);

  @override
  _AddTopicScreenState createState() => _AddTopicScreenState();
}

class _AddTopicScreenState extends State<AddTopicScreen> {
  bool showSpinner = false;
  final topicRef = FirebaseDatabase.instance.ref().child('Topics');
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.white,
      textColor: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
          title: const Text('Create Travel', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.deepOrange,
          elevation: 5,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          hintText: 'Enter travel title',
                          labelText: 'Travel Title',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value!.isEmpty ? 'Enter travel title' : null,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          hintText: 'Enter travel description',
                          labelText: 'Travel Description',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value!.isEmpty ? 'Enter travel description' : null,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              int date = DateTime.now().microsecondsSinceEpoch;
                              await topicRef.child(date.toString()).set({
                                'tId': date.toString(),
                                'tTitle': titleController.text,
                                'tDescription': descriptionController.text,
                                'tTime': date.toString(),
                              }).then((value) {
                                toastMessage('Travel Created');
                                setState(() {
                                  showSpinner = false;
                                });
                                Navigator.pop(context);
                              }).onError((error, stackTrace) {
                                toastMessage(error.toString());
                                setState(() {
                                  showSpinner = false;
                                });
                              });
                            } catch (e) {
                              toastMessage(e.toString());
                              setState(() {
                                showSpinner = false;
                              });
                            }
                          }
                        },
                        child: const Text('Create Travel', style: TextStyle(color: Colors.white)),
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
        ),
        bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
      ),
    );
  }
}
