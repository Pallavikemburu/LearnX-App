import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'LoginPage.dart';
import 'SignupPage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      home: MyHome(),
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
  bool userIsLoggedIn = false;
  Color mainbg = const Color.fromARGB(255, 0, 63, 254);
  @override
  Widget build(BuildContext context){
    double wi = MediaQuery.of(context).size.width;
    double hi = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: wi,
            height: hi*0.1,
            child: const Text(
              'LearnX',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'DancingScript-Regular',
              ),
            ),
          ),
          CarouselSlider(
              items: [
                SvgPicture.asset('assets/images/student1.svg'),
                SvgPicture.asset('assets/images/student2.svg'),
                SvgPicture.asset('assets/images/student3.svg'),
                SvgPicture.asset('assets/images/student4.svg'),
                SvgPicture.asset('assets/images/student5.svg'),
              ],
              options: CarouselOptions(
                height: 400,
                aspectRatio: 4/1,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.4,
                scrollDirection: Axis.horizontal,
              )
          ),
          SizedBox(height: hi*0.05,),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));
            },
            child: Container(
              width: wi*0.8,
              height: hi*0.05,
              decoration: BoxDecoration(
                color: mainbg,
                borderRadius: BorderRadius.circular(hi*0.025),
              ),
              child: Center(
                child: Text(
                  'LOGIN',
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    )
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const Signup()));
            },
            child: Container(
              width: wi*0.8,
              height: hi*0.05,
              decoration: BoxDecoration(
                color: mainbg,
                borderRadius: BorderRadius.circular(hi*0.025),
              ),
              child: Center(
                child: Text(
                  'SIGNUP',
                  style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
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
    );
  }
}