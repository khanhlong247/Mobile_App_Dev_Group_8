import 'package:flutter/material.dart';
import 'package:blog_app/components/round_button.dart';
import 'package:blog_app/screens/signin.dart';
import 'package:blog_app/screens/login_screen.dart';

class OptionScreen extends StatefulWidget {
  const OptionScreen({Key? key}) : super(key: key);

  @override
  _OptionScreenState createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: AssetImage('assets/images/logo1.png')),
              SizedBox(height: 30),
              RoundButton(title: 'Login', onPress: (){
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => LoginScreen()
                  ),
                );
              },),
              SizedBox(height: 30),
              RoundButton(title: 'Register', onPress: (){
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => SignIn()
                  ),
                );
              },),
            ],
          ),
        ),
      ), 
    );
  }
}