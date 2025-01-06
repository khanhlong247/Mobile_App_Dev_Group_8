// Class representing the User
class User {
  String userId;
  String username;
  String email;
  Image? avatar;

  // Constructor
  User({
    required this.userId,
    required this.username,
    required this.email,
    this.avatar,
  });

  // Methods
  Journey createJourney(String journeyId, DateTime startTime) {
    return Journey(journeyId: journeyId, startTime: startTime, userId: userId);
  }

  Journey viewJourney(String journeyId) {
    // Logic to retrieve a specific journey (mocked here)
    print('Viewing journey $journeyId');
    return Journey(journeyId: journeyId, startTime: DateTime.now(), userId: userId);
  }

  void shareJourney(String journeyId, String platform) {
    print('Sharing journey $journeyId to $platform');
  }
}

// Class representing the Journey
class Journey {
  String journeyId;
  DateTime startTime;
  DateTime? endTime;
  double? totalDistance;
  List<Location> locations = [];
  String userId; // Link to the User

  // Constructor
  Journey({
    required this.journeyId,
    required this.startTime,
    this.endTime,
    this.totalDistance,
    required this.userId,
  });

  // Methods
  void addLocation(Location location) {
    locations.add(location);
  }

  List<Location> getRoute() {
    return locations;
  }

  void export(String format) {
    print('Exporting journey $journeyId in $format format');
  }
}

// Class representing the Location
class Location {
  String locationId;
  String name;
  String coordinates;
  DateTime timestamp;
  List<Image> photos = [];
  String? notes;

  // Constructor
  Location({
    required this.locationId,
    required this.name,
    required this.coordinates,
    required this.timestamp,
    this.notes,
  });

  // Methods
  void addPhoto(Image photo) {
    photos.add(photo);
  }

  void setNotes(String notes) {
    this.notes = notes;
  }

  Image edit(Image photo, String note) {
    print('Editing photo ${photo.imageId} with note: $note');
    photo.description = note;
    return photo;
  }
}

// Class representing the Image
class Image {
  String imageId;
  DateTime time;
  String? description;

  // Constructor
  Image({
    required this.imageId,
    required this.time,
    this.description,
  });

  // Methods
  void show() {
    print('Displaying image $imageId');
  }
}