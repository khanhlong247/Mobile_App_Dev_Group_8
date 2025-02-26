import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:blog_app/screens/add_post.dart';
import 'package:blog_app/screens/post_detail.dart';
import 'package:blog_app/screens/edit_post.dart';
import 'package:blog_app/widgets/custom_bottom_nav_bar.dart';

class TopicDetailScreen extends StatelessWidget {
  final String topicId;
  final Map topicData;

  const TopicDetailScreen({Key? key, required this.topicId, required this.topicData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = topicData['tTitle'] ?? 'No Title';
    String description = topicData['tDescription'] ?? 'No Description';

    DatabaseReference postListRef = FirebaseDatabase.instance
        .ref()
        .child('Topics')
        .child(topicId)
        .child('Post List');

    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Diary: $title', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepOrange,
        elevation: 5,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    description,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPostScreen(topicId: topicId),
                    ),
                  );
                },
                child: const Text('Add Post', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Posts',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 400,
                child: FirebaseAnimatedList(
                  query: postListRef,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                    Map rawData = snapshot.value as Map;
                    String postTitle = rawData['pTitle'] ?? 'No Title';
                    String postDescription = rawData['pDescription'] ?? '';
                    List<dynamic> images = rawData['pImages'] ?? [];
                    String imageUrl = images.isNotEmpty ? images[0] : '';
                    
                    int pDuration = rawData['pDuration'] is int
                        ? rawData['pDuration']
                        : int.tryParse(rawData['pDuration']?.toString() ?? '0') ?? 0;
                    String pMode = rawData['pMode']?.toString() ?? '';
                    
                    double pRating = 0.0;
                    if (rawData['pRating'] != null) {
                      pRating = double.tryParse(rawData['pRating'].toString()) ?? 0.0;
                    }
                    
                    List<Widget> buildStarRating(double rating) {
                      List<Widget> stars = [];
                      int fullStars = rating.floor();
                      for (int i = 0; i < fullStars; i++) {
                        stars.add(const Icon(Icons.star, color: Colors.yellow, size: 16));
                      }
                      if ((rating - fullStars) >= 0.5) {
                        stars.add(const Icon(Icons.star_half, color: Colors.yellow, size: 16));
                      }
                      return stars;
                    }

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostDetailScreen(postData: rawData),
                          ),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.all(8),
                        elevation: 5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      postTitle,
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      postDescription,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        ...buildStarRating(pRating),
                                        const SizedBox(width: 6),
                                        Text('$pRating', style: const TextStyle(fontSize: 14)),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.access_time, size: 16),
                                        const SizedBox(width: 4),
                                        Text('$pDuration'),
                                        const SizedBox(width: 16),
                                        const Icon(Icons.directions_car, size: 16),
                                        const SizedBox(width: 4),
                                        Text(pMode),
                                        const SizedBox(width: 16),
                                        IconButton(
                                          icon: const Icon(Icons.edit, color: Colors.blue),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => EditPostScreen(
                                                  topicId: topicId,
                                                  postId: rawData['pId'] ?? snapshot.key!,
                                                  postData: rawData,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete, color: Colors.red),
                                          onPressed: () async {
                                            await postListRef.child(snapshot.key!).remove();
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: imageUrl.isNotEmpty
                                    ? Image.network(
                                        imageUrl,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(
                                        width: 60,
                                        height: 60,
                                        color: Colors.grey,
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}
