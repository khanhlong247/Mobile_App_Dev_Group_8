# MemoMap: Ứng dụng ghi lại và chia sẻ hành trình

## Mobile App Dev Course: Group8

### 1. Thành viên nhóm

- Trương Long Khánh - 22010198

- Lưu Mai Tuyết - 22010226

- Nguyễn Viết Huy - 22010323

### 2. Mô tả đề tài

**Ứng dụng MemoMap** là một ứng dụng cho phép người dùng ***ghi lại*** các khoảnh khắc (ảnh) tại các nơi người dùng đi qua, ***lưu lại*** lịch sử bản ghi và lịch sử địa điểm của bản ghi đó trên tài khoản người dùng. Người dùng có thể ***chỉnh sửa*** lên các bản ghi như viết cảm nhạn, thêm đánh giá,...một cách dễ dàng. Ngoài ra người dùng có thẻ ***chia sẻ*** các bản ghi như là nhật ký du lịch lên trên các mạng xã hội.

**Đối tượng sử dụng (phạm vi người dùng):** bao gồm các cá nhân có mong muốn lưu lại các khoảnh khắc trong chuyến đi du lịch và ghi lại cảm nhận của bản thân đối với khoảnh khắc đó.

### 3. Công nghệ sử dụng

- Ngôn ngữ lập trình: Dart
  
- Framework: Flutter

- Cơ sở dữ liệu: Firebase Firestore

### 4. Các tính năng chính
  
#### a. Xác Thực Người Dùng (Authentication)

Cho phép người dùng:
-	Lựa chọn giữa đăng nhập (Login) hoặc đăng ký (Register).
-	Đăng nhập bằng email và mật khẩu.
-	Khôi phục mật khẩu khi quên.
       
#### b. Quản Lý Chủ Đề (Topic Management)

Cho phép người dùng:
-	Tạo mới một chủ đề (Travel).
-	Chỉnh sửa thông tin Travel đã tạo.
-	Hiển thị chi tiết của một Travel và danh sách bài đăng (Trip) thuộc chủ đề đó.

#### c. Quản Lý Bài Đăng (Post Management)

Cho phép người dùng:
- Tạo bài đăng (Trip) mới trong một chủ đề (Travel).
- Chỉnh sửa bài đăng đã tạo.
- Hiển thị chi tiết bài đăng.

#### d. Cài Đặt và Quản Lý Tài Khoản

Cho phép người dùng:
- Thay đổi mật khẩu và đăng xuất.

#### e. Hỗ Trợ Xử Lý Hình Ảnh

Cho phép người dùng:
- Chụp ảnh trực tiếp bằng camera.
- Tải ảnh từ thư viện thiết bị.

### 4. Phân tích và thiết kế phần mềm

#### 4.1. Class Diagram

![Class Diagram](https://imgur.com/vIDWyNQ.png)

Trong đó: Các đối tượng Travel được tạo ra từ Class Topic và các đối tượng Trip được tạo ra từ Class Post.

#### 4.2. Use-case

![Use-case](https://imgur.com/PChNF1Q.png)

#### 4.3. Sequence Diagram

![Sequence Diagram](https://imgur.com/VlXYT3h.png)

### 5. Một số giao diện

#### 5.1. Đăng nhập

![Màn hình đăng nhập](https://imgur.com/ilWPHQR.png)

#### 5.2. Đăng ký

![Màn hình đăng ký](https://imgur.com/VtQKdhR.png)

#### 5.3. Danh sách các Travel

![Danh sách Travel](https://imgur.com/OeDBpkT.png)

#### 5.4. Danh sách các Trip

![Danh sách Trip](https://imgur.com/fPzEklB.png)

#### 5.5. Tìm kiếm Travel

![Tìm kiếm Travel](https://imgur.com/265q6Y5.png)

### 6. Cấu trúc file của ứng dụng

![Cấu trúc file](https://imgur.com/MfzZdhv.png)

Cấu trúc file của ứng dụng được thiết kế dựa trên mô hình MVC (Model - View - Control) giúp ứng dụng dễ dàng theo dõi và dễ bảo trì.

- models: Chứa file các đối tượng topic (Travel) và post (Trip).

- screens (tương đương "View"): Chứa các file màn hình chính để hiển thị giao diện người dùng.

- controllers: Chứa các file liên quan tới logic, kết nối giữa người dùng với hệ thống và với các ứng dụng bên ngoài.

Ngoài ra, folder "widgets" chứa các mẫu giao diện sử dụng nhiều trong dự án như navigation bar, button.

### 7. Cài đặt và chạy ứng dụng

#### Yêu cầu: Đã cài đặt Android Studio, Flutter SDK, Dart SDK.

**Bước 1:** Tạo folder để chứa source code của dự án

**Bước 2:** Tải code của dự án về bằng cách clone từ github

- Sử dụng: `git clone https://github.com/khanhlong247/Mobile_App_Dev_Group_8.git`

**Bước 3:** Truy cập vào code của dự án

- Đường dẫn tới source code: `<folder name>\Mobile_App_Dev_Group_8\Project's Source Code`

**Bước 4:** Cài đặt các package cần thiết

- Mở các phần mềm có thể biên dịch dự án Flutter như: Android Studio, Visual Studio Code,...Mở folder source code và chạy dòng lệnh `flutter pub get` trên terminal.

**Bước 5:** Chạy ứng dụng

- Mở máy ảo từ Android Studio và chạy dòng lệnh `flutter run` để chạy ứng dụng.
