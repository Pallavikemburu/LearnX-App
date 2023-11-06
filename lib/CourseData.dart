import 'dart:ui';
import 'package:flutter/material.dart';

class course{
  int cid;
  String cname;
  int rating;//out of 10
  Color col;
  course({
    required this.cid,
    required this.cname,
    required this.rating,
    required this.col,
  });
}

final List<course> coursesData = [
  course(cid: 1001, cname: "C++ Fundamentals", rating: 9, col: Colors.green),
  course(cid: 1002, cname: "C Fundamentals", rating: 8, col: Colors.lightBlueAccent),
  course(cid: 1003, cname: "Python Programming", rating: 9, col: Colors.orangeAccent),
  course(cid: 1004, cname: "OOPs with JAVA", rating: 7, col: Colors.pinkAccent),
  course(cid: 1005, cname: "Dart Language", rating: 10, col: Colors.yellowAccent),
  course(cid: 1006, cname: "RedHat Linux", rating: 6, col: Colors.green),
  course(cid: 1007, cname: "Flutter", rating: 8, col: Colors.purpleAccent),
  course(cid: 1008, cname: "Web Development", rating: 8, col: Colors.grey),
  course(cid: 1009, cname: "Competitive Coding", rating: 5, col: Colors.cyanAccent),
  course(cid: 1010, cname: "DSA", rating: 7, col: Colors.limeAccent),
  course(cid: 1011, cname: "AI/ML", rating: 8, col: Colors.tealAccent),
  course(cid: 1012, cname: "Salesforce", rating: 9, col: Colors.pinkAccent),
  course(cid: 1013, cname: "PEGA", rating: 7, col: Colors.cyan),
];