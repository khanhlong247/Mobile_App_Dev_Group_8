import 'package:blog_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyATTjaXUYQcYcX6IVzqLIP0Lr9feOQo6Wg",
        authDomain: "blog-app-flutter-f2a6b.firebaseapp.com",
        projectId: "blog-app-flutter-f2a6b",
        storageBucket: "blog-app-flutter-f2a6b.firebasestorage.app",
        messagingSenderId: "687308783617",
        appId: "1:687308783617:web:06817a205e1b26023d4000",
        measurementId: "G-QBTYMEFYCS",
        databaseURL: "https://blog-app-flutter-f2a6b-default-rtdb.asia-southeast1.firebasedatabase.app/"
      )
    );
  }
  else {
    await Firebase.initializeApp();
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: SplashScreen(),
    );
  }
}