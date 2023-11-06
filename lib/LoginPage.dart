import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learnx/HomePage.dart';
import 'package:learnx/SignupPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  bool _remember_me = false;

  Future<void> registerUser() async {
    final FirebaseAuth user = await FirebaseAuth.instance;
    try {
      user.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      ).then((val) {
        showCustomSnackBar('Registration successful', Colors.green);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }).onError((error, stackTrace) {
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
        content:  Text(
            string,
            style: TextStyle(
              color: color == Colors.red ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        behavior:  SnackBarBehavior.floating,
      ),
    );
  }

  Widget _welcome_back() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome back !',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height / 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }



  Widget _login_container(double hi,double wi) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: hi * 0.68,
            width: wi * 0.85,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Login", style: TextStyle(fontSize: hi/ 30),),
                    ],
                  ),


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Email"),
                          ],
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
                      ],
                    ),
                  ),



                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Password"),
                          ],
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
                            // helperText: "password",
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
                      ],
                    ),
                  ),



                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20 ,
                                child: Checkbox(
                                    activeColor:const Color(0xff2470c7),
                                    focusColor: Colors.blue,
                                    value: _remember_me,
                                    onChanged: (val) {
                                      setState(() {
                                        _remember_me = !_remember_me;
                                      });
                                    }),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text('Remember me')
                              ]
                          ),
                          GestureDetector(
                            onTap: () {
                              // print("hi");
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Enter registered Email"),
                                    content: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      controller: _resetmail,

                                      validator: (val) =>
                                      val!.isEmpty
                                          ? "Please Enter Email"
                                          : null,
                                      decoration: const InputDecoration(
                                        //labelText: "Enter Email",
                                       // suffixIcon: Icon(Icons.mail),
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
                                    actions: [
                                      ElevatedButton(onPressed: (){}, child: Text("Send")),
                                      ElevatedButton(onPressed: (){}, child: Text("Cancel")),
                                    ],
                                  );
                                }
                              );
                            },
                            child: Text("Forgot password?",style: TextStyle(color: Colors.blueAccent),),
                          ),
                          ]
                    ),
                  ),



                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: InkWell(
                      onTap: () {
                        if(_formkey.currentState!.validate())
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));
                        }
                      },
                      child: Container(
                        width: wi * 0.8,
                        height: hi * 0.05,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 47, 90, 218),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Center(
                          child: Text(
                              'LOGIN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              )
                          ),
                        ),
                      ),
                    ),
                  ),


              Row(
                children: [
                  Expanded(child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(color: Colors.black54,),
                  )),
                   Text("OR"),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(color: Colors.black54,),
                  )),
                ],
              ),


              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.google),)
                ],
              ),

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }


  Widget _no_account()
  {
    return  GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => const Signup()));
      },
      child: const Text.rich(
        TextSpan(
            text: 'Don\'t have an account? ',
            style: TextStyle(
                color: Colors.black, fontSize: 20),
            children: [
              TextSpan(
                  text: ' Signup',
                  style: TextStyle(color: Colors.blueAccent,
                      fontSize: 20)
              ),
            ]
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    double wi = MediaQuery
        .of(context)
        .size
        .width;
    double hi = MediaQuery
        .of(context)
        .size
        .height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xfff2f3f7),
        body: Stack(
          children: [
            Container(
              height: hi * 0.3,
              width: wi,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff2470c7),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: const Radius.circular(70),
                    bottomRight: const Radius.circular(70),
                  ),
                ),
              ),
            ),


            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                _welcome_back(),
                _login_container(hi,wi),
                _no_account(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

