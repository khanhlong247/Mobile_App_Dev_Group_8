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
      appBar: AppBar(
        title: const Text("Danh sách Chuyến Đi"),
      ),
      body: ListView.builder(
        itemCount: diary.trips.length,
        itemBuilder: (context, index) {
          final trip = diary.trips[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TripDetailPage(trip: trip),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // Hình ảnh
                  Expanded(
                    child: Image.network(
                      trip.imagePath,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Chi tiết
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Điểm đến
                        Text(
                          trip.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        // Mô tả
                        Text(trip.description),
                        const SizedBox(height: 10),
                        // Đánh giá
                        Row(
                          children: [
                            Row(
                              children: List.generate(
                                5,
                                (star) => Icon(
                                  Icons.star,
                                  color: star < trip.rating
                                      ? Colors.yellow
                                      : Colors.grey,
                                  size: 16,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text('${trip.reviews} Reviews'),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Thông tin thêm
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const Icon(Icons.date_range, size: 16),
                                Text(' ${trip.travelDate}'),
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(Icons.access_time, size: 16),
                                Text(' ${trip.travelDuration}'),
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(Icons.directions_car, size: 16),
                                Text(' ${trip.travelMode}'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


/*import 'package:flutter/material.dart';
//import '../data/travel_list.dart';
import '../models/travel.dart';
import 'trip_detail_page.dart';

class TripListPage extends StatelessWidget {
  final TravelDiary diary;

  const TripListPage({super.key, required this.diary});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách Chuyến Đi"),
      ),
      body: ListView.builder(
        itemCount: diary.trips.length,
        itemBuilder: (context, index) {
          final trip = diary.trips[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
      
              children: [
                // Hình ảnh
                Expanded(
                  child: Image.network(
                    trip.imagePath,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 8),
                // Chi tiết
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Điểm đến
                      Text(
                        trip.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Mô tả
                      Text(trip.description),
                      const SizedBox(height: 10),
                      // Đánh giá
                      Row(
                        children: [
                          Row(
                            children: List.generate(
                              5,
                              (star) => Icon(
                                Icons.star,
                                color: star < trip.rating
                                    ? Colors.yellow
                                    : Colors.grey,
                                size: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text('${trip.reviews} Reviews'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Thông tin thêm
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const Icon(Icons.date_range, size: 16),
                              Text(' ${trip.travelDate}'),
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(Icons.access_time, size: 16),
                              Text(' ${trip.travelDuration}'),
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(Icons.directions_car, size: 16),
                              Text(' ${trip.travelMode}'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}*/

/*class TripListPage extends StatelessWidget {
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
}*/


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