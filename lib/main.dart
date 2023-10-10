import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'HomePage.dart';
import 'LoginPage.dart';

void main(){
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
  bool userIsLoggedIn = true;
  Container SVGdisplay(String img,double wi,double hi,Color c){
    return Container(
      width: hi*0.6,
      height: hi*0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(hi*0.3),
        color: c,
      ),
      child: SvgPicture.asset(img),
    );
  }
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
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Color.fromARGB(255, 2, 148, 7),
              ),
            ),
          ),
          CarouselSlider(
              items: [
                // SVGdisplay('assets/images/student1.svg',wi,hi,const Color.fromARGB(255, 251, 230, 178),),
                // SVGdisplay('assets/images/student2.svg',wi,hi,const Color.fromARGB(255, 249, 204, 234),),
                // SVGdisplay('assets/images/student3.svg',wi,hi,const Color.fromARGB(255, 191, 255, 168),),
                // SVGdisplay('assets/images/student4.svg',wi,hi,const Color.fromARGB(255, 82, 145, 66),),
                // SVGdisplay('assets/images/student5.svg',wi,hi,const Color.fromARGB(255, 255, 171, 117),),
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
          ElevatedButton(
            onPressed: (){
              if (userIsLoggedIn){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));
              }
              else{
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));
              }
            },
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.green),
            ),
            child: const Text('Next'),
          ),
        ],
      )
    );
  }
}