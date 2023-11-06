import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'ExplorePage.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage>{
  @override
  int selectedPageIndex = 0;

  Color tc = const Color.fromARGB(255, 0, 63, 254);
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
    return Scaffold(
      body: [
        ExplorePage(),
        Course(wi*0.5,wi*0.5),
        Course(wi*0.5,wi*0.5),
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
}