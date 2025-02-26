import 'package:blog_app/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:blog_app/widgets/round_button.dart';
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
          title: const Text('Create Account', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.deepOrange,
          elevation: 5,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg_pattern.png'),
              fit: BoxFit.cover,
              opacity: 0.1,
            ),
          ),
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
                      const Text('Register', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String value) {
                          email = value;
                        },
                        validator: (value) => value!.isEmpty ? 'Enter email' : null,
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String value) {
                          password = value;
                        },
                        validator: (value) => value!.isEmpty ? 'Enter password' : null,
                      ),
                      const SizedBox(height: 15),
                      RoundButton(
                        title: 'Register',
                        onPress: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              final user = await _auth.createUserWithEmailAndPassword(
                                email: email.trim(),
                                password: password.trim(),
                              );
                              if (user != null) {
                                toastMessage('User successfully created');
                                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                              }
                            } catch (e) {
                              toastMessage(e.toString());
                            }
                            setState(() {
                              showSpinner = false;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
