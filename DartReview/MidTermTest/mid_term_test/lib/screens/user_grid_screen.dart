import 'package:flutter/material.dart';
import '../models/user.dart';

class UserGridScreen extends StatelessWidget {
  // danh sách 5 user
  final List<User> users = [
    User(username: "user1", password: "pass1", role: "Admin"),
    User(username: "user2", password: "pass2", role: "Editor"),
    User(username: "user3", password: "pass3", role: "Viewer"),
    User(username: "user4", password: "pass4", role: "Admin"),
    User(username: "user5", password: "pass5", role: "Editor"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Title Bar
      appBar: AppBar(
        title: Text("Account Management"),
        titleTextStyle: TextStyle(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)), 
        ),
        elevation: 10,
      ),
      // vùng hiển thị thông tin chính
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Card(
              color: Colors.blueAccent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Username: ${user.username}",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Role: ${user.role}",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        onTap: (index) {
          // Xử lý chuyển hướng
          if (index == 0) {
            print('Navigating to Home');
          } else {
            print('Navigating to Account');
          }
        },
      ),
    );
  }
}