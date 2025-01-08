import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Layouts',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CombinedLayouts(),
    );
  }
}

class CombinedLayouts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text('Combined Layouts')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Row Layout
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    'assets/test1.png',
                    fit: BoxFit.contain,
                    width: width * 0.5,
                  ),
                  Image.asset(
                    'assets/test2.png',
                    fit: BoxFit.contain,
                    width: width * 0.5,
                  ),
                ],
              ),
            ),
            // Column Layout
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    'assets/test1.png',
                    fit: BoxFit.contain,
                    width: width * 0.95,
                  ),
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/test2.png',
                    fit: BoxFit.contain,
                    width: width * 0.95,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
