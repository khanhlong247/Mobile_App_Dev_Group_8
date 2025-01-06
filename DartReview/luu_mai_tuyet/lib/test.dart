import 'package:flutter/material.dart';
import 'dart:html' as html;

void main() => runApp(const TravelDiaryApp());

class TravelDiaryApp extends StatelessWidget {
  const TravelDiaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const UserListPage(),
    );
  }
}

// Lớp User để quản lý thông tin người dùng
class User {
  String username; // Tên đăng nhập
  String password; // Mật khẩu
  String role;     // Vai trò (admin, user, etc.)

  User({required this.username, required this.password, required this.role});
}

// Trang hiển thị danh sách người dùng
class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  // Danh sách người dùng
  final List<User> _users = [];

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();

  // Hàm để thêm người dùng
  void _addUser() {
    if (_users.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bạn chỉ được thêm tối đa 5 người dùng')),
      );
      return;
    }

    setState(() {
      _users.add(
        User(
          username: _usernameController.text,
          password: _passwordController.text,
          role: _roleController.text,
        ),
      );
    });

    _usernameController.clear();
    _passwordController.clear();
    _roleController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách người dùng'),
      ),
      body: Column(
        children: [
          // Form nhập thông tin người dùng
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Tên đăng nhập'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Mật khẩu'),
                  obscureText: true,
                ),
                TextField(
                  controller: _roleController,
                  decoration: const InputDecoration(labelText: 'Vai trò'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _addUser,
                  child: const Text('Thêm người dùng'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Danh sách người dùng:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // Hiển thị danh sách người dùng dưới dạng GridView
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Hiển thị 2 cột
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2, // Tỷ lệ chiều rộng / chiều cao
              ),
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                return Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tên: ${user.username}', style: const TextStyle(fontSize: 16)),
                        Text('Vai trò: ${user.role}', style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
