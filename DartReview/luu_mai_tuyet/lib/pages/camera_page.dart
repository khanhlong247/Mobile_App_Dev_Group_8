import 'package:flutter/material.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Logic để mở camera sẽ được thêm ở đây
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Camera is not implemented yet!')),
            );
          },
          child: const Text('Open Camera'),
        ),
      ),
    );
  }
}
