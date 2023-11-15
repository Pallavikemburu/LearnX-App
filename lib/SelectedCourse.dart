import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnx/SelectedTopic.dart';

class SelectedCourse extends StatefulWidget{
  final String cname;
  final Color cc;
  const SelectedCourse({super.key,required this.cname, required this.cc});
  @override
  State<SelectedCourse> createState() => _SelectedCourseState(cname: this.cname,cc: this.cc);
}
class _SelectedCourseState extends State<SelectedCourse>{
  final String cname;
  final Color cc;
  _SelectedCourseState({required this.cname,required this.cc});
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
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 6),
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
          ],
        ),
      ),
    );
  }

  String process(String s){
    String res = "\n\n";
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
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://img.freepik.com/free-vector/background-gradient-green-tones_23-2148360340.jpg?size=626&ext=jpg&ga=GA1.1.833117897.1699424469&semt=ais'),
                        fit: BoxFit.cover
                      ),
                      color: this.cc,
                    ),
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
                padding: EdgeInsets.all(wi*0.05),
                scrollDirection: Axis.vertical,
                children : [
                  SizedBox(
                    width: wi*0.55,
                    height: hi*0.25,
                    child: Text(
                      process(this.cname),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 24,
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: hi*0.05,),
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
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,MaterialPageRoute(
                                builder: (context)=> SelectedTopic(tname: "TopicName", tc: this.cc)
                              )
                            );
                          },
                          child: Topic(wi*0.35, wi*0.35),
                        ),
                      );
                    },
                  ),
                ],
              )
            ),
            IconButton(
              icon: Icon(
                CupertinoIcons.chevron_left_circle_fill,
                size: 40,
                color: Colors.white,
              ),
              onPressed: (){
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}