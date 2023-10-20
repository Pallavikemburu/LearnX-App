import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learnx/HomePage.dart';
import 'package:learnx/LoginPage.dart';
import 'package:learnx/PasswordResetPage.dart';

class Signup extends StatefulWidget{
  const Signup({super.key});
  @override
  State<Signup> createState() => _SignupState();
}
class _SignupState extends State<Signup>{
  final _email=TextEditingController();
  final _password=TextEditingController();
  final _username=TextEditingController();
  final _formkey=GlobalKey<FormState>();
  bool _password_visibility = true;
  IconData _passicon = Icons.remove_red_eye_rounded;

  Future<void> registerUser() async {
    final FirebaseAuth user = await FirebaseAuth.instance;
    try {
        user.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      ).then((val){
        showCustomSnackBar('Registration successful', Colors.green);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));
      }).onError((error, stackTrace){
          showCustomSnackBar('Registration error: $error', Colors.purple);
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
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 230, 230, 230),
          resizeToAvoidBottomInset : false,
          body: Container(
            height: hi,
            width: wi,


            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formkey,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Create an Account",
                          style: TextStyle(fontSize: 32),
                        ),


                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _username,

                          validator: (val) =>
                          val!.isEmpty
                              ? "Please Enter Name"
                              : null,
                          decoration: const InputDecoration(
                            //labelText: "Enter Email",
                            suffixIcon: Icon(Icons.account_circle_outlined),
                            //helperText: "Email",
                            hintText: "Enter Name",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10)),
                                borderSide: BorderSide(
                                    color: Colors.blue
                                )
                            ),
                          ),
                        ),


                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _email,

                          validator: (val) =>
                          val!.isEmpty
                              ? "Please Enter Email"
                              : null,
                          decoration: const InputDecoration(
                            //labelText: "Enter Email",
                            suffixIcon: Icon(Icons.mail),
                            //helperText: "Email",
                            hintText: "Enter Email",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10)),
                                borderSide: BorderSide(
                                    color: Colors.blue
                                )
                            ),
                          ),
                        ),


                        TextFormField(
                          controller: _password,
                          obscureText: _password_visibility,

                          validator: (val) =>
                          val!.isEmpty
                              ? "Please Enter Password"
                              : null,
                          decoration: InputDecoration(
                            // labelText: "Enter Password",
                            suffixIcon: IconButton(onPressed: () {
                              setState(() {
                                _password_visibility = !_password_visibility;
                                if (_passicon == Icons.remove_red_eye_rounded){
                                  _passicon = Icons.visibility_off; }
                                else{
                                  _passicon = Icons.remove_red_eye_rounded; }
                              });
                            }, icon: Icon(_passicon),),
                            helperText: "min. 8 characters",
                            hintText: "Enter Password",
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10)),
                                borderSide: BorderSide(
                                    color: Colors.blue
                                )
                            ),
                          ),
                        ),



                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => const HomePage()));
                          },
                          child: Container(
                            width: wi * 0.8,
                            height: hi * 0.05,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 0, 63, 254),
                              borderRadius: BorderRadius.circular(hi * 0.005),
                            ),
                            child: const Center(
                              child: Text(
                                  'SIGN UP',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white,
                                  )
                              ),
                            ),
                          ),
                        ),


                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => const Login()));
                          },
                          child: const Text.rich(
                            TextSpan(
                                text: 'Already have an account? ',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                                children: [
                                  TextSpan(
                                      text: ' Signin',
                                      style: TextStyle(color: Colors.blueAccent,
                                          fontSize: 20)
                                  ),
                                ]
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),
                )
            ),
          )
      ),
    );
  }
}