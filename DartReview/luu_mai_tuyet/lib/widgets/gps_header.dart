import 'package:flutter/material.dart';
import 'dart:html' as html;

class GPSHeader extends StatefulWidget {
  const GPSHeader({super.key});

  @override
  State<GPSHeader> createState() => _GPSHeaderState();
}

class _GPSHeaderState extends State<GPSHeader> {
  String _location = "Đang lấy vị trí...";

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      html.window.navigator.geolocation.getCurrentPosition().then((position) {
        final latitude = position.coords!.latitude;
        final longitude = position.coords!.longitude;
        setState(() {
          _location = "Vĩ độ: $latitude, Kinh độ: $longitude";
        });
      }).catchError((error) {
        setState(() {
          _location = "Không thể lấy vị trí: $error";
        });
      });
    } catch (e) {
      setState(() {
        _location = "Lỗi: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      alignment: Alignment.center,
      child: Text(
        _location,
        style: const TextStyle(color: Colors.white, fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }
}
