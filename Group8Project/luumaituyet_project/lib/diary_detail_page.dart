import 'package:flutter/material.dart';

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
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            // Cột chứa thông tin
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      Text('Tuyệt vời', style: TextStyle(color: Colors.grey)),
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
            // Ảnh bên phải
            Expanded(
              flex: 3,
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
          ],
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
