import 'package:flutter/material.dart';
//import '../data/travel_list.dart';
import '../models/travel.dart';
import 'trip_detail_page.dart';

class TripListPage extends StatelessWidget {
  final TravelDiary diary;

  const TripListPage({super.key, required this.diary});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(diary.title)),
      body: ListView.builder(
        itemCount: diary.trips.length,
        itemBuilder: (context, index) {
          final trip = diary.trips[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: Image.asset(
                trip.imagePath,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(trip.name),
              onTap: () {
                // Điều hướng đến chi tiết chuyến đi
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TripDetailPage(trip: trip)
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


/*class TripListPage extends StatefulWidget {
  final TravelDiary diary;

  const TripListPage({super.key, required this.diary});

  @override
  _TripListPageState createState() => _TripListPageState();
}

class _TripListPageState extends State<TripListPage> {
  final List<Trip> _trips = [];

  @override
  void initState() {
    super.initState();
    _trips.addAll(widget.diary.trips); // Lấy dữ liệu chuyến đi từ diary
  }

  void _addTrip() {
    String tripName = '';
    String imagePath = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Thêm Chuyến Đi'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Tên Chuyến Đi'),
                onChanged: (value) {
                  tripName = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Đường Dẫn Ảnh'),
                onChanged: (value) {
                  imagePath = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                if (tripName.isNotEmpty && imagePath.isNotEmpty) {
                  setState(() {
                    _trips.add(Trip(name: tripName, imagePath: imagePath));
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Thêm'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.diary.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addTrip, // Gọi hàm thêm chuyến đi khi nhấn nút "+"
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _trips.length,
        itemBuilder: (context, index) {
          final trip = _trips[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: trip.imagePath.isNotEmpty
                  ? Image.asset(trip.imagePath, width: 50, height: 50, fit: BoxFit.cover)
                  : const Icon(Icons.image),
              title: Text(trip.name),
            ),
          );
        },
      ),
    );
  }
}*/