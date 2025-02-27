class Post {
  String pId;
  List<String> pImages;
  String pTime;
  String pTitle;
  String pDescription;
  String pEmail;
  String uid;
  String pDate;
  int pDuration;
  String pMode;
  double pRating;
  int pReviews;

  Post({
    required this.pId,
    required this.pImages,
    required this.pTime,
    required this.pTitle,
    required this.pDescription,
    required this.pEmail,
    required this.uid,
    required this.pDate,
    required this.pDuration,
    required this.pMode,
    required this.pRating,
    required this.pReviews,
  });

  factory Post.fromMap(Map<dynamic, dynamic> map) {
    return Post(
      pId: map['pId'] ?? '',
      pImages: map['pImages'] != null ? List<String>.from(map['pImages']) : [],
      pTime: map['pTime'] ?? '',
      pTitle: map['pTitle'] ?? '',
      pDescription: map['pDescription'] ?? '',
      pEmail: map['pEmail'] ?? '',
      uid: map['uid'] ?? '',
      pDate: map['pDate'] ?? '',
      pDuration: map['pDuration'] is int
          ? map['pDuration']
          : int.tryParse(map['pDuration']?.toString() ?? '0') ?? 0,
      pMode: map['pMode'] ?? '',
      pRating: map['pRating'] is double
          ? map['pRating']
          : double.tryParse(map['pRating']?.toString() ?? '0') ?? 0.0,
      pReviews: map['pReviews'] is int
          ? map['pReviews']
          : int.tryParse(map['pReviews']?.toString() ?? '0') ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pId': pId,
      'pImages': pImages,
      'pTime': pTime,
      'pTitle': pTitle,
      'pDescription': pDescription,
      'pEmail': pEmail,
      'uid': uid,
      'pDate': pDate,
      'pDuration': pDuration,
      'pMode': pMode,
      'pRating': pRating,
      'pReviews': pReviews,
    };
  }
}
