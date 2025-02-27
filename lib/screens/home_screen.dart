import 'package:blog_app/controllers/topic/topic_detail.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:blog_app/widgets/custom_bottom_nav_bar.dart';
import 'package:blog_app/controllers/topic/edit_topic.dart';

// Thêm import FirebaseAuth:
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Lấy userId của tài khoản hiện tại:
  final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

  // Trước đây: final dbRef = FirebaseDatabase.instance.ref().child('Topics');
  // Giờ thay thế bằng node theo user:
  final dbRef = FirebaseDatabase.instance
      .ref()
      .child('Users')
      .child(FirebaseAuth.instance.currentUser?.uid ?? '')
      .child('Topics');

  TextEditingController searchController = TextEditingController();
  String search = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepOrange,
        title: const Text('Travel Diary', style: TextStyle(color: Colors.white)),
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: 'Search travel',
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (String value) {
                setState(() {
                  search = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FirebaseAnimatedList(
                query: dbRef,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  Map topicData = snapshot.value as Map;
                  String tempTitle = topicData['tTitle'] ?? '';

                  if (searchController.text.isEmpty ||
                      tempTitle
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase())) {
                    return Card(
                      margin: const EdgeInsets.all(10),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(topicData['tTitle'] ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        subtitle: Text(topicData['tDescription'] ?? '',
                            style: const TextStyle(fontSize: 15)),
                        trailing: Wrap(
                          spacing: 8,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditTopicScreen(
                                      topicId: snapshot.key!,
                                      topicData: topicData,
                                    ),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                await dbRef.child(snapshot.key!).remove();
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TopicDetailScreen(
                                topicId: snapshot.key!,
                                topicData: topicData,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}
