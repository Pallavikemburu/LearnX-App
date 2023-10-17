import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learnx/LoginPage.dart';

class Signup extends StatefulWidget{
  const Signup({super.key});
  @override
  State<Signup> createState() => _SignupState();
}
class _SignupState extends State<Signup>{
  final _email=TextEditingController();
  final _password=TextEditingController();
  final _formkey=GlobalKey<FormState>();

  Future<void> registerUser() async {
    final FirebaseAuth user = await FirebaseAuth.instance;
    try {
        user.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      ).then((val){
        showCustomSnackBar('Registration successful', Colors.green);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));
      });
    }
    catch (e) {
      showCustomSnackBar('Registration error: $e', Colors.purple);
    }
  }

  void showCustomSnackBar(String string, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Container(
          child: Text(
            string,
            style: TextStyle(
              color: color == Colors.red ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

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
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _email,
                    decoration: InputDecoration(
                      icon: Icon(CupertinoIcons.mail_solid),
                    ),
                    validator: (val)=>val!.isEmpty?"Enter Valid Email":null,
                  ),
                  TextFormField(
                    controller: _password,
                    decoration: InputDecoration(
                      icon: Icon(CupertinoIcons.padlock_solid),
                    ),
                    validator: (val)=>val!.isEmpty?"Enter Valid Password":null,
                  ),
                  ElevatedButton(
                    onPressed: (){
                      if (_formkey.currentState!.validate()){
                        registerUser();
                      }
                    },
                    child: Text("SignUp")
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}