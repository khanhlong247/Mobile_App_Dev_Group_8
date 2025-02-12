// travel_data.dart

/*final List<Map<String, String>> travelHistory = [
  {
    'title': 'Hà Giang Loop',
    'description': 'Khám phá cung đường đẹp nhất miền Bắc Việt Nam.',
    'prepTime': '3 ngày',
    'cookTime': '2 người',
    'feeds': 'Xe máy',
    'imageUrl': 'assets/ha-giang.jpg',
  },
  {
    'title': 'Vịnh Hạ Long',
    'description': 'Kỳ quan thiên nhiên thế giới với những hòn đảo tuyệt đẹp.',
    'prepTime': '1 ngày',
    'cookTime': '4 người',
    'feeds': 'Tàu thuyền',
    'imageUrl': 'assets/vinh-Ha-Long.jpg',
  },
  {
    'title': 'Đà Lạt',
    'description': 'Thành phố sương mù với khí hậu mát mẻ quanh năm.',
    'prepTime': '2 ngày',
    'cookTime': '3 người',
    'feeds': 'Ô tô',
    'imageUrl': 'assets/da-lat.jpg',
  },
  {
    'title': 'Hội An',
    'description': 'Phố cổ Hội An, nơi lưu giữ văn hóa và kiến trúc truyền thống.',
    'prepTime': '1 ngày',
    'cookTime': '2 người',
    'feeds': 'Đi bộ',
    'imageUrl': 'assets/hoi-an.jpg',
  },
  // Thêm các chuyến đi khác nếu cần
];*/

// lib/data/travel_data.dart

import '../models/travel.dart';

final List<TravelDiary> travelDiaries = [
  TravelDiary(
    title: 'Nhật ký 1: Miền Bắc Việt Nam',
    description: 'Hành trình khám phá vẻ đẹp thiên nhiên miền Bắc.',
    trips: [
      Trip(
        name: "Vịnh Hạ Long",
        description: "Khám phá thành phố ánh sáng với những công trình kiến trúc tuyệt vời.",
        imagePath: "assets/vinh-Ha-Long.jpg",
        travelDate: "01/03/2024",
        travelDuration: "5 ngày 4 đêm",
        travelMode: "Ô tô",
        rating: 5,
        reviews: 250,),
      Trip(
        name: "Hà Giang",
        description: "Khám phá thành phố ánh sáng với những công trình kiến trúc tuyệt vời.",
        imagePath: "assets/vinh-Ha-Long.jpg",
        travelDate: "01/03/2024",
        travelDuration: "5 ngày 4 đêm",
        travelMode: "Xe máy",
        rating: 4,
        reviews: 250,),
    ],
  ),
  TravelDiary(
    title: 'Nhật ký 2: Miền Trung Việt Nam',
    description: 'Hành trình khám phá vẻ đẹp cổ kính miền Trung.',
    trips: [
      Trip(
        name: "Hà Giang",
        description: "Khám phá thành phố ánh sáng với những công trình kiến trúc tuyệt vời.",
        imagePath: "assets/vinh-Ha-Long.jpg",
        travelDate: "01/03/2024",
        travelDuration: "5 ngày 4 đêm",
        travelMode: "Máy bay",
        rating: 5,
        reviews: 250,),
      Trip(
        name: "Hà Giang",
        description: "Khám phá thành phố ánh sáng với những công trình kiến trúc tuyệt vời.",
        imagePath: "assets/vinh-Ha-Long.jpg",
        travelDate: "01/03/2024",
        travelDuration: "5 ngày 4 đêm",
        travelMode: "Máy bay",
        rating: 5,
        reviews: 250,),
    ],
  ),
];

