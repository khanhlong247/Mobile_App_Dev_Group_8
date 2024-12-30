import 'package:flutter/material.dart';
import 'dart:html' as html;

void main() => runApp(const TravelDiaryApp());

class TravelDiaryApp extends StatelessWidget {
  const TravelDiaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Nhật ký Du lịch'),
        ),
        body: const CustomMultiChildLayoutExample(),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: 'Camera'),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          ],
          onTap: (index) {
            // Thêm hành động tại đây nếu cần khi người dùng chọn tab
          },
        ),
      ),
    );
  }
}

class _TravelDiaryLayoutDelegate extends MultiChildLayoutDelegate {
  _TravelDiaryLayoutDelegate({
    required this.textDirection,
  });

  final TextDirection textDirection;

  @override
  void performLayout(Size size) {
    // Kích thước từng phần
    const double headerHeightFactor = 0.4; // 40% màn hình cho phần GPS
    final double headerHeight = size.height * headerHeightFactor; // Chiều cao header
    final double listHeight = size.height - headerHeight; // Chiều cao danh sách nhật ký

    // Layout phần GPS
    if (hasChild('header')) {
      layoutChild(
        'header',
        BoxConstraints.tightFor(width: size.width, height: headerHeight),
      );
      positionChild('header', Offset.zero);
    }

    // Layout phần danh sách nhật ký
    if (hasChild('list')) {
      layoutChild(
        'list',
        BoxConstraints.tightFor(width: size.width, height: listHeight),
      );
      positionChild('list', Offset(0, headerHeight));
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return true;
  }
}

class CustomMultiChildLayoutExample extends StatelessWidget {
  const CustomMultiChildLayoutExample({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: _TravelDiaryLayoutDelegate(
        textDirection: Directionality.of(context),
      ),
      children: <Widget>[
        // Phần đầu: GPS
        LayoutId(
          id: 'header',
          child: const GPSHeader(),
        ),
        // Phần danh sách nhật ký
        LayoutId(
          id: 'list',
          child: Container(
            color: Colors.grey[300],
            alignment: Alignment.topCenter,
            child: const Text(
              'Danh sách ảnh',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}

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
