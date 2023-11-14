import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnx/PasswordResetPage.dart';
import 'HomePage.dart';
import 'LoginPage.dart';
import 'SignupPage.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class AuthChange extends StatefulWidget {
  const AuthChange({super.key});
  @override
  State<AuthChange> createState() => AuthChangeState();
}

class AuthChangeState extends State<AuthChange> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return const HomePage();
          }
          else{
            return const MyHome();
          }
        }
    );
  }
}



class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      initialRoute: '0',
      routes: {
        '0':(context)=>AuthChange(),
        '1':(context)=> MyHome(),
        '2':(context)=>Login(),
        '3':(context)=>Signup(),
        '4':(context)=>PasswordReset(),
      },
      home:MyHome(),
      debugShowCheckedModeBanner: false,
    );
  }

}
class MyHome extends StatefulWidget{
  const MyHome({super.key});
  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome>{
  Column display(double wi,double hi,String txt,String img,Color tc){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          txt,
          style: GoogleFonts.roboto(
              textStyle: TextStyle(
                fontSize: hi*0.04,
                color: tc,
                fontWeight: FontWeight.bold,
              )

          ),
        ),
        SvgPicture.asset(img),
      ],
    );
  }
  @override
  Widget build(BuildContext context){
    double wi = MediaQuery.of(context).size.width;
    double hi = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: wi*0.05),
            scrollDirection: Axis.vertical,
            children: [
              SizedBox(
                width: wi,
                height: hi*0.8,
                child: CarouselSlider(
                    items: [
                      display(wi*0.9, hi*0.8,
                          'Start Learning Today!',
                          'assets/images/student1.svg',
                          const Color.fromARGB(255, 235, 182, 45)
                      ),
                      display(wi*0.9, hi*0.8,
                          'Explore Everything!',
                          'assets/images/student2.svg',
                          const Color.fromARGB(255, 217, 78, 86)
                      ),
                      display(wi*0.9, hi*0.8,
                          'Sharpen Your Skills!',
                          'assets/images/student4.svg',
                          const Color.fromARGB(255, 45, 106, 103)
                      ),
                      display(wi*0.9, hi*0.8,
                          'Become Productive!',
                          'assets/images/student5.svg',
                          const Color.fromARGB(255, 227, 113, 92)
                      ),
                    ],
                    options: CarouselOptions(
                      height: hi*0.7,
                      aspectRatio: 16/9,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      scrollDirection: Axis.horizontal,
                    )
                ),
              ),

              InkWell(
                onTap: (){
                  Navigator.pushNamed((context), "2");
                },
                child: Container(
                  width: wi*0.8,
                  height: wi*0.13,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(hi*0.05),
                  ),
                  child: Center(
                    child: Text(
                      'LOGIN',
                      style: GoogleFonts.aBeeZee(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          )
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: hi*0.02,),
              InkWell(
                onTap: (){

                  Navigator.pushNamed((context), "3");
                },
                child: Container(
                  width: wi*0.8,
                  height: wi*0.13,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 25, 147, 223),
                    borderRadius: BorderRadius.circular(hi*0.05),
                  ),
                  child: Center(
                    child: Text(
                      'SIGN UP',
                      style: GoogleFonts.aBeeZee(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          )
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}
