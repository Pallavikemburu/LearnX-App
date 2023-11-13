import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnx/CourseData.dart';
import 'SelectedCourse.dart';

class LearnPage extends StatefulWidget{
  const LearnPage({super.key});
  @override
  State<LearnPage> createState() => ExploreState();
}
class ExploreState extends State<LearnPage>{

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
          color: Color.fromARGB(255, 254, 187, 187),
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
                        'https://cdn.pixabay.com/photo/2016/12/28/10/10/image-1935809_640.png'
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
                      fontSize: hi*0.065,
                    )
                ),
              ),
            )
          ],
        ),
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
              Text(
                "Pace up your Learning!",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: hi*0.03,
                    )
                ),
              ),
              SizedBox(height: hi*0.02,),
              Text(
                "Your Courses",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: hi*0.025,
                    )
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: wi*0.05,
                  crossAxisSpacing: wi*0.05,
                  childAspectRatio: 1.0,
                ),
                itemCount: coursesData.length, // Change this as needed
                itemBuilder: (BuildContext context, int ind) {
                  return GridTile(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,MaterialPageRoute(
                            builder: (context)=> SelectedCourse(cname: coursesData[ind].cname, cc: coursesData[ind].col)
                        )
                        );
                      },
                      child: Course(wi*0.425,wi*0.425,coursesData[ind].cname,coursesData[ind].col),
                    ),
                  );
                },
              ),
            ],
          )
      ),
    );
  }
}