import 'package:blog_app/screens/add_post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:blog_app/screens/login_screen.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final dbRef = FirebaseDatabase.instance.ref().child('Post');
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController searchController = TextEditingController();
  String search = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: Color(0xfff9fafc),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.deepOrange,
          title: Text('New Blogs'),
          centerTitle: true,
          actions: [
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddPostScreen()));
                
              },
              child: Icon(Icons.add),
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: (){
                auth.signOut().then((value){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                });
              },
              child: Icon(Icons.logout),
            ),
            SizedBox(width: 20),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: searchController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Search with blog title',
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (String value) {
                  search = value;
                },
                
              ),
              Expanded(
                child: FirebaseAnimatedList(
                  query: dbRef.child('Post List'),
                  itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                    String tempTitle = (snapshot.value as Map)['pTitle'] ?? '';
                    if (searchController.text.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                child: FadeInImage.assetNetwork(
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width * 1,
                                  height: MediaQuery.of(context).size.height * .25,
                                  placeholder: 'assets/images/blogger.png', 
                                  image: snapshot.value != null ? (snapshot.value as Map)['pImage'] ?? '' : '', 
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(snapshot.value != null ? (snapshot.value as Map)['pTitle'] ?? '' : '', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(snapshot.value != null ? (snapshot.value as Map)['pDescription'] ?? '' : '', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15)),
                              ),
                              
                            ],
                          ),
                        ),
                      ); 
                    } else if (tempTitle.toLowerCase().contains(searchController.text.toString())) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                child: FadeInImage.assetNetwork(
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width * 1,
                                  height: MediaQuery.of(context).size.height * .25,
                                  placeholder: 'assets/images/blogger.png', 
                                  image: snapshot.value != null ? (snapshot.value as Map)['pImage'] ?? '' : '', 
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(snapshot.value != null ? (snapshot.value as Map)['pTitle'] ?? '' : '', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(snapshot.value != null ? (snapshot.value as Map)['pDescription'] ?? '' : '', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15)),
                              ),
                              
                            ],
                          ),
                        ),
                      ); 
                    } else {
                      return Container(

                      );
                    }
                    
                  },
                ),
              ),
            ],
          ),
        ), 
      ),
    ); 
  }
}