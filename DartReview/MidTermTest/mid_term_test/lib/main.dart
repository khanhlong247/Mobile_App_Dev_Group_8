import 'package:flutter/material.dart';
import 'screens/user_grid_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserGridScreen(), // truy cập đến class UserGridScreen
    );
  }
}