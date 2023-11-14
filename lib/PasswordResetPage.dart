import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnx/LoginPage.dart';

class PasswordReset extends StatefulWidget{
  const PasswordReset({super.key});
  @override
  State<PasswordReset> createState() => _PasswordResetState();
}
class _PasswordResetState extends State<PasswordReset>{
  final _email=TextEditingController();
  final _formkey=GlobalKey<FormState>();
  final _focusNode = FocusNode();

  Future<void> resetPassword() async {
    final FirebaseAuth user = await FirebaseAuth.instance;
    try {
      user.sendPasswordResetEmail(
        email: _email.text,
      ).then((val){
        showCustomSnackBar('Check your email!', Colors.green);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));
      }).onError((error, stackTrace){
        showCustomSnackBar('try again!', Colors.purple);
      });
    }
    catch (e) {
      showCustomSnackBar('Email not sent, try again!', Colors.purple);
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
        resizeToAvoidBottomInset: false,
        // backgroundColor: Colors.orangeAccent,
        body: Stack(
          children: [
             Container(
        height: hi*0.30,
        width: wi,
        decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage("https://cdni.iconscout.com/illustration/premium/thumb/forgot-password-mobile-8044866-6430775.png?f=webp"),
        fit: BoxFit.contain, alignment: Alignment.topCenter,),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(wi*0.25),bottomRight:Radius.circular(wi*0.25), ),
        color: Colors.teal[400],
        )
       ),

     SizedBox(
    height: hi,
    width: wi,
    child: Padding(
    padding: EdgeInsets.symmetric(horizontal: wi*0.03),
    child: Form(
    key: _formkey,
    child: Center(
    child: Column(
    children: [
    SizedBox(height: hi*0.32,),
    Text(
    "Forgot your Password ?",
    style: GoogleFonts.poppins(
    textStyle: TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: wi*0.06,
    )
    ),
    ),
     // Text("Did you forgot your password?",style:GoogleFonts.poppins(textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize:wi*0.045),),),
      SizedBox(height: hi*0.025,),
      Center(child: Text("That's ok...",style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: wi*0.035),)),),
      SizedBox(height: hi*0.01,),
      Text("Just enter the email address you've used to",style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: wi*0.035),)),
      SizedBox(height: hi*0.01,),
      Text("register with us and we'll send you a reset link!",style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: wi*0.035),)),
      SizedBox(height: hi*0.03,),

      Padding(
        padding:  EdgeInsets.symmetric(horizontal: wi*0.02),
        child: TextFormField(
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

    ),
      ),//email


    SizedBox(height: hi*0.07,),


    InkWell(
    onTap: (){
    if (_formkey.currentState!.validate()){
    resetPassword();
    }
    },
    child: Container(
    width: wi*0.65,
    height: hi*0.05,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(hi*0.025),
  //  border: Border.all(color: Colors.orangeAccent),
    color: Color.fromARGB(255,240,88,69),

    ),
    child: Center(
    child: Text(
    "SUBMIT",
    textAlign: TextAlign.center,
    style: GoogleFonts.poppins(
    textStyle: TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: hi*0.03,
    )
    ),
    ),
    ),
    ),
    ),//Sign in
    SizedBox(height: hi*0.07,),

    ],
    ),
    ),
    )
    ),
    ),

    ]

    ),
        )
    );
  }
}