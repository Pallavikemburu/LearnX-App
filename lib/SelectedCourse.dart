import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnx/SelectedTopic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference dbE = FirebaseFirestore.instance.collection('Courses');
final CollectionReference dbU = FirebaseFirestore.instance.collection('Users');
final CollectionReference dbp = FirebaseFirestore.instance.collection('potd');

class SelectedCourse extends StatefulWidget{
  final String cname;
  final Color cc;
  final String cid;
  const SelectedCourse({super.key,required this.cid, required this.cname, required this.cc});
  @override
  State<SelectedCourse> createState() => _SelectedCourseState(cid: cid,cname: this.cname,cc: this.cc);
}
class CourseFunc{
  final auth = FirebaseAuth.instance;
  Future<void>  deleteCourse(String cid) async {
    DocumentReference userRef = dbU.doc(auth.currentUser!.uid);
    userRef.update({
      'FavCourses' : FieldValue.arrayRemove([cid])
    });
  }
  Future<List<Map<String,dynamic>>> fetchUser() async {
    DocumentReference docRef = dbU.doc(auth.currentUser!.uid);
    DocumentSnapshot docSnapshot = await docRef.get();
    List<Map<String,dynamic>> cc = [];
    for (int i=0; i<docSnapshot['FavCourses'].length; i++){
      DocumentSnapshot courseSnapshot = await dbE.doc(docSnapshot['FavCourses'][i]).get();
      cc.add(courseSnapshot.data() as Map<String, dynamic>);
    }
    return cc;
  }
  Future<Map<String,dynamic>> getPOTDque() async {
    DocumentReference docRef = dbp.doc('question');
    DocumentSnapshot docSnapshot = await docRef.get();
    Map<String,dynamic> cc = {};
    cc['question'] = docSnapshot['question'] as String;
    cc['op1'] = docSnapshot['op1'] as String;
    cc['op2'] = docSnapshot['op2'] as String;
    cc['op3'] = docSnapshot['op3'] as String;
    cc['op4'] = docSnapshot['op4'] as String;
    cc['ans'] = docSnapshot['ans'] as String;
    return cc;
  }
  Future<void> updatePOTD() async {
    DocumentReference userRef = dbU.doc(auth.currentUser!.uid);
    userRef.update({
      'potd' : true,
    });
  }
  Future<bool> getPOTD() async {
    DocumentReference userRef = dbU.doc(auth.currentUser!.uid);
    DocumentSnapshot snap = await userRef.get();
    return snap['potd'];
  }
  Future<bool> checkCourse(String courseID) async {
    DocumentReference userRef = dbU.doc(auth.currentUser!.uid);
    DocumentSnapshot snap = await userRef.get();
    if (snap['FavCourses'].contains(courseID)){
      return true;
    }
    return false;
  }
  Future<void> addCourse(String cid) async {
    DocumentReference userRef = dbU.doc(auth.currentUser!.uid);
    userRef.update({
      'FavCourses' : FieldValue.arrayUnion([cid])
    });
  }
}
class _SelectedCourseState extends State<SelectedCourse>{
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final String cname;
  final Color cc;
  final String cid;
  _SelectedCourseState({required this.cid, required this.cname,required this.cc});


  List<String> topicNames = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getTopics();
  }

  Future<void> getTopics() async {
    setState((){
      isLoading = true;
    });
    try {
      final db = FirebaseFirestore.instance;
      final collectionReference = db.collection('Courses').doc(cid);
      final DocumentSnapshot courseDocument = await collectionReference.get();
      setState(() {
        topicNames = [];
        List<dynamic> topicsArray = courseDocument['topics'];
        if (topicsArray != null) {
          Future.forEach(topicsArray, (topicRef) async {
            DocumentSnapshot topicDoc = await topicRef.get();
            String topicName = topicDoc['topicName'];
            topicNames.add(topicName);
          }).then((_) {
            isLoading = false;
          });
        } else {
          isLoading = false;
        }
      });
    } catch (e) {
      print('Error fetching topics: $e');
      setState(() => isLoading = false);
    }
  }
  Card Topic(double wi,double hi,String tn){
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
              tn,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade800,
                    fontSize: hi*0.11,
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
  String process(String s){
    String res = "\n";
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
        resizeToAvoidBottomInset: false,
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
                    height: hi*0.2,
                    child: Text(
                      process(this.cname),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: wi*0.08,
                          )
                      ),
                    ),
                  ),
                  FutureBuilder<bool>(
                    future: CourseFunc().checkCourse(cid),
                    builder: (context,snapshot){
                      if (snapshot.connectionState == ConnectionState.waiting){
                        return loading(wi,hi);
                      }
                      else{
                        bool enrolled= snapshot.data ??  false;
                        return SizedBox(
                          height:hi*0.05,
                          child: IconButton(
                            onPressed: (){
                              setState(() {
                                if (enrolled){
                                  CourseFunc().deleteCourse(cid);
                                }
                                else{
                                  CourseFunc().addCourse(cid);
                                }
                              });
                            },
                            icon: Icon(
                                enrolled == true ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
                                color: enrolled == true ? Colors.white : Colors.black,
                                size: 40
                            ),
                          ),
                        );
                      }
                    },
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
                    itemCount: topicNames.length, // Change this as needed
                    itemBuilder: (BuildContext context, int gridIndex) {
                      return GridTile(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,MaterialPageRoute(
                                builder: (context)=> SelectedTopic(tname: topicNames[gridIndex], tc: this.cc)
                              )
                            );
                          },
                          child: Topic(wi*0.35, wi*0.35,topicNames[gridIndex]),
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