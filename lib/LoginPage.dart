import 'package:flutter/material.dart';

class Login extends StatefulWidget{
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login>{
  @override
  Widget build(BuildContext context){
    double wi = MediaQuery.of(context).size.width;
    double hi = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      body: Center(
        child: Card(
          elevation: 15,
          shadowColor: Colors.grey,
          child: Container(
            width: wi*0.85,
            height: hi*0.8,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: hi*0.07,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person,size: hi*0.09,color: Colors.white,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}