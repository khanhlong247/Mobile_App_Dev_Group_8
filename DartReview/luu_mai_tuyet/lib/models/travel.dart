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

class Trip {
  final String name;
  final String imagePath;

  Trip({required this.name, required this.imagePath});
}
