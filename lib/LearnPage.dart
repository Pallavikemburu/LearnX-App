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

  String process(String s){
    String res = "";
    for (int i=0; i<s.length; i++){
      if (s[i]==' '){
        res+='\n';
      }
      else{
        res+=s[i];
      }
    }
    return res;
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
        padding: EdgeInsets.all(wi*0.1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: c,
        ),
        child: Text(
          process(cname),
          textAlign: TextAlign.left,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: hi*0.09,
              )
          ),
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
                  mainAxisSpacing: wi*0.045,
                  crossAxisSpacing: wi*0.045,
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