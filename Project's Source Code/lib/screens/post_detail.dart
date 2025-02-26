import 'package:flutter/material.dart';
import 'package:blog_app/models/post.dart';

class PostDetailScreen extends StatelessWidget {
  final Map postData;

  const PostDetailScreen({Key? key, required this.postData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Post post = Post.fromMap(postData);

    String title = post.pTitle;
    String description = post.pDescription;
    List<String> images = post.pImages;
    String imageUrl = images.isNotEmpty ? images[0] : '';
    String pDate = post.pDate;
    int pDuration = post.pDuration;
    String pMode = post.pMode;
    double pRating = post.pRating;
    int pReviews = post.pReviews;

    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Post: $title', style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepOrange,
        elevation: 5,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              images.isNotEmpty
                  ? Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: SizedBox(
                        height: 250,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                images[index],
                                width: 250,
                                height: 250,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : Container(
                      height: 200,
                      color: Colors.grey,
                    ),
              const SizedBox(height: 20),
              Text(
                'Description: $description',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text("Date: $pDate", style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 5),
              Text("Duration: $pDuration", style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 5),
              Text("Mode: $pMode", style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 5),
              Text("Rating: $pRating", style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 5),
              Text("Reviews: $pReviews", style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
