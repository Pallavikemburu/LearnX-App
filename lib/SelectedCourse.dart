import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectedCourse extends StatefulWidget{
  final String cname;
  final Color cc;
  const SelectedCourse({super.key,required this.cname, required this.cc});
  @override
  State<SelectedCourse> createState() => _SelectedCourseState(cname: this.cname);
}
class _SelectedCourseState extends State<SelectedCourse>{
  final String cname;
  _SelectedCourseState({required this.cname});
  Card Topic(double wi,double hi){
    return Card(
      elevation: 15,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        width: wi,
        height: hi,
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Card(
              elevation: 10,
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(hi*0.22),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: hi*0.22,
                child: Icon(
                  CupertinoIcons.location_solid,
                  size: 40,
                  color: Colors.green,
                ),
              ),
            ),
            SizedBox(height: hi*0.03,),
            Text(
              "TopicName",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade800,
                    fontSize: hi*0.12,
                  )
              ),
            ),
            Text(
              "2/5",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade800,
                    fontSize: hi*0.09,
                  )
              ),
            ),
            SizedBox(height: hi*0.04,),
            CurvedLinearProgressIndicator(
              value: 1/5,
              strokeWidth: 8,
              backgroundColor: Colors.grey.shade400,
              color: Colors.green,
            ),
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
        body: Stack(
          children: [
            SizedBox(
              width: wi,
              height: hi,
              child: Column(
                children: [
                  Container(
                    width: wi,
                    height: hi*0.4,
                    color: Colors.orange,
                  ),
                  Container(
                    width: wi,
                    height: hi*0.55,
                    color: Colors.white54,
                  )
                ],
              ),
            ),
            SizedBox(
              width: wi,
              height: hi,
              child: ListView(
                padding: EdgeInsets.all(hi*0.02),
                scrollDirection: Axis.vertical,
                children : [
                  SizedBox(
                    width: wi,
                    height: hi*0.26,
                    child: Text(
                      "${this.cname}",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: hi*0.04,
                          )
                      ),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(8),
                    physics: ClampingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: wi*0.05,
                      crossAxisSpacing: wi*0.05,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: 9, // Change this as needed
                    itemBuilder: (BuildContext context, int gridIndex) {
                      return GridTile(
                        child: Topic(wi*0.35, wi*0.35),
                      );
                    },
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}