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
      home: HomePage(),
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