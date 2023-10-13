import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomeState();
}
class _HomeState extends State<HomePage>{
  @override
  int selectedPageIndex = 0;
  Color tc = const Color.fromARGB(255, 0, 63, 254);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const [
        Center(
          child: Text(
            'Home',
          ),
        ),
        Center(
          child: Text(
            'Account',
          ),
        ),
        Center(
          child: Text(
            'Menu',
          ),
        ),
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