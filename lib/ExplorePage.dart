import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnx/CourseData.dart';

import 'SelectedCourse.dart';

class ExplorePage extends StatefulWidget{
  const ExplorePage({super.key});
  @override
  State<ExplorePage> createState() => ExploreState();
}
class ExploreState extends State<ExplorePage>{

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
          color: c,
        ),
        child: Column(
          children: [
            Container(
              width: wi,
              height: hi*0.65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(14),
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                      'https://cdn.pixabay.com/photo/2017/10/10/21/46/laptop-2838917_640.jpg'
                  ),
                  fit: BoxFit.cover,
                )
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
                      color: Colors.black,
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
        SizedBox(height: hi*0.04,),
        Text(
          catname,
          textAlign: TextAlign.left,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: hi*0.03,
              )
          ),
        ),
        SizedBox(height: hi*0.01,),
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
                child: Course(wi*0.4,hi*0.2,coursesData[ind].cname,coursesData[ind].col),
              );
            },
          ),
        )
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
                  fontSize: hi*0.04,
                )
              ),
            ),
            SizedBox(height: hi*0.02,),
            Course(wi,hi*0.4,"POTD",Colors.amberAccent),
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