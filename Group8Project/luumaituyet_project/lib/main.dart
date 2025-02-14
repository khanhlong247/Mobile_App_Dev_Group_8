import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'user_class.dart'; 
import 'user_object.dart';
import 'diary_detail_page.dart';

void main() => runApp(const TravelDiaryApp());

class TravelDiaryApp extends StatelessWidget {
  const TravelDiaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white, // Màu nền cho BottomNavigationBar
          selectedItemColor: Colors.blue, // Màu cho mục được chọn
          unselectedItemColor: Colors.grey, // Màu cho mục không được chọn
        ),
      ),
      home: const MainPage(),
    );
  }
}


// Trang chính với Bottom Navigation
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  // Danh sách các màn hình
  final List<Widget> _pages = [
    const CustomMultiChildLayoutExample(), // Màn hình chính
    const Center(child: Text('Camera Screen')), // Trang Camera (giả định)
    const HistoryScreen(), // Trang Lịch sử
    const UserListPage(), // Trang Quản lý người dùng
  ];

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
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Users'),
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

// Trang Lịch sử
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                // Điều hướng đến trang chi tiết
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DiaryDetailPage(
                      title: 'Nhật ký #${index + 1}',
                      description:
                          'Vịnh Hạ Long một kỳ quan mà mẹ thiên nhiên mang tặng cho đất nước Việt Nam',
                      prepTime: '25 phút',
                      cookTime: '3 người',
                      feeds: 'xe máy',
                      //imageUrl:
                          //'https://dulichtoday.vn/wp-content/uploads/2017/04/vinh-Ha-Long.jpg',
                  
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}


class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Số cột trong GridView
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.5, // Tỉ lệ khung của các mục
        ),
        itemCount: userList.length,
        itemBuilder: (context, index) {
          final user = userList[index];
          return Card(
            elevation: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Username: ${user.username}'),
                Text('Role: ${user.role}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
