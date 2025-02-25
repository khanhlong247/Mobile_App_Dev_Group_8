import 'package:flutter/material.dart';
import 'package:blog_app/components/round_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:blog_app/screens/home_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String email = '', password = '';

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create Account'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Text('Register', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35)),
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
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String value) {
                            password = value;
                          },
                          validator: (value) {
                            return value!.isEmpty ? 'enter password' : null;
                          },
                        ),
                      ),
                      RoundButton(title: 'Register', onPress: ()async{
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final user = await _auth.createUserWithEmailAndPassword(
                              email: email.toString().trim(),
                              password: password.toString().trim()
                            );

                            if (user != null) {
                              print('Success');
                              toastMessage('User successfully created');
                              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                              setState(() {
                                showSpinner = false;
                              });
                            }
                          }catch(e) {
                            print(e.toString());
                            toastMessage(e.toString());
                            setState(() {
                              showSpinner = false;
                            });
                          }
                        }
                      }),
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
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
    );
  }
}