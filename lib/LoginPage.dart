import 'package:flutter/material.dart';
import 'package:learnx/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget{
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login>{
  final email=TextEditingController();
  final password=TextEditingController();
  final _formkey=GlobalKey<FormState>();
  bool password_visibilty=true;
  IconData passicon=Icons.remove_red_eye_rounded;
  bool isRegistering = false;
  bool check = false;

  Future<void> registerUser() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isRegistering = true;
      });
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        String message = userCredential.toString();
        setState(() {});
        check = true;
        showCustomSnackBar(context, 'Registration successful', Colors.green);
      } catch (e) {
        showCustomSnackBar(context, 'Registration error: $e', Colors.purple);
      } finally {
        setState(() {
          isRegistering = false;
        });
      }
    } else {
      setState(() {
        check=false;
      });
      showCustomSnackBar(context, 'Please fill in correct information', Colors.red);
    }
  }

  void showCustomSnackBar(BuildContext context, String string, Color color) {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: hi*0.07,
                  backgroundColor: Colors.grey,
                  child: Icon(
                      Icons.person,size: hi*0.09,
                      color: Color.fromARGB(255, 0, 63, 254)
                  ),
                ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: email,
                      validator:(val)=> val!.isEmpty ? "Please Enter Email" : null,
                      decoration: const InputDecoration(
                        labelText: "Email ID",
                        prefixIcon: Icon(Icons.mail),
                        //helperText: "Email",
                       // hintText: "E mail",
                      ),
                     // maxLength: 40,
                    ),
                  ),
                  SizedBox(height: hi*0.025,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: password,
                      obscureText: password_visibilty,
                      validator:(val)=> val!.isEmpty ? "Please Enter Password" : null,
                      decoration: InputDecoration(
                        labelText: "Enter Password",
                        prefixIcon: IconButton(onPressed: (){
                          setState(() {
                            password_visibilty=!password_visibilty;
                            if(passicon==Icons.remove_red_eye_rounded) {
                              passicon=Icons.visibility_off;
                            } else {
                              passicon=Icons.remove_red_eye_rounded;
                            }
                          });
                        },icon: Icon(passicon),),
                        //helperText: "password",
                       // hintText: "Password",
                      ),
                     // maxLength: 40,
                    ),
                  ),

                  SizedBox(height: hi*0.03,),
                  ElevatedButton(onPressed: (){
                    if(_formkey.currentState!.validate())
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                    }
                  },
                      child: const Text("Login",style: TextStyle(color: Colors.white, fontSize: 20),)
                  ),
                  SizedBox(height: hi*0.025,),
                /*  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                  }, child: Text("Sign Up",style: TextStyle(color: Color.fromARGB(255,0, 63, 254)),))   */

                  Divider(
                    color: Colors.black45,
                    thickness: 2,
                    indent: wi*0.1,
                    endIndent: wi*0.1,
                  ),
                  SizedBox(height: hi*0.05,),
                  Container(
                    height: hi*0.05,
                    width: wi*0.6,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 0, 63, 254)
                      ),
                      borderRadius: BorderRadius.circular(100.0),
                      color: Colors.white,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(Icons.account_box_outlined,color: Colors.red,),
                        Center(
                          child: Text(
                            'COTINUE WITH GOOGLE',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 63, 254),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            ]
          ),
        ),
      ),
      ),
    );
  }
}