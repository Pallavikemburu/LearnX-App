import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnx/CourseData.dart';
import 'SelectedCourse.dart';

class ExplorePage extends StatefulWidget{
  const ExplorePage({super.key});
  @override
  State<ExplorePage> createState() => ExploreState();
}
class ExploreState extends State<ExplorePage>{

  Text makeText(String s){
    return Text(
      s,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 17,
          )
      ),
    );
  }

  Card Course(double wi,double hi,String cname,Color c){
    return Card(
      elevation: 10,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        width: wi,
        height: hi,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color.fromARGB(255, 31, 65, 114)
        ),
        child: Column(
          children: [
            Container(
              width: wi,
              height: hi*0.65,
              padding: EdgeInsets.all(hi*0.007),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(14),
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Icon(
                CupertinoIcons.arrow_3_trianglepath,
                color: Color.fromARGB(255, 134, 244, 238),
                size: hi*0.5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "$cname",
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 134, 244, 238),
                      fontSize: hi*0.08,
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column Category(double wi,double hi,String catname,int noc){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: hi*0.03,),
        Text(
          catname,
          textAlign: TextAlign.left,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: hi*0.028,
              )
          ),
        ),
        SizedBox(height: wi*0.01,),
        SizedBox(
          width: wi,
          height: hi*0.24,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: hi*0.02),
            scrollDirection: Axis.horizontal,
            itemCount: coursesData.length,
            separatorBuilder: (BuildContext context,int ind){
              return SizedBox(width: wi*0.02,);
            },
            itemBuilder: (BuildContext context,int ind){
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectedCourse(cname: coursesData[ind].cname,cc: coursesData[ind].col)));
                },
                child: Course(wi*0.4,wi*0.4,coursesData[ind].cname,coursesData[ind].col),
              );
            },
          ),
        )
      ],
    );
  }

  Card potdBox(double wi,double hi){
    return Card(
      elevation: 10,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        width: wi,
        height: hi,
        padding: EdgeInsets.all(hi*0.08),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color.fromARGB(255, 215, 215, 214),
        ),
        child: Column(
          children: [
            SizedBox(
              width: wi,
              height: hi*0.12,
              child: Text(
                "Solve Today's Challenge",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 60, 84, 127),
                      fontSize: hi*0.075,
                    )
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  'assets/images/potd.svg',
                  height: hi*0.65,
                  fit: BoxFit.cover,
                  // height: hi,
                ),
                ElevatedButton(
                  onPressed: (){},
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.green),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                      )
                    )
                  ),
                  child: Text(
                    "Solve Now",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: wi*0.055,
                        )
                    ),
                  ),
                )
              ],
            )
          ],
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    double wi = MediaQuery.of(context).size.width;
    double hi = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(hi*0.02),
          scrollDirection: Axis.vertical,
          children: [
            Container(
              width: wi,
              height: hi*0.15,
              padding: EdgeInsets.all(hi*0.02),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: wi*0.07,
                  ),
                  SizedBox(width: hi*0.02,),
                  Text(
                    "Varun3366",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: hi*0.025,
                        )
                    ),
                  )
                ],
              ),
            ),
            Text(
              "Welcome back!",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: hi*0.03,
                  )
              ),
            ),
            SizedBox(height: hi*0.02,),
            potdBox(wi*0.8,wi*0.7),
            Category(wi, hi, "Top Courses", 5),
            Category(wi, hi, "Programming", 5),
            Category(wi, hi, "Devops", 5),
            Category(wi, hi, "Web Development", 3),
            Category(wi, hi, "Data Structures & Algorithms", 10),
            Category(wi, hi, "App Development", 2),
          ],
        )
      ),
    );
  }
}