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
class User {

  String username; // Tên đăng nhập
  
  String password; // Mật khẩu
  
  String role;     // Vai trò (admin, user, etc.)

  User({required this.username, required this.password, required this.role});
  
}
#### Code object của class User
import 'user_class.dart';

final List<User> userList = [

  User(username: 'Lưu Mai Tuyết', password: 'pass1', role: 'admin'),
  
  User(username: 'Trương Long Khánh', password: 'pass2', role: 'editor'),
  
  User(username: 'Nguyễn Văn A', password: 'pass3', role: 'viewer'),
  
  User(username: 'Nguyễn Văn B', password: 'pass4', role: 'guest'),
  
  User(username: 'Nguyễn Văn C', password: 'pass5', role: 'user'),
  
];

#### Code main.dart của app
![Imgur](https://imgur.com/Si1apZg.png)
