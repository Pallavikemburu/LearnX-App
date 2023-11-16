import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnx/CourseData.dart';
import 'SelectedCourse.dart';

final CollectionReference dbU = FirebaseFirestore.instance.collection('Users');

class LearnPage extends StatefulWidget{
  const LearnPage({super.key});
  @override
  State<LearnPage> createState() => ExploreState();
}
class ExploreState extends State<LearnPage>{
  final auth = FirebaseAuth.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;
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
  Center loading(double wi,double hi){
    return Center(
      child: SizedBox(
        width: wi*0.15,
        height: wi*0.15,
        child: CircularProgressIndicator(),
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
              FutureBuilder<List<Map<String,dynamic>>>(
                future: CourseFunc().fetchUser(),
                builder: (context,snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return loading(wi, hi);
                  } else if (snapshot.hasError) {
                    return Text('Error fetching user courses: ${snapshot.error}');
                  } else {
                    List<Map<String,dynamic>> cc = snapshot.data ?? [];
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: wi*0.045,
                        crossAxisSpacing: wi*0.045,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: cc.length, // Change this as needed
                      itemBuilder: (BuildContext context, int ind) {
                        final color = cc[ind]['color'];
                        final courseName = cc[ind]['courseName'];
                        final cid = cc[ind]['cid'];
                        final curC = Color.fromARGB(color['a'], color['r'], color['g'], color['b']);
                        return GridTile(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,MaterialPageRoute(
                                  builder: (context)=> SelectedCourse(cid: cid,cname: courseName, cc: curC,)
                              )
                              );
                            },
                            child: Course(wi*0.425,wi*0.425,courseName,curC),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          )
      ),
    );
  }
}