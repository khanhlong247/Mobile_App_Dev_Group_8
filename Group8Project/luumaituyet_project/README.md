# luumaituyet_project

## Bài kiểm tra giữa kỳ
Câu 1: (Cấp độ CĐR 1.1 – 3 điểm)

Viết lớp (class) có tên User bằng ngôn ngữ Dart gồm thông tin sau:

+ username

+ password

+ role

Câu 2: (Cấp độ CĐR 1.2 và 2.1 – 7 điểm)

Nhập vào 5 bản ghi thông tin người dùng. (3 điểm)

Hiển thị trên Mobile App 05 bản ghi người dùng theo dạng GridView. (4 điểm)

Yêu cầu Nộp bài:

Chụp ảnh màn hình Mobile App (trên web hoặc trên ios hoặc trên Android)

Code chính của class User, Object của class User, và main.dart của App.

Link Github đến repo của code vừa viết.

Link ReadMe về code chính (như câu 2) và ảnh chụp màn hình 05 bản ghi người dùng trên App (như câu 1).

### Kết quả
#### Ảnh chụp màn hình
![Imgur](https://imgur.com/0EKkyKz.png)
#### Code class User
```
class User {

  String username; // Tên đăng nhập
  
  String password; // Mật khẩu
  
  String role;     // Vai trò (admin, user, etc.)

  User({required this.username, required this.password, required this.role});
  
}
```
#### Code object của class User
```
import 'user_class.dart';

final List<User> userList = [

  User(username: 'Lưu Mai Tuyết', password: 'pass1', role: 'admin'),
  
  User(username: 'Trương Long Khánh', password: 'pass2', role: 'editor'),
  
  User(username: 'Nguyễn Văn A', password: 'pass3', role: 'viewer'),
  
  User(username: 'Nguyễn Văn B', password: 'pass4', role: 'guest'),
  
  User(username: 'Nguyễn Văn C', password: 'pass5', role: 'user'),
  
];
```
#### Code main.dart của app
```
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'user_class.dart'; 
import 'user_object.dart';
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
```
