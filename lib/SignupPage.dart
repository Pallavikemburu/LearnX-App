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
  bool _password_visibilityi = true;

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
      print(error);
      showCustomSnackBar("Please Check The Details", Colors.red);
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
        //backgroundColor: Colors.blue,
        //backgroundColor: const Color.fromARGB(185, 255, 253, 253),
        resizeToAvoidBottomInset : false,
        body: Stack(
          children: [
            Container(
                height: hi*0.30,
                width: wi,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(wi*0.25),bottomRight:Radius.circular(wi*0.25), ),
                  //image: DecorationImage(image: AssetImage("assets/images/Signup.png"),),
                  color: Colors.blue,
                )
            ),
            Container(
              height: hi*0.25,
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(wi*0.25),bottomRight:Radius.circular(wi*0.25), ),
                  image: DecorationImage(image: AssetImage("assets/images/Signup.png"),),
                 // color: Colors.blue,
                )
            ),
            SizedBox(

              height: hi,
              width: wi,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: wi*0.05),
                child: Form(
                  key: _formkey,
                  child: Center(
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: hi*0.25,),
                        Text(
                          "Create an Account",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: wi*0.064,
                              )
                          ),
                        ),//create an account
                        SizedBox(height: hi*0.06,),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _email,
                          validator: (val) => val!.isEmpty ? "Please Enter Email" : null,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              CupertinoIcons.mail_solid,
                              size: hi*0.02,
                            ),
                            hintText: "Enter Your Email",
                            hintStyle: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  //fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade600,
                                  fontSize: hi*0.02,
                                ),
                            ),

                          ),
                        ),//email
                        SizedBox(height: hi*0.04,),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _password,
                          obscureText: _password_visibilityi,
                          validator: (val) => val!.isEmpty ? "Please Enter Password" : null,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.password),
                            hintText: "Enter Password",
                            suffixIcon: GestureDetector(
                              onTap: (){
                                setState(() {
                                  if(_password_visibilityi==true){
                                    _password_visibilityi=false;
                                  }
                                  else{
                                    _password_visibilityi=true;
                                  }
                                });
                              },
                              child: (_password_visibilityi)? Icon(Icons.visibility) : Icon(Icons.visibility_off)
                            ),
                            hintStyle: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: hi*0.02,
                              ),

                            ),

                          ),
                        ), //passwd
                        SizedBox(height: hi*0.04,),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          obscureText: _password_visibility,
                          controller: _conf_password,
                          validator: (val) => val!.isEmpty ? "Re Enter Password" : null,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.password),
                            hintText: "Confirm Password",
                            hintStyle: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                //fontWeight: FontWeight.bold,
                                color: Colors.grey.shade600,
                                fontSize: hi*0.02,
                              ),

                            ),
                            suffixIcon: GestureDetector(
                              onTap: (){
                                setState(() {
                                  if(_password_visibility==true){
                                    _password_visibility=false;
                                  }
                                  else{
                                    _password_visibility=true;
                                  }
                                });
                              },
                                child: (_password_visibility)? Icon(Icons.visibility) : Icon(Icons.visibility_off)

                            ),

                          ),
                        ),//confirm passwd
                        SizedBox(height: hi*0.04,),
                        InkWell(
                          onTap: (){
                            FocusScopeNode currentFocus = FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
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
                            child: Center(
                              child: Text(
                                "SIGN UP",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: hi*0.025,
                                    )
                                ),
                              ),
                            ),
                          ),
                        ),//signup
                        SizedBox(height: hi*0.05,),
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
                                Navigator.popAndPushNamed((context), "2");
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
                        )//already have an account
                      ],
                    ),
                  ),
                )
              ),
            ),
          ],
        )
      ),
    );
  }
}