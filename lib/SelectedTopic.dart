import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnx/SelectedBlog.dart';

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

  Card Blog(double wi,double hi,int bn){
    return Card(
      elevation: 15,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        trailing: Icon(
          CupertinoIcons.chevron_right,
          size: 30,
        ),
        leading: Text(
          "${bn + 1}",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
                fontSize: 20,
              )
          ),
        ),
        title: Text(
          "Blog",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
                fontSize: 20,
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
                    SizedBox(height: hi*0.1,),
                    SizedBox(
                      width: wi,
                      height: hi*0.15,
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
                    ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(8),
                      physics: ClampingScrollPhysics(),
                      itemCount: 5, // Change this as needed
                      itemBuilder: (BuildContext context, int gridIndex) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,MaterialPageRoute(
                                builder: (context)=>SelectedBlog(blogName: tname, blogColor: tc)
                              )
                            );
                          },
                          child: Blog(wi,hi,gridIndex),
                        );
                      },
                      separatorBuilder: (BuildContext context,int ind){
                        return SizedBox(height: hi*0.01,);
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
/*
* Widget build(BuildContext context) {
    double wi = MediaQuery.of(context).size.width;
    double hi = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(wi*0.04),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Welcome back!",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: hi*0.03,
                    )),
              ),
              SizedBox(
                height: hi*0.02,
              ),
              const PotBox(),
              SizedBox(
                height: hi*0.02,
              ),
              isLoading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : CourseCategory(categories: coursesCat),
            ]),
          ),
        ),
      ),
    );
  }
*
*
*
*
*
*
*
*
*
* */