import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:blog_app/widgets/custom_bottom_nav_bar.dart';
import 'package:blog_app/screens/home_screen.dart';
import 'package:blog_app/screens/auth/login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message, backgroundColor: Colors.white, textColor: Colors.black);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
        title: const Text("Settings", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: "New Password",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String newPassword = passwordController.text;
                if (newPassword.isNotEmpty) {
                  setState(() {
                    isLoading = true;
                  });
                  try {
                    await _auth.currentUser?.updatePassword(newPassword);
                    toastMessage("Password updated successfully");
                  } catch (e) {
                    toastMessage(e.toString());
                  }
                  setState(() {
                    isLoading = false;
                  });
                } else {
                  toastMessage("Enter a new password");
                }
              },
              child: const Text("Change Password", style: TextStyle(color: Colors.white)),
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _auth.signOut();
                toastMessage("Signed out");
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
              },
              child: const Text("Sign Out", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }
}
