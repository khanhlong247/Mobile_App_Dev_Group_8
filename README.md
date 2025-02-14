# MemoMap: Ứng dụng ghi lại và chia sẻ hành trình

## Mobile App Dev Course: Group8

### 1. Thành viên nhóm

- Trương Long Khánh - 22010198

- Lưu Mai Tuyết - 22010226

- Nguyễn Viết Huy - 22010323

### 2. Mô tả đề tài

**Ứng dụng MemoMap** là một ứng dụng cho phép người dùng ***ghi lại*** các khoảnh khắc (ảnh hoặc video) tại các nơi người dùng đi qua, ***lưu lại*** lịch sử bản ghi và lịch sử địa điểm của bản ghi đó trên tài khoản người dùng qua định vị GPS. Người dùng có thể ***chỉnh sửa*** lên các bản ghi như tạo ghi chú cho các câu chuyện, thêm các biểu tượng cảm xúc,...một cách dễ dàng. Ngoài ra người dùng có thẻ ***chia sẻ*** các bản ghi như là nhật ký du lịch lên trên các mạng xã hội.

### 3. Các tính năng chính

#### a. Ghi lại hành trình bằng GPS

- Lưu tọa độ vị trí thực tế khi người dùng thêm địa điểm vào nhật ký.
- Cho phép xem các điểm đã lưu trên bản đồ tích hợp (Google Maps hoặc Mapbox).
- Tính năng ghi lại lộ trình tự động dựa trên GPS trong suốt chuyến đi (nếu người dùng cho phép).
  
#### b. Thêm ảnh và video vào địa điểm

Cho phép người dùng:
-	Chụp ảnh hoặc quay video trực tiếp bằng camera.
-	Tải lên ảnh/video từ thư viện thiết bị.
     -    Tự động gắn vị trí (geotag) và thời gian vào ảnh/video khi tải lên.
       
#### c. Viết mô tả và cảm xúc

Cho phép người dùng ghi chú:
-	Tên địa điểm.
-	Cảm xúc, trải nghiệm hoặc mô tả chi tiết.
     -    Tính năng sử dụng emoji hoặc stickers để diễn tả cảm xúc.
       
#### d. Hiển thị hành trình trên bản đồ

Tích hợp bản đồ với các tính năng:
Hiển thị tất cả địa điểm đã lưu dưới dạng điểm.
Kết nối các điểm bằng đường đi thể hiện lộ trình của chuyến đi.
Xem chi tiết từng địa điểm khi nhấn vào điểm đó.

#### e. Xem lại và chia sẻ nhật ký du lịch

Timeline (dòng thời gian) của các địa điểm và hình ảnh.
Bản đồ tương tác với hình ảnh và ghi chú đính kèm.
Cho phép xuất nhật ký dưới dạng:
PDF hoặc album ảnh.
Tích hợp tính năng chia sẻ lên mạng xã hội như Facebook, Instagram.

### 4. Phân tích và thiết kế phần mềm

#### 4.1. Class Diagram

![Class Diagram](https://i.imgur.com/5awhTTy.png)

#### 4.2. Sequence Diagram

![Sequence Diagram](https://imgur.com/W5qIIQc.png)

#### 4.3. Activity Diagram

![Activity Diagram](https://imgur.com/QPeM5l4.jpeg)

#### 4.4. Use-case

![Use-case](https://imgur.com/RMAr6S5.jpeg)

#### 4.5. Sơ đồ chức năng

**a. Ghi lại hành trình**

<table>
  <tr>
    <td><img src="https://imgur.com/22S7SSZ.jpg" alt="Image 1" width="500"></td>
    <td><img src="https://imgur.com/5XQhcyD.jpg" alt="Image 2" width="500"></td>
  </tr>
</table>

**b. Thêm ảnh và video**

<table>
  <tr>
    <td><img src="https://imgur.com/I2y6kG6.jpg" alt="Image 1" width="500"></td>
    <td><img src="https://imgur.com/cgEdJkv.jpg" alt="Image 2" width="500"></td>
  </tr>
</table>

**c. Chỉnh sửa ảnh/video**

<table>
  <tr>
    <td><img src="https://imgur.com/MNERK1H.jpg" alt="Image 1" width="500"></td>
    <td><img src="https://imgur.com/IeNUgQU.jpg" alt="Image 2" width="500"></td>
  </tr>
</table>

**d. Hiển thị hành trình**

<table>
  <tr>
    <td><img src="https://imgur.com/lTOng18.jpg" alt="Image 1" width="500"></td>
    <td><img src="https://imgur.com/flhzcSh.jpg" alt="Image 2" width="500"></td>
  </tr>
</table>

**e. Chia sẻ**

<table>
  <tr>
    <td><img src="https://imgur.com/q8Msxc9.jpg" alt="Image 1" width="500"></td>
    <td><img src="https://imgur.com/VQWPxnt.jpg" alt="Image 2" width="500"></td>
  </tr>
</table>

### 5. Một số giao diện

#### 5.1. Trang chủ

![img](https://i.imgur.com/QzMCvWp.png)

#### 5.2. Camera screen

![img](https://i.imgur.com/adILbFW.png)

#### 5.3. History screen

![Imgur](https://imgur.com/G1yo5dp.png)
