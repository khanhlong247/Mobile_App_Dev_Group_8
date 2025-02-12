// lib/models/travel.dart

class TravelDiary {
  //final int id;
  final String title;
  final String description;
  final List<Trip> trips;

  TravelDiary({
    //required this.id,
    required this.title,
    required this.description,
    required this.trips,
  });
}

/*class Trip {
  final String name;
  final String imagePath;

  Trip({required this.name, required this.imagePath});
}*/
class Trip {
  final String name; // Điểm đến
  final String description; // Mô tả
  final String imagePath; // Đường dẫn hình ảnh
  final String travelDate; // Ngày đi
  final String travelDuration; // Thời gian chuyến đi
  final String travelMode; // Phương tiện di chuyển
  final int rating; // Đánh giá (sao)
  final int reviews; // Số lượt đánh giá

  Trip({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.travelDate,
    required this.travelDuration,
    required this.travelMode,
    required this.rating,
    required this.reviews,
  });
}