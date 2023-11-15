import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learnx/HomePage.dart';
import 'package:google_fonts/google_fonts.dart';

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
      Navigator.pop(context);
      Navigator.popAndPushNamed(context, '5');
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
Future<TextField> MyTextFeild( int height, TextEditingController contoller, bool Ispassword ) async {
  return TextField(
    keyboardType: TextInputType.text,style:TextStyle(
      fontSize: height*0.02,
      fontWeight: FontWeight.bold
    ),
    controller: contoller,

  );
}
  @override
  Widget build(BuildContext context) {
    double wi = MediaQuery.of(context).size.width;
    double hi = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
       // backgroundColor: Colors.orangeAccent,
          body: Stack(
            children: [

              Container(
                height: hi*0.30,
                width: wi,
                decoration: BoxDecoration(
                  // image: DecorationImage(image: AssetImage("assets/images/Login.png"),
                  //     fit: BoxFit.contain,
                  //     alignment: Alignment.topCenter,),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(wi*0.25),bottomRight:Radius.circular(wi*0.25), ),
                  color: Colors.orangeAccent,
                )
              ),//Orange layyer
              Container(
                height: hi*0.25,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/images/Log_.png"),alignment: Alignment.topCenter),

                ),
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
                            SizedBox(height: hi*0.225,),
                            Text(
                              "Login To Your Account",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: wi*0.039,
                                  )
                              ),
                            ),//log in
                            SizedBox(height: hi*0.07,),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _email,
                              validator: (val) => val!.isEmpty ? "Please Enter Email" : null,
                              decoration: InputDecoration(

                                prefixIcon: Icon(
                                  CupertinoIcons.mail,size: hi*0.02,
                                ),
                                hintText: "Enter Your Email",
                                hintStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(

                                    color: Colors.grey.shade600,
                                    fontSize: hi*0.02,
                                  ),
                                ),

                              ),

                            ),//email
                            SizedBox(height: hi*0.07,),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _password,
                              obscureText: _password_visibility,
                              validator: (val) => val!.isEmpty ? "Please Enter Password" : null,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.account_circle_outlined),
                                hintText: "Enter Password",
                                hintStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(

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
                            ),//password
                            SizedBox(height: hi*0.07,child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap:(){
                                    Navigator.popAndPushNamed((context), "4");
                              },


                                  child: Text("Forgot Password?",style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: hi*0.017,
                                      color: Colors.blue,

                                    )
                                  ),),
                                ),
                              ],
                            ),),
                            InkWell(
                              onTap: (){
                                FocusScopeNode currentFocus = FocusScope.of(context);

                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                if (_formkey.currentState!.validate()){
                                  LoginUser();
                                }
                              },
                              child: Container(
                                width: wi*0.75,
                                height: hi*0.05,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(hi*0.025),
                                    //border: Border.all(color: Colors.black45),
                                    color: Colors.blue[400],

                                ),
                                child: Center(
                                  child: Text(
                                    "SIGN IN",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: hi*0.025,
                                        )
                                    ),
                                  ),
                                ),
                              ),
                            ),//Sign in
                            SizedBox(height: hi*0.07,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't Have an Account? ",
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
                                    Navigator.popAndPushNamed((context), "3");
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
                            ),//dont have an accounnt

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