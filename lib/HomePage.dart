import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:learnx/settings_ui.dart';
import 'ExplorePage.dart';
import 'LearnPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference dbE = FirebaseFirestore.instance.collection('Courses');

List<String> cid = [];
Future<void> getCid() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('Courses').get();
  querySnapshot.docs.forEach((document){
    cid.add(document.id);
    //print("_____________________________________${cid}");
  });
}

class HomePage extends StatefulWidget{
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage>{

  late Future<void> _getCidFuture;
  @override
  void initState() {
    super.initState();
    _getCidFuture = getCid();
  }
  int selectedPageIndex = 0;
  Color tc = const Color.fromARGB(255, 0, 63, 254);

  @override

  Card Course(double wi,double hi){
    return Card(
      elevation: 20,
      shadowColor: Colors.grey,
      child: Container(
        width: wi,
        height: hi,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.green,
        ),
        child: Text("C++"),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    double wi = MediaQuery.of(context).size.width;
    double hi = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: _getCidFuture,
      builder: (context,snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: SizedBox(
              width: wi*0.3,
              height: wi*0.3,
              child: CircularProgressIndicator(),
            ),
          );
        }
        else{
          return Scaffold(
            body: [
              ExplorePage(),
              LearnPage(),
              settings_page(),
            ][selectedPageIndex],
            bottomNavigationBar: NavigationBar(
              backgroundColor: Colors.white,
              shadowColor: Colors.grey,
              elevation: 0.4,
              selectedIndex: selectedPageIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  selectedPageIndex = index;
                });
              },
              destinations: <NavigationDestination>[
                NavigationDestination(
                  selectedIcon: Icon(
                    CupertinoIcons.compass_fill,
                    color: tc,
                  ),
                  icon: Icon(CupertinoIcons.compass),

                  label: 'Explore',
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    CupertinoIcons.book_fill,
                    color: tc,
                  ),
                  icon: Icon(
                    CupertinoIcons.book,
                  ),
                  label: 'Learn',
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    CupertinoIcons.person_alt,
                    color: tc,
                  ),
                  icon: Icon(
                    CupertinoIcons.person_alt_circle,
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          );
        }
      },
    );
  }
}