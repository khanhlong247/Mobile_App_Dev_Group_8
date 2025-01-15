/**import 'package:flutter/material.dart';

class DiaryDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String prepTime;
  final String cookTime;
  final String feeds;
  final String imageUrl;

  const DiaryDetailPage({
    super.key,
    required this.title,
    required this.description,
    required this.prepTime,
    required this.cookTime,
    required this.feeds,
    this.imageUrl = 'assets/default.jpg',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hiển thị ảnh của chuyến đi
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  imageUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildInfoColumn(Icons.timer, 'Time', prepTime),
                  _buildInfoColumn(Icons.people, 'Group', cookTime),
                  _buildInfoColumn(Icons.directions_car, 'Transport', feeds),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoColumn(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }
}*/

import 'package:flutter/material.dart';

class DiaryDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String prepTime;
  final String cookTime;
  final String feeds;

  const DiaryDetailPage({
    super.key,
    required this.title,
    required this.description,
    required this.prepTime,
    required this.cookTime,
    required this.feeds,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0), // Khoảng cách từ lề màn hình
        alignment: Alignment.topLeft, // Căn góc trên bên trái
        child: Container(
          padding: const EdgeInsets.all(10.0),
          constraints: const BoxConstraints(
            //maxWidth: 800, // Giới hạn chiều rộng
            maxHeight: 400, // Giới hạn chiều cao
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start, // Căn sát phía trên
            children: [
              // Phần thông tin bên trái
              Flexible(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Căn trái
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        description,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.orange),
                          const SizedBox(width: 5),
                          const Text(
                            'Tuyệt vời',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildInfoColumn(Icons.timer, 'TIME:', prepTime),
                          _buildInfoColumn(Icons.people, 'GROUP:', cookTime),
                          _buildInfoColumn(Icons.directions_car, 'TRANSPORT:', feeds),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20), // Khoảng cách giữa thông tin và ảnh
              // Phần hình ảnh bên phải
              Flexible(
                flex: 3,
                child: Container(
                  alignment: Alignment.topCenter, // Đặt ảnh sát trên
                  child: Image.asset(
                    'assets/vinh-Ha-Long.jpg',
                    fit: BoxFit.contain,
                    //width: MediaQuery.of(context).size.width * 0.3,
                    //height: MediaQuery.of(context).size.height * 0.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoColumn(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
