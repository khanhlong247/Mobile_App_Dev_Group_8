import 'package:flutter/material.dart';
import 'package:blog_app/widgets/round_button.dart';
import 'package:blog_app/screens/auth/signin.dart';
import 'package:blog_app/screens/auth/login_screen.dart';

class OptionScreen extends StatefulWidget {
  const OptionScreen({Key? key}) : super(key: key);

  @override
  _OptionScreenState createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Sử dụng gradient background cho Option screen
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrange.shade300, Colors.deepOrange.shade700],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/logo1.png', height: 240),
                      const SizedBox(height: 30),
                      RoundButton(
                        title: 'Login',
                        onPress: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                        },
                      ),
                      const SizedBox(height: 20),
                      RoundButton(
                        title: 'Register',
                        onPress: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
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
}
