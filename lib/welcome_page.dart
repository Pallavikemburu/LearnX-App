import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'LoginPage.dart';
import 'SignupPage.dart';


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
                  color:  Color.fromARGB(255, 0, 63, 254),
                  fontWeight: FontWeight.bold,
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


            SizedBox(height: hi*0.02),


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
    );
  }
}