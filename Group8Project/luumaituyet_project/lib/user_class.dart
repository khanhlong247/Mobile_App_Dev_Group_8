// Lớp User để quản lý thông tin người dùng
class User {
  String username; // Tên đăng nhập
  String password; // Mật khẩu
  String role;     // Vai trò (admin, user, etc.)

  User({required this.username, required this.password, required this.role});
}
