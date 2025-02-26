import 'package:blog_app/screens/option_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blog_app/screens/home_screen.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    final user = auth.currentUser;
    Timer(Duration(seconds: 3), () {
      if (user != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => OptionScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Thêm gradient background cho splash screen
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrange.shade200, Colors.deepOrange.shade700],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/blogger.png',
                height: MediaQuery.of(context).size.height * .3,
                width: MediaQuery.of(context).size.width * .6,
              ),
              const SizedBox(height: 30),
              const Text(
                'Best Travel!',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 32,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
