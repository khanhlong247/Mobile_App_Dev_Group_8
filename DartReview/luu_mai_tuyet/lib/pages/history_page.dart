import 'package:flutter/material.dart';
import 'diary_detail_page.dart';
import '../data/travel_list.dart';
/**class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử chuyến đi'),
      ),
      body: ListView.builder(
        itemCount: travelHistory.length, // Sử dụng danh sách từ travel_data.dart
        itemBuilder: (context, index) {
          final trip = travelHistory[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  trip['imageUrl']!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(trip['title']!),
              subtitle: Text(trip['description']!),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DiaryDetailPage(
                      title: trip['title']!,
                      description: trip['description']!,
                      prepTime: trip['prepTime']!,
                      cookTime: trip['cookTime']!,
                      feeds: trip['feeds']!,
                      imageUrl: trip['imageUrl']!,
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
}*/

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

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
