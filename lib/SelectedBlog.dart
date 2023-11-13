import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';

class SelectedBlog extends StatefulWidget{
  final String blogName;
  final Color blogColor;
  const SelectedBlog({super.key,required this.blogName,required this.blogColor});
  @override
  State<SelectedBlog> createState() => _SelectedBlogState(blogName: blogName,blogColor: blogColor);
}

class _SelectedBlogState extends State<SelectedBlog>{
  final String blogName;
  final Color blogColor;

  _SelectedBlogState({required this.blogName,required this.blogColor});

  Container TextContent(double wi,index){
    return Container(
      width: wi,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: index==0?BorderRadius.only(
          topLeft: Radius.circular(10),topRight: Radius.circular(10),
        ):BorderRadius.circular(0),
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Text(
          'In C language, the array has a fixed size meaning '
              'once the size is given to it, it cannot be '
              'changed i.e. you can’t shrink it nor can you '
              'expand it. The reason was that for expanding '
              'if we change the size we can’t be sure ( it’s '
              'not possible every time) that we get the next '
              'memory location to us for free. The shrinking '
              'will not work because the array, when declared, '
              'gets memory statically allocated, and thus '
              'compiler is the only one that can destroy it. ',
          style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                letterSpacing: 1,
                fontSize: 17,
                color: Colors.black54,
              )
          ),
        ),
      )
    );
  }

  Container ImageContent(double wi,index){
    return Container(
        width: wi,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: index==0?BorderRadius.only(
            topLeft: Radius.circular(10),topRight: Radius.circular(10),
          ):BorderRadius.circular(0),
        ),
        child: Image(
          image:NetworkImage('https://cdn.pixabay.com/photo/2016/11/19/14/00/code-1839406_640.jpg'),
          fit: BoxFit.contain,
        )
    );
  }

  @override
  Widget build(BuildContext context){
    double wi = MediaQuery.of(context).size.width;
    double hi = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body:Stack(
          children: [
            SizedBox(
              width: wi,
              height: hi,
              child: Column(
                children: [
                  Container(
                    width: wi,
                    height: hi*0.4,
                    color: blogColor,
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
                        "Blog Name",
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
                      physics: ClampingScrollPhysics(),
                      itemCount: 5, // Change this as needed
                      itemBuilder: (BuildContext context, int index) {
                        if (index%2==1){
                          return ImageContent(wi,index);
                        }
                        else{
                          return TextContent(wi,index);
                        }
                      },
                      separatorBuilder: (BuildContext context,int index){
                        return Container(height: hi*0.025,color: Colors.white,);
                      },
                    ),
                  ],
                )
            ),
            IconButton(
              icon: Icon(
                CupertinoIcons.left_chevron,
                size: 35,
                color: Colors.black,
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