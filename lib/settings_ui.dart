import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learnx/main.dart';



class settings_page extends StatefulWidget {
  const settings_page({super.key});

  @override
  State<settings_page> createState() => _settings_pageState();
}


class _settings_pageState extends State<settings_page> {
  /*DarkThemeProvider themeChangeProvider = new DarkThemeProvider();


  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
    await themeChangeProvider.darkThemePreference.getTheme();
  }   */

  Future<void> logoutUser(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyHome()));
  }
  void showCustomSnackBar(String string, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content:  Text(
          string,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        behavior:  SnackBarBehavior.floating,
      ),
    );
  }


  @override
  Widget build(BuildContext context){
   // var darkThemeProvider = Provider.of<DarkThemeProvider>(context);
    double wi = MediaQuery.of(context).size.width;
    double hi = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(wi*0.05),
          child: Column(
            children: [
              Card(
                elevation: 15,
                shadowColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(wi*0.15)
                ),
                child: CircleAvatar(
                  radius: wi*0.15,
                  backgroundColor: Colors.green,
                  backgroundImage: NetworkImage(
                    'https://cdn.pixabay.com/photo/2016/03/31/19/58/avatar-1295429_1280.png',

                  ),
                ),
              ),
              SizedBox(height: hi*0.02,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: wi*0.055,vertical: wi*0.025),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromARGB(255, 66, 146, 130)
                ),
                child: Text(
                  "Varun3366",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: wi*0.05,
                      )
                  ),
                ),
              ),
              SizedBox(height: hi*0.03,),
              Divider(
                height: 1.5,
                thickness: 1.5,
                indent: wi*0.03,
                endIndent: wi*0.03,
                color: Colors.grey.shade400,
              ),
              SizedBox(height: hi*0.01,),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,MaterialPageRoute(
                      builder: (context) => AboutApp()
                    )
                  );
                },
                child: ListTile(
                  leading: Icon(
                    CupertinoIcons.info,
                    color: Colors.black,
                  ),
                  title: Text(
                    "About App",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: wi*0.045,
                        )
                    ),
                  ),
                  trailing: Icon(
                    CupertinoIcons.chevron_right,
                    color: Colors.black,
                  ),
                ),
              ),
              GestureDetector(
                  child: ListTile(
                    leading: Icon(
                      CupertinoIcons.arrow_right_to_line,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Logout",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: wi*0.045,
                          )
                      ),
                    ),
                  ),
                onTap: (){
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(
                      title: Text("Logout"),
                      content: Text("Are you sure to logout?"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      actions:[
                        TextButton(
                          child: Text("NO",style: GoogleFonts.poppins(textStyle: TextStyle()),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                            onPressed: (){
                              logoutUser(context);
                            },
                            child: Text("YES",style: GoogleFonts.poppins(textStyle: TextStyle()
                            ),
                            )
                        )
                    ]
                    );
                  }
                  );
                }
             ),
            ]
         )
       )
      )
    );
  }


  AboutApp(){
    double wi = MediaQuery.of(context).size.width;
    double hi = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 66, 146, 130),
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: true,
          backgroundColor: Color.fromARGB(255, 66, 146, 130),
          title: Text(
            "LearnX",
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                )
            ),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(wi*0.05),
          scrollDirection: Axis.vertical,
          children : [
            Container(
              width: wi*0.9,
              height: wi*0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/LearnX-Logo.png'),
                  fit: BoxFit.cover,
                )
              ),
            ),
            Container(
              width: wi,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Text(
                info,
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      letterSpacing: 1,
                      fontSize: 17,
                      color: Colors.black54,
                    )
                ),
              )
            )
          ],
        ),
      )
    );
  }
}


/*
class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}

class DarkThemePreference {
  static const THEME_STATUS = "THEMESTATUS";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? false;
  }
}     */

String info =
"Welcome to LearnX, your one-stop destination for a diverse range of technology-related courses and insightful blogs. Whether you're a beginner or an experienced professional, our platform is designed to empower you with knowledge across various tech domains. Immerse yourself in a rich learning experience, explore captivating blogs, and challenge your mind with daily puzzles.\n\nKey Features:\n\n1. Extensive Course Library:\n   Dive into our extensive library of technology courses covering a wide array of topics. From programming languages to cutting-edge technologies, we've got you covered.\n\n2. Informative Blogs:\n   Enhance your understanding of technology through freely accessible blogs. Our platform offers a wealth of information, keeping you updated on the latest trends, best practices, and insights from industry experts.\n\n3. Daily Puzzles:\n  Sharpen your problem-solving skills with a new puzzle every day. Challenge yourself and witness the improvement in your analytical thinking and logical reasoning.\n\n4. Structured Learning Paths:\n   Our courses are meticulously organized into topics and subtopics, providing a clear roadmap for your learning journey. Track your progress easily and stay motivated as you complete each milestone.\n\n5. User-Friendly Interface:\n  Navigate through the app effortlessly with a user-friendly interface. Intuitive design ensures a seamless learning experience, making it easy for users to access courses, blogs, and puzzles.\n\nDesign Team :\n  Varun - 21P31A0541\n   Sai Pradeep - 21P31A0504\n   Ashok Kumar - 21P31A0530\n   Pallavi - 21P31A0520";