import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

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

  Container TextContent(double wi){
    return Container(
      width: wi,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
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
          style: GoogleFonts.aBeeZee(
              textStyle: const TextStyle(
                letterSpacing: 1.7,
                fontSize: 22,
                color: Colors.black54,
              )
          ),
        ),
      )
    );
  }
  Container CodeContent(double wi){
    return Container(
      width: wi,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        '#include<bits/stdc++.h>\n'
        'using namespace std;\n'
        '#define ll long long\n'
        'll solve(ll n){\n'
        '\tll res = 0;\n'
        '\twhile (n){\n'
        '\t\tres+=n;\n'
        '\t\tn/=2;\n'
        '\t}\n'
        '\treturn res;\n'
        '}\n'
        'int main(){\n'
        'int t;\n'
        'cin>>t;\n'
        'while (t--){\n'
        'll n;\n'
        'cin>>n;\n'
        'cout<<solve(n)<<endl;\n'
        '}\n'
        '}\n',
        style: GoogleFonts.aBeeZee(
            textStyle: const TextStyle(
              letterSpacing: 1.7,
              fontSize: 22,
              color: Colors.black,
            )
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
                    SizedBox(
                      width: wi,
                      height: hi*0.26,
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
                      itemBuilder: (BuildContext context, int gridIndex) {
                        if (gridIndex%2==1){
                          return CodeContent(wi);
                        }
                        else{
                          return TextContent(wi);
                        }
                      },
                      separatorBuilder: (BuildContext context,int index){
                        return Container(height: hi*0.025,color: Colors.white,);
                      },
                    ),
                  ],
                )
            )
          ],
        ),
      )
    );
  }
}