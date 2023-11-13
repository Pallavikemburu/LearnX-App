import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class settings_page extends StatefulWidget {
  const settings_page({super.key});

  @override
  State<settings_page> createState() => _settings_pageState();
}

class _settings_pageState extends State<settings_page> {
  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              const SizedBox(height: 15,),
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.orange,
                    child: Text("V"),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Column(
                    children: [
                      Text(
                        "UserName",
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "email@gmail.com",
                        textAlign: TextAlign.left,
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10,),
              Divider(),
              const SizedBox(height: 10,),

            ],
          ),
        ),
      )
    );
  }
}