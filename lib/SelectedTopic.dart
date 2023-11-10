import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectedTopic extends StatefulWidget{
  final String tname;
  final Color tc;
  const SelectedTopic({super.key,required this.tname, required this.tc});
  @override
  State<SelectedTopic> createState() => _SelectedTopicState(tname: this.tname,tc: this.tc);
}
class _SelectedTopicState extends State<SelectedTopic>{
  final String tname;
  final Color tc;
  _SelectedTopicState({required this.tname,required this.tc});
  Card Blog(double wi,double hi){
    return Card(
      elevation: 15,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        title: Text(
          "BlogName",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
                fontSize: hi*0.04,
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
                    color: tc,
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
                        "${this.tname}",
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
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(8),
                      physics: ClampingScrollPhysics(),
                      itemCount: 5, // Change this as needed
                      itemBuilder: (BuildContext context, int gridIndex) {
                        return Blog(wi,hi);
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