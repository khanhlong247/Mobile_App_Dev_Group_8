import 'package:flutter/material.dart';
import 'dart:html' as html;

void main() => runApp(const TravelDiaryApp());

class TravelDiaryApp extends StatelessWidget {
  const TravelDiaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      home: const MainPage(),
=======
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
>>>>>>> 86f911a580ddb4a15812ff24891de994e110eec5
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
<<<<<<< HEAD
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  // Danh sách các màn hình
  final List<Widget> _pages = [
    const CustomMultiChildLayoutExample(), // Màn hình chính
    const Center(child: Text('Camera Screen')), // Trang Camera (giả định)
    const HistoryScreen(), // Trang Lịch sử
  ];
=======
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
>>>>>>> 86f911a580ddb4a15812ff24891de994e110eec5

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nhật ký Du lịch'),
      ),
      body: _pages[_currentIndex], // Hiển thị màn hình theo tab hiện tại
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Chỉ mục hiện tại
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Thay đổi chỉ mục khi nhấn
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: 'Camera'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
    );
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
<<<<<<< HEAD
=======
        // Phần đầu: GPS
>>>>>>> 86f911a580ddb4a15812ff24891de994e110eec5
        LayoutId(
          id: 'header',
          child: const GPSHeader(),
        ),
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

<<<<<<< HEAD
class _TravelDiaryLayoutDelegate extends MultiChildLayoutDelegate {
  _TravelDiaryLayoutDelegate({
    required this.textDirection,
  });

  final TextDirection textDirection;

  @override
  void performLayout(Size size) {
    const double headerHeightFactor = 0.4;
    final double headerHeight = size.height * headerHeightFactor;
    final double listHeight = size.height - headerHeight;

    if (hasChild('header')) {
      layoutChild(
        'header',
        BoxConstraints.tightFor(width: size.width, height: headerHeight),
      );
      positionChild('header', Offset.zero);
    }

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

=======
>>>>>>> 86f911a580ddb4a15812ff24891de994e110eec5
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
<<<<<<< HEAD

// Trang Lịch sử
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(Icons.photo),
              title: Text('Nhật ký #${index + 1}'),
              subtitle: const Text('Chi tiết nhật ký'),
              onTap: () {
                // Hành động khi chọn nhật ký
              },
            ),
          );
        },
      ),
    );
  }
}
=======
>>>>>>> 86f911a580ddb4a15812ff24891de994e110eec5
