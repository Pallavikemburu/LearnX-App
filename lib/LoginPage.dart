import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learnx/HomePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnx/SignupPage.dart';

class Login extends StatefulWidget{
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}


class _LoginState extends State<Login> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _resetmail=TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _password_visibility = true;
  IconData _passicon = Icons.remove_red_eye_rounded;

  Future<void> LoginUser() async {
    final FirebaseAuth user = await FirebaseAuth.instance;
    user.signInWithEmailAndPassword(
      email: _email.text,
      password: _password.text,
    ).then((val) {
      showCustomSnackBar('Login successful', Colors.green);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const HomePage()));
    }).onError((error, stackTrace) {
      showCustomSnackBar('Login failed!', Colors.red);
    });
  }


  void showCustomSnackBar(String string, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content:  Text(
            string,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        behavior:  SnackBarBehavior.floating,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    double wi = MediaQuery.of(context).size.width;
    double hi = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          body: SizedBox(
            height: hi,
            width: wi,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: wi*0.05),
                child: Form(
                  key: _formkey,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Login to your Account",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: hi*0.035,
                              )
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _email,
                          validator: (val) => val!.isEmpty ? "Please Enter Email" : null,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              CupertinoIcons.mail_solid,
                              size: hi*0.05,
                            ),
                            hintText: "Enter Your Email",
                            hintStyle: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade600,
                                fontSize: hi*0.025,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                            ),
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _password,
                          validator: (val) => val!.isEmpty ? "Please Enter Password" : null,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.account_circle_outlined),
                            hintText: "Enter Password",
                            hintStyle: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade600,
                                fontSize: hi*0.025,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            if (_formkey.currentState!.validate()){
                              LoginUser();
                            }
                          },
                          child: Container(
                            width: wi*0.75,
                            height: hi*0.05,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(hi*0.025),
                                color: Colors.lightBlue
                            ),
                            child: Text(
                              "SIGN IN",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: hi*0.03,
                                  )
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't Have an Account?",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: hi*0.02,
                                  )
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const Signup()));
                              },
                              child: Text(
                                "SIGN UP",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: hi*0.02,
                                    )
                                ),
                              ),
                            )
                          ],
                        )
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