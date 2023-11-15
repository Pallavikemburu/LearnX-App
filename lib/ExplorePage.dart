import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'POTD.dart';
import 'SelectedCourse.dart';
import 'HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// final DocumentReference dbU = FirebaseFirestore.instance.collection('Users').get();
final CollectionReference courses = FirebaseFirestore.instance.collection('Courses');

// class ExplorePage extends StatefulWidget {
//   const ExplorePage({super.key});
//   @override
//   State<ExplorePage> createState() => ExploreState();
// }

// class ExploreState extends State<ExplorePage> {
//   final Color themeblue = const Color.fromARGB(255, 60, 84, 127);
//   final Color themegreen = const Color.fromARGB(255, 66, 146, 130);
//   Text makeText(String s) {
//     return Text(
//       s,
//       style: GoogleFonts.poppins(
//           textStyle: TextStyle(
//         fontWeight: FontWeight.bold,
//         color: Colors.black,
//         fontSize: 17,
//       )),
//     );
//   }

//   String process(String s) {
//     String res = "";
//     for (int i = 0; i < s.length; i++) {
//       if (s[i] == ' ') {
//         res += '\n';
//       } else {
//         res += s[i];
//       }
//     }
//     return res;
//   }

//   Card Course(double wi, double hi, String cname, Color c) {
//     return Card(
//       elevation: 10,
//       shadowColor: Colors.grey,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       child: Container(
//         width: wi,
//         height: hi,
//         padding: EdgeInsets.all(wi * 0.1),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: c,
//         ),
//         child: Text(
//           process(cname),
//           textAlign: TextAlign.left,
//           style: GoogleFonts.poppins(
//               textStyle: TextStyle(
//             fontWeight: FontWeight.w600,
//             color: Colors.black,
//             fontSize: hi * 0.09,
//           )),
//         ),
//       ),
//     );
//   }

//   Future<Column> Category(double wi, double hi, String catname, String curCat) async {
//     List<String> scc = [];
//     // cid.forEach((element) async {
//     //   print("""""" """""" """""" """""" """""" """""" """""");
//       DocumentSnapshot curC = await dbE.doc(element).get();
//     //   String ans =
//     //       curC.data().toString().contains('categoryname') ? curC.get('categoryname') : ''; //String
//     //   if (ans == catname) {
//     //     scc.add(element);
//     //   }
//     // });
//     Map<String, dynamic> coursesData = {};
//     final myCouses = await courses.get();
//     for (final doc in myCouses.docs) {
//       coursesData = (await courses.doc(doc.id).get()).data() as Map<String, dynamic>;
//       print('~~~~>$coursesData');
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           height: hi * 0.03,
//         ),
//         Text(
//           catname,
//           textAlign: TextAlign.left,
//           style: GoogleFonts.poppins(
//               textStyle: TextStyle(
//             fontWeight: FontWeight.w700,
//             color: Colors.black,
//             fontSize: hi * 0.028,
//           )),
//         ),
//         SizedBox(
//           height: wi * 0.01,
//         ),
//         Container(
//           width: wi,
//           height: hi * 0.24,
//           child: ListView.separated(
//             shrinkWrap: true,
//             padding: EdgeInsets.symmetric(vertical: hi * 0.02),
//             scrollDirection: Axis.horizontal,
//             itemCount: scc.length,
//             separatorBuilder: (BuildContext context, int ind) {
//               return SizedBox(
//                 width: wi * 0.02,
//               );
//             },
//             itemBuilder: (BuildContext context, int ind) {
//               Map<String, dynamic> curC = dbE.doc(scc[ind]) as Map<String, dynamic>;
//               Color curCol = Color.fromARGB(
//                   curC['color']['a'], curC['color']['r'], curC['color']['g'], curC['color']['b']);
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) =>
//                               SelectedCourse(cname: curC['courseName'], cc: curCol)));
//                 },
//                 child: Course(wi * 0.4, wi * 0.4, curC['courseName'], curCol),
//               );
//             },
//           ),
//         )
//       ],
//     );
//   }

//   Card potdBox(double wi, double hi) {
//     return Card(
//       elevation: 15,
//       shadowColor: Colors.grey,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       child: Container(
//           width: wi,
//           height: hi,
//           padding: EdgeInsets.all(hi * 0.08),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             color: Color.fromARGB(255, 255, 255, 255),
//           ),
//           child: Column(
//             children: [
//               SizedBox(
//                 width: wi,
//                 height: hi * 0.12,
//                 child: Text(
//                   "Solve Today's Challenge",
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.poppins(
//                       textStyle: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: themeblue,
//                     fontSize: hi * 0.075,
//                   )),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   SvgPicture.asset(
//                     'assets/images/potd.svg',
//                     height: hi * 0.65,
//                     fit: BoxFit.cover,
//                     // height: hi,
//                   ),
//                   ElevatedButton(
//                     onPressed: () {},
//                     style: ButtonStyle(
//                         backgroundColor: MaterialStatePropertyAll(themegreen),
//                         shape: MaterialStatePropertyAll(RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(18),
//                         )),
//                         elevation: MaterialStatePropertyAll(15)),
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => POTD()));
//                       },
//                       child: Text(
//                         "Solve Now",
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.poppins(
//                             textStyle: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           fontSize: wi * 0.05,
//                         )),
//                       ),
//                     ),
//                   )
//                 ],
//               )
//             ],
//           )),
//     );
//   }

//   Center loading(double wi, double hi) {
//     return Center(
//       child: SizedBox(
//         width: wi * 0.2,
//         height: wi * 0.2,
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     double wi = MediaQuery.of(context).size.width;
//     double hi = MediaQuery.of(context).size.height;
//     return SafeArea(
//       child: Scaffold(
//         body: StreamBuilder(
//           stream: dbE.snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return loading(wi, hi);
//             } else {
//               return ListView(
//                 shrinkWrap: true,
//                 // // physics: NeverScrollableScrollPhysics(),
//                 padding: EdgeInsets.all(hi * 0.02),
//                 scrollDirection: Axis.vertical,
//                 children: [
//                   Text(
//                     "Welcome back!",
//                     style: GoogleFonts.poppins(
//                         textStyle: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                       fontSize: hi * 0.03,
//                     )),
//                   ),
//                   SizedBox(
//                     height: hi * 0.02,
//                   ),
//                   potdBox(wi * 0.8, wi * 0.7),
//                   FutureBuilder<Column>(
//                     future: Category(wi, hi, "Trending Courses", 'others'),
//                     builder: (context, categorySnapshot) {
//                       if (categorySnapshot.connectionState == ConnectionState.waiting) {
//                         return loading(wi, hi);
//                       } else {
//                         return categorySnapshot.data ??
//                             Container(
//                               child: Text("KO"),
//                             );
//                       }
//                     },
//                   ),
//                   FutureBuilder<Column>(
//                     future: Category(wi, hi, "Programming", 'programming'),
//                     builder: (context, categorySnapshot) {
//                       if (categorySnapshot.connectionState == ConnectionState.waiting) {
//                         return loading(wi, hi);
//                       } else {
//                         return categorySnapshot.data ?? Container();
//                       }
//                     },
//                   ),
//                   FutureBuilder<Column>(
//                     future: Category(wi, hi, "Devops", 'devops'),
//                     builder: (context, categorySnapshot) {
//                       if (categorySnapshot.connectionState == ConnectionState.waiting) {
//                         return loading(wi, hi);
//                       } else {
//                         return categorySnapshot.data ?? Container();
//                       }
//                     },
//                   ),
//                   FutureBuilder<Column>(
//                     future: Category(wi, hi, "Web Development", 'webdevelopment'),
//                     builder: (context, categorySnapshot) {
//                       if (categorySnapshot.connectionState == ConnectionState.waiting) {
//                         return loading(wi, hi);
//                       } else {
//                         return categorySnapshot.data ?? Container();
//                       }
//                     },
//                   ),
//                   FutureBuilder<Column>(
//                     future: Category(wi, hi, "Data Structures & Algorithms", 'advancedprogramming'),
//                     builder: (context, categorySnapshot) {
//                       if (categorySnapshot.connectionState == ConnectionState.waiting) {
//                         return loading(wi, hi);
//                       } else {
//                         return categorySnapshot.data ?? Container();
//                       }
//                     },
//                   ),
//                   FutureBuilder<Column>(
//                     future: Category(wi, hi, "App Development", 'appdevelopment'),
//                     builder: (context, categorySnapshot) {
//                       if (categorySnapshot.connectionState == ConnectionState.waiting) {
//                         return loading(wi, hi);
//                       } else {
//                         return categorySnapshot.data ?? Container();
//                       }
//                     },
//                   ),
//                 ],
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
final db = FirebaseFirestore.instance;

const Color themeblue = Color.fromARGB(255, 60, 84, 127);
const Color themegreen = Color.fromARGB(255, 66, 146, 130);

Map<String, String> courseCategoriesMap = {
  'others': 'Trending Courses',
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Welcome back!",
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 24,
                )),
              ),
              const SizedBox(
                height: 16,
              ),
              const PotBox(),
              const SizedBox(
                height: 24,
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
    double width = MediaQuery.of(context).size.width;
    return Card(
      elevation: 15,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
          child: Column(
            children: [
              Text(
                "Solve Today's Challenge",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: themeblue,
                  fontSize: 24,
                )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    'assets/images/potd.svg',
                    height: 160,
                    fit: BoxFit.cover,
                    // height: hi,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll(themegreen),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        )),
                        elevation: const MaterialStatePropertyAll(15)),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => const POTD()));
                      },
                      child: Text(
                        "Solve Now",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: width * 0.05,
                        )),
                      ),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}

class CourseCategory extends StatelessWidget {
  const CourseCategory({super.key, required this.categories});

  final List<String> categories;

  @override
  Widget build(BuildContext context) {
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
                          height: 140,
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
                                        return Padding(
                                          padding: const EdgeInsets.only(right: 16),
                                          child: Card(
                                            elevation: 10,
                                            // shadowColor: Colors.grey,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15.0),
                                                color: Color.fromARGB(
                                                    color['a'], color['r'], color['g'], color['b']),
                                              ),
                                              height: 140,
                                              width: 140,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      courseName,
                                                      style: GoogleFonts.poppins(
                                                          textStyle: const TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                      )),
                                                    ),
                                                  ],
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
