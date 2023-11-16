import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnx/SelectedCourse.dart';
import 'POTD.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference dbE = FirebaseFirestore.instance.collection('Courses');
final CollectionReference dbU = FirebaseFirestore.instance.collection('Users');


final db = FirebaseFirestore.instance;

const Color themeblue = Color.fromARGB(255, 60, 84, 127);
const Color themegreen = Color.fromARGB(255, 66, 146, 130);

Map<String, String> courseCategoriesMap = {
  'others': 'New Courses',
  'programming': 'Programming',
  'devops': 'DevOps',
  'webdevelopment': 'Web Development',
  'advancedprogramming': 'Data Structures & Algorithms',
  'appdevelopment': 'App development',
  'databases': 'Database',
};

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<String> coursesCat = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getCategories();
  }

  void getCategories() async {
    setState(() => isLoading = true);
    final categoryDocumentNames = (await db.collection('Categories').get()).docs;
    setState(() {
      coursesCat = categoryDocumentNames.map((e) => e.id).toList();
      coursesCat.sort((a, b) => courseCategoriesMap.keys
          .toList()
          .indexOf(a)
          .compareTo(courseCategoriesMap.keys.toList().indexOf(b)));
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
}

class PotBox extends StatelessWidget {
  const PotBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double wi = MediaQuery.of(context).size.width;
    double hi = MediaQuery.of(context).size.height;
    return Card(
      elevation: 15,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        width: wi,
        height: hi*0.3,
        padding: EdgeInsets.all(wi*0.05),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          children: [
            SizedBox(
              width: wi,
              height: wi*0.08,
              child: Text(
                "Solve Today's Challenge",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: themeblue,
                      fontSize: wi*0.05,
                    )
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: wi*0.45,
                  height: hi*0.2,
                  child: SvgPicture.asset(
                    'assets/images/potd.svg',
                    height: hi*0,
                  ),
                ),
                FutureBuilder<bool>(
                    future: CourseFunc().getPOTD(),
                    builder: (context,snapshot){
                      if (snapshot.connectionState == ConnectionState.waiting){
                        return SizedBox(height: wi*0.03,width: wi*0.03,
                          child: CircularProgressIndicator(),
                        );
                      }
                      else{
                        bool solved = snapshot.data ?? false;
                        String val = solved == true? "Solved" : "Solve Now";
                        Color bt = solved == true? themeblue : themegreen;
                        return ElevatedButton(
                          onPressed: (){
                            Navigator.push(
                              context,MaterialPageRoute(builder: (context)=>POTD())
                            );
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(bt),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  )
                              ),
                              elevation: MaterialStatePropertyAll(15)
                          ),
                          child:Text(
                            val,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: wi*0.045,
                                )
                            ),
                          )
                        );
                      }
                    }
                ),
              ],
            )
          ],
        )
      ),
    );
  }
}

class CourseCategory extends StatelessWidget {
  const CourseCategory({super.key, required this.categories});

  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    double wi = MediaQuery.of(context).size.width;
    double hi = MediaQuery.of(context).size.height;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: categories.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return FutureBuilder(
                future: db.collection('Categories').doc(categories[index]).get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Something went wrong'),
                    );
                  } else if (snapshot.hasData) {
                    final courseCategoryData = snapshot.requireData.data();
                    final courseData = courseCategoryData!['courses'] as List<dynamic>;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          courseCategoriesMap[categories[index]]!,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 18,
                              )),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 160,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: courseData.length,
                              itemBuilder: ((context, index) {
                                return FutureBuilder(
                                    future:
                                    db.collection('Courses').doc(courseData[index].id).get(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return const Center(
                                          child: Text('Something went wrong'),
                                        );
                                      } else if (snapshot.hasData) {
                                        final data = snapshot.requireData.data();
                                        final color = data!['color'];
                                        final courseName = data['courseName'];
                                        final cid = data['cid'];
                                        final curC = Color.fromARGB(color['a'], color['r'], color['g'], color['b']);
                                        return Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: GestureDetector(
                                            onTap: (){
                                              Navigator.push(context,
                                                MaterialPageRoute(builder: (context) =>
                                                    SelectedCourse(cid: cid, cname: courseName, cc: curC,)
                                                )
                                              );
                                            },
                                            child: Card(
                                              elevation: 8,
                                              // shadowColor: Colors.grey,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15.0),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15.0),
                                                  color: curC,
                                                ),
                                                height: 150,
                                                width: 140,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Center(
                                                    child: Text(
                                                      courseName,
                                                      textAlign: TextAlign.center,
                                                      style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                            fontWeight: FontWeight.w700,
                                                            color: Colors.black,
                                                            fontSize: wi*0.042,
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      return const SizedBox();
                                    });
                              })),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                });
          },
        ),
      ],
    );
  }
}


//
// class ExplorePage extends StatefulWidget{
//   final String uid;
//   const ExplorePage({super.key,required this.uid});
//   @override
//   State<ExplorePage> createState() => ExploreState(uid: uid);
// }
// class ExploreState extends State<ExplorePage>{
//   final String uid;
//   ExploreState({required this.uid});
//   final Color themeblue = const Color.fromARGB(255, 60, 84, 127);
//   final Color themegreen = const Color.fromARGB(255, 66, 146, 130);
//   Text makeText(String s){
//     return Text(
//       s,
//       style: GoogleFonts.poppins(
//           textStyle: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//             fontSize: 17,
//           )
//       ),
//     );
//   }
//   String process(String s){
//     String res = "";
//     for (int i=0; i<s.length; i++){
//       if (s[i]==' '){
//         res+='\n';
//       }
//       else{
//         res+=s[i];
//       }
//     }
//     return res;
//   }
//   Card Course(double wi,double hi,String cname,Color c){
//     return Card(
//       elevation: 10,
//       shadowColor: Colors.grey,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       child: Container(
//         width: wi,
//         height: hi,
//         padding: EdgeInsets.all(wi*0.1),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: c,
//         ),
//         child: Text(
//           process(cname),
//           textAlign: TextAlign.left,
//           style: GoogleFonts.poppins(
//               textStyle: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black,
//                 fontSize: hi*0.09,
//               )
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<Column> Category(double wi, double hi, String catname, List<String> cc) async {
//     List<Widget> courseWidgets = [];
//     for (String courseId in cc) {
//       DocumentSnapshot docSnapshot = await dbE.doc(courseId).get();
//       if (docSnapshot.exists) {
//         Map<String, dynamic> curC = docSnapshot.data() as Map<String, dynamic>;
//         Color curCol = Color.fromARGB(
//           curC['color']['a'],
//           curC['color']['r'],
//           curC['color']['g'],
//           curC['color']['b'],
//         );
//         courseWidgets.add(
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,MaterialPageRoute(builder: (context) => SelectedCourse(cid: courseId,cname: curC['courseName'], cc: curCol,uid: uid)),
//               );
//             },
//             child: Course(wi * 0.4, wi * 0.4, curC['courseName'], curCol),
//           ),
//         );
//       }
//     }
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: hi * 0.03,),
//         Text(
//           catname,
//           textAlign: TextAlign.left,
//           style: GoogleFonts.poppins(
//             textStyle: TextStyle(
//               fontWeight: FontWeight.w700,
//               color: Colors.black,
//               fontSize: hi * 0.028,
//             ),
//           ),
//         ),
//         SizedBox(height: wi * 0.01,),
//         Container(
//           width: wi,
//           height: hi * 0.24,
//           child: ListView.separated(
//             shrinkWrap: true,
//             padding: EdgeInsets.symmetric(vertical: hi * 0.02),
//             scrollDirection: Axis.horizontal,
//             itemCount: courseWidgets.length,
//             separatorBuilder: (BuildContext context, int ind) {
//               return SizedBox(width: wi * 0.02,);
//             },
//             itemBuilder: (BuildContext context, int ind) {
//               return courseWidgets[ind];
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Card potdBox(double wi,double hi,bool solved){
//     return Card(
//       elevation: 15,
//       shadowColor: Colors.grey,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       child: Container(
//         width: wi,
//         height: hi,
//         padding: EdgeInsets.all(hi*0.08),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: Color.fromARGB(255, 255, 255, 255),
//         ),
//         child: Column(
//           children: [
//             SizedBox(
//               width: wi,
//               height: hi*0.12,
//               child: Text(
//                 "Solve Today's Challenge",
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.poppins(
//                     textStyle: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: themeblue,
//                       fontSize: hi*0.075,
//                     )
//                 ),
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 SvgPicture.asset(
//                   'assets/images/potd.svg',
//                   height: hi*0.65,
//                   fit: BoxFit.cover,
//                   // height: hi,
//                 ),
//                 ElevatedButton(
//                   onPressed: (){},
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStatePropertyAll(themegreen),
//                     shape: MaterialStatePropertyAll(
//                       RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(18),
//                       )
//                     ),
//                     elevation: MaterialStatePropertyAll(15)
//                   ),
//                   child: GestureDetector(
//                     onTap: (){
//
//                     },
//                     child: Text(
//                       solved == true? "Solved" : "Solve Now",
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.poppins(
//                           textStyle: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: solved == true? themeblue : themegreen,
//                             fontSize: wi*0.045,
//                           )
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             )
//           ],
//         )
//       ),
//     );
//   }
//
//   Center loading(double wi,double hi){
//     return Center(
//       child: SizedBox(
//         width: wi*0.2,
//         height: wi*0.2,
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
//
//   Future<List<String>> fetchData(String catName) async {
//     List<String> cc = [];
//     for (int i = 0; i < cid.length; i++) {
//       DocumentReference docRef = dbE.doc(cid[i]);
//       DocumentSnapshot docSnapshot = await docRef.get();
//       if (docSnapshot.exists && docSnapshot['category'] == catName) {
//         cc.add(cid[i]);
//       }
//     }
//     return cc;
//   }
//   Future<bool> getPOTD() async {
//     final auth = FirebaseAuth.instance;
//     DocumentReference userRef = dbU.doc(auth.currentUser!.uid);
//     DocumentSnapshot snap = await userRef.get();
//     return snap['potd'];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double wi = MediaQuery.of(context).size.width;
//     double hi = MediaQuery.of(context).size.height;
//     return SafeArea(
//       child: Scaffold(
//         body: ListView(
//           padding: EdgeInsets.all(hi*0.02),
//           scrollDirection: Axis.vertical,
//           children: [
//             Text(
//               "Welcome back!",
//               style: GoogleFonts.poppins(
//                   textStyle: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                     fontSize: hi*0.03,
//                   )
//               ),
//             ),
//             SizedBox(height: hi*0.02,),
//             FutureBuilder<bool>(
//               future: getPOTD(),
//               builder: (context,snapshot){
//                 bool solved = snapshot.data ?? false;
//                 return potdBox(wi*0.8,wi*0.7,solved);
//               },
//             ),
//             FutureBuilder<List<String>>(
//               future: fetchData('programming'),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return loading(wi, hi);
//                 } else if (snapshot.hasError) {
//                   return Text('Error 1: ${snapshot.error}');
//                 } else {
//                   List<String> cc = snapshot.data ?? [];
//                   return FutureBuilder<Column>(
//                     future: Category(wi, hi, "Programming", cc),
//                     builder: (context, snapshot2) {
//                       if (snapshot2.connectionState == ConnectionState.waiting) {
//                         return loading(wi, hi);
//                       } else if (snapshot2.hasError) {
//                         return Center(
//                           child: SizedBox(
//                             width: wi,
//                             height: hi*0.1,
//                             child: Text(
//                               "No Courses",
//                               textAlign: TextAlign.left,
//                               style: GoogleFonts.poppins(
//                                 textStyle: TextStyle(
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.grey.shade700,
//                                   fontSize: hi * 0.025,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       } else {
//                         return snapshot2.data as Column;
//                       }
//                     },
//                   );
//                 }
//               },
//             ),
//             FutureBuilder<List<String>>(
//               future: fetchData('devops'),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return loading(wi, hi);
//                 } else if (snapshot.hasError) {
//                   return Text('Error 1: ${snapshot.error}');
//                 } else {
//                   List<String> cc = snapshot.data ?? [];
//                   return FutureBuilder<Column>(
//                     future: Category(wi, hi, "DevOps", cc),
//                     builder: (context, snapshot2) {
//                       if (snapshot2.connectionState == ConnectionState.waiting) {
//                         return loading(wi, hi);
//                       } else if (snapshot2.hasError) {
//                         return Center(
//                           child: SizedBox(
//                             width: wi,
//                             height: hi*0.1,
//                             child: Text(
//                               "No Courses",
//                               textAlign: TextAlign.left,
//                               style: GoogleFonts.poppins(
//                                 textStyle: TextStyle(
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.grey.shade700,
//                                   fontSize: hi * 0.025,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       } else {
//                         return snapshot2.data as Column;
//                       }
//                     },
//                   );
//
//                 }
//               },
//             ),
//             FutureBuilder<List<String>>(
//               future: fetchData('webdevelopment'),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return loading(wi, hi);
//                 } else if (snapshot.hasError) {
//                   return Text('Error 1: ${snapshot.error}');
//                 } else {
//                   List<String> cc = snapshot.data ?? [];
//                   return FutureBuilder<Column>(
//                     future: Category(wi, hi, "Web Development", cc),
//                     builder: (context, snapshot2) {
//                       if (snapshot2.connectionState == ConnectionState.waiting) {
//                         return loading(wi, hi);
//                       } else if (snapshot2.hasError) {
//                         return Center(
//                           child: SizedBox(
//                             width: wi,
//                             height: hi*0.1,
//                             child: Text(
//                               "No Courses",
//                               textAlign: TextAlign.left,
//                               style: GoogleFonts.poppins(
//                                 textStyle: TextStyle(
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.grey.shade700,
//                                   fontSize: hi * 0.025,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       } else {
//                         return snapshot2.data as Column;
//                       }
//                     },
//                   );
//
//                 }
//               },
//             ),
//             FutureBuilder<List<String>>(
//               future: fetchData('appdevelopment'),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return loading(wi, hi);
//                 } else if (snapshot.hasError) {
//                   return Text('Error 1: ${snapshot.error}');
//                 } else {
//                   List<String> cc = snapshot.data ?? [];
//                   return FutureBuilder<Column>(
//                     future: Category(wi, hi, "App Development", cc),
//                     builder: (context, snapshot2) {
//                       if (snapshot2.connectionState == ConnectionState.waiting) {
//                         return loading(wi, hi);
//                       } else if (snapshot2.hasError) {
//                         return Center(
//                           child: SizedBox(
//                             width: wi,
//                             height: hi*0.1,
//                             child: Text(
//                               "No Courses",
//                               textAlign: TextAlign.left,
//                               style: GoogleFonts.poppins(
//                                 textStyle: TextStyle(
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.grey.shade700,
//                                   fontSize: hi * 0.025,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       } else {
//                         return snapshot2.data as Column;
//                       }
//                     },
//                   );
//
//                 }
//               },
//             ),
//             FutureBuilder<List<String>>(
//               future: fetchData('databases'),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return loading(wi, hi);
//                 } else if (snapshot.hasError) {
//                   return Text('Error 1: ${snapshot.error}');
//                 } else {
//                   List<String> cc = snapshot.data ?? [];
//                   return FutureBuilder<Column>(
//                     future: Category(wi, hi, "DataBases", cc),
//                     builder: (context, snapshot2) {
//                       if (snapshot2.connectionState == ConnectionState.waiting) {
//                         return loading(wi, hi);
//                       } else if (snapshot2.hasError) {
//                         return Center(
//                           child: SizedBox(
//                             width: wi,
//                             height: hi*0.1,
//                             child: Text(
//                               "No Courses",
//                               textAlign: TextAlign.left,
//                               style: GoogleFonts.poppins(
//                                 textStyle: TextStyle(
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.grey.shade700,
//                                   fontSize: hi * 0.025,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       } else {
//                         return snapshot2.data as Column;
//                       }
//                     },
//                   );
//
//                 }
//               },
//             ),
//             FutureBuilder<List<String>>(
//               future: fetchData('advancedprogramming'),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return loading(wi, hi);
//                 } else if (snapshot.hasError) {
//                   return Text('Error 1: ${snapshot.error}');
//                 } else {
//                   List<String> cc = snapshot.data ?? [];
//                   return FutureBuilder<Column>(
//                     future: Category(wi, hi, "Advanced Programming", cc),
//                     builder: (context, snapshot2) {
//                       if (snapshot2.connectionState == ConnectionState.waiting) {
//                         return loading(wi, hi);
//                       } else if (snapshot2.hasError) {
//                         return Center(
//                           child: SizedBox(
//                             width: wi,
//                             height: hi*0.1,
//                             child: Text(
//                               "No Courses",
//                               textAlign: TextAlign.left,
//                               style: GoogleFonts.poppins(
//                                 textStyle: TextStyle(
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.grey.shade700,
//                                   fontSize: hi * 0.025,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       } else {
//                         return snapshot2.data as Column;
//                       }
//                     },
//                   );
//
//                 }
//               },
//             ),
//             FutureBuilder<List<String>>(
//               future: fetchData('others'),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return loading(wi, hi);
//                 } else if (snapshot.hasError) {
//                   return Text('Error 1: ${snapshot.error}');
//                 } else {
//                   List<String> cc = snapshot.data ?? [];
//                   return FutureBuilder<Column>(
//                     future: Category(wi, hi, "New Courses", cc),
//                     builder: (context, snapshot2) {
//                       if (snapshot2.connectionState == ConnectionState.waiting) {
//                         return loading(wi, hi);
//                       } else if (snapshot2.hasError) {
//                         return Center(
//                           child: SizedBox(
//                             width: wi,
//                             height: hi*0.1,
//                             child: Text(
//                               "No Courses",
//                               textAlign: TextAlign.left,
//                               style: GoogleFonts.poppins(
//                                 textStyle: TextStyle(
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.grey.shade700,
//                                   fontSize: hi * 0.025,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       } else {
//                         return snapshot2.data as Column;
//                       }
//                     },
//                   );
//
//                 }
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }