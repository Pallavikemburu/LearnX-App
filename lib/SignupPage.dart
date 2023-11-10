import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnx/LoginPage.dart';

class Signup extends StatefulWidget{
  const Signup({super.key});
  @override
  State<Signup> createState() => _SignupState();
}
class _SignupState extends State<Signup>{
  final _email=TextEditingController();
  final _password=TextEditingController();
  final _conf_password=TextEditingController();
  final _formkey=GlobalKey<FormState>();
  bool _password_visibility = true;
  IconData _passicon = Icons.remove_red_eye_rounded;

  Future<void> registerUser() async {
    final FirebaseAuth user = FirebaseAuth.instance;
    user.createUserWithEmailAndPassword(
      email: _email.text,
      password: _password.text,
    ).then((val){
      showCustomSnackBar('SignUp successful', Colors.green);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));
    }).onError((error, stackTrace){
      showCustomSnackBar("Email Already Exists!", Colors.red);
    });
  }

  void showCustomSnackBar(String string, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(
          string,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 15,
              )
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
        backgroundColor: const Color.fromARGB(185, 255, 253, 253),
        resizeToAvoidBottomInset : true,
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
                      "Create an Account",
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
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _conf_password,
                      validator: (val) => val!.isEmpty ? "Re Enter Password" : null,
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.account_circle_outlined),
                        hintText: "Enter Password Again",
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
                          if (_password.text == _conf_password.text){
                            registerUser();
                          }
                          else{
                            showCustomSnackBar('Invalid Password',Colors.red);
                          }
                        }
                      },
                      child: Container(
                        width: wi*0.75,
                        height: hi*0.05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(hi*0.025),
                          color: Colors.orange
                        ),
                        child: Text(
                          "SIGN UP",
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
                          "Already Have an Account?",
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
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));
                          },
                          child: Text(
                            "SIGN IN",
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