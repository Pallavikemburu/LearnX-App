import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import 'SelectedCourse.dart';

class POTD extends StatefulWidget{
  const POTD({super.key});
  @override
  State<POTD> createState() => _POTDState();
}
class _POTDState extends State<POTD>{
  List<Color> opc = [Colors.white,Colors.white,Colors.white,Colors.white];
  Color obg = Colors.white;
  Container Question(double wi,String que){
    return Container(
      width: wi,
      padding: EdgeInsets.all(wi*0.08),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white
      ),
      child: Text(
        que,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: wi*0.06,
            )
        ),
      ),
    );
  }
  Container Option(double wi,Color c,String s){
    return Container(
      width: wi,
      padding: EdgeInsets.all(wi*0.05),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: c
      ),
      child: Text(
        s,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: wi*0.05,
            )
        ),
      ),
    );
  }
  Center loading(double wi,double hi){
    return Center(
      child: SizedBox(
        width: wi*0.2,
        height: wi*0.2,
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
        body: Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            SizedBox(
              width: wi,
              height: hi,
              child: Image(
                image: AssetImage('assets/images/potdbg.png'),
                fit: BoxFit.cover,
              ),
            ),
            FutureBuilder<Map<String,dynamic>>(
              future: CourseFunc().getPOTDque(),
              builder: (context,snapshot){
                if (snapshot.connectionState == ConnectionState.waiting){
                  return loading(wi,hi);
                }
                else{
                  Map<String,dynamic> cc = snapshot.data ?? {};
                  print(cc);
                  return ListView(
                    padding: EdgeInsets.all(wi*0.05),
                    children: [
                      SizedBox(height: hi*0.05,),
                      SizedBox(height: hi*0.015),
                      Question(wi, cc['question']),
                      SizedBox(height: hi*0.01),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            if (cc['op1'] == cc['ans']){
                              opc[1] = opc[2] = opc[3] = Colors.red;
                              opc[0] = Colors.green;
                            }
                            else{
                              opc[0] = opc[1] = opc[2] = opc[3] = Colors.red;
                            }
                            CourseFunc().updatePOTD();
                          });
                        },
                        child: Option(wi,opc[0],cc['op1']),
                      ),
                      SizedBox(height: hi*0.01),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            if (cc['op2'] == cc['ans']){
                              opc[0] = opc[2] = opc[3] = Colors.red;
                              opc[1] = Colors.green;
                            }
                            else{
                              opc[0] = opc[1] = opc[2] = opc[3] = Colors.red;
                            }
                            CourseFunc().updatePOTD();
                          });
                        },
                        child: Option(wi,opc[1],cc['op2']),
                      ),
                      SizedBox(height: hi*0.01),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            if (cc['op3'] == cc['ans']){
                              opc[1] = opc[0] = opc[3] = Colors.red;
                              opc[2] = Colors.green;
                            }
                            else{
                              opc[0] = opc[1] = opc[2] = opc[3] = Colors.red;
                            }
                            CourseFunc().updatePOTD();
                          });
                        },
                        child: Option(wi,opc[2],cc['op3']),
                      ),
                      SizedBox(height: hi*0.01),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            if (cc['op4'] == cc['ans']){
                              opc[1] = opc[2] = opc[0] = Colors.red;
                              opc[3] = Colors.green;
                            }
                            else{
                              opc[0] = opc[1] = opc[2] = opc[3] = Colors.red;
                            }
                            CourseFunc().updatePOTD();
                          });
                        },
                        child: Option(wi,opc[3],cc['op4']),
                      ),
                    ],
                  );
                }
              },
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
      )
    );
  }
}