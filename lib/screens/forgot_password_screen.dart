import 'package:flutter/material.dart';
import 'package:blog_app/components/round_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String email = '';

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Forgot Password'),
          automaticallyImplyLeading: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent, // Đặt màu thanh trạng thái
            statusBarIconBrightness: Brightness.dark, // Màu biểu tượng trên thanh trạng thái
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Text('Login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String value) {
                          email = value;
                        },
                        validator: (value) {
                          return value!.isEmpty ? 'enter email' : null;
                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: RoundButton(title: 'Recover Password', onPress: ()async{
                          if(_formKey.currentState!.validate()){
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              _auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value){
                                setState(() {
                                  showSpinner = false;
                                });
                                toastMessage('Please check your email');
                              }).onError((error, stackTrace){
                                toastMessage(error.toString());
                                setState(() {
                                  showSpinner = false;
                                });
                              });
                            } catch(e) {
                              print(e.toString());
                              toastMessage(e.toString());
                              setState(() {
                                showSpinner = false;
                              });
                            }
                          }
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ), 
      ),
    ); 
  }

  void toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0
    );
  }
}