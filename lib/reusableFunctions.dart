import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Course extends StatelessWidget{
  Course({super.key});
  @override
  Widget build(BuildContext context){
    return Card(
      elevation: 10,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        width: 50,
        height: 50,
        padding: EdgeInsets.all(50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.red,
        ),
        child: Text(
          "Text",
          textAlign: TextAlign.left,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 15,
              )
          ),
        ),
      ),
    );
  }
}

class getCat extends StatelessWidget {
  String corId;
  getCat({super.key,required this.corId});
  CollectionReference corses=FirebaseFirestore.instance.collection('Courses');


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: corses.doc(corId).get(),
        builder: (context,snapshot){


          if(snapshot.connectionState==ConnectionState.done){
            Map<String,dynamic> data= snapshot.data!.data() as Map<String,dynamic>;
            return data['category'];
          }
          return Text("Loadig");
        });
  }
}