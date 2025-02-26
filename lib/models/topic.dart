import 'post.dart';

class Topic {
  String tId;
  String title;
  String description;
  String tTime;
  List<Post> posts;

  Topic({
    required this.tId,
    required this.title,
    required this.description,
    required this.tTime,
    required this.posts,
  });

  factory Topic.fromMap(String tId, Map<dynamic, dynamic> map) {
    List<Post> postList = [];
    if (map['Post List'] != null) {
      Map<dynamic, dynamic> pMap = map['Post List'];
      pMap.forEach((key, value) {
        Post p = Post.fromMap(value);
        postList.add(p);
      });
    }
    return Topic(
      tId: tId,
      title: map['tTitle'] ?? '',
      description: map['tDescription'] ?? '',
      tTime: map['tTime'] ?? '',
      posts: postList,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> postMap = {};
    for (var post in posts) {
      postMap[post.pId] = post.toMap();
    }
    return {
      'tId': tId,
      'tTitle': title,
      'tDescription': description,
      'tTime': tTime,
      'Post List': postMap,
    };
  }
}
