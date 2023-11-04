import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learnx/HomePage.dart';
import 'package:learnx/welcome_page.dart';
class Auth_change extends StatefulWidget {
  const Auth_change({super.key});

  @override
  State<Auth_change> createState() => _Auth_changeState();
}

class _Auth_changeState extends State<Auth_change> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData)
            {
              return const HomePage();
            }
          else
            {
              return const MyHome();
            }
        }
    );
  }
}
