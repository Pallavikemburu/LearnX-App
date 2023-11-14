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
  course(cid: 1001, cname: "C++ Fundamentals", rating: 9, col: Color.fromARGB(
      255, 228, 136, 157)),
  course(cid: 1002, cname: "C Fundamentals", rating: 8, col: Color.fromARGB(
      255, 97, 175, 161)),
  course(cid: 1003, cname: "Python Programming", rating: 9, col: Color.fromARGB(
      255, 222, 171, 101)),
  course(cid: 1004, cname: "OOPs with JAVA", rating: 7, col: Color.fromARGB(
      255, 172, 126, 144)),
  course(cid: 1005, cname: "Dart Language", rating: 10, col: Color.fromARGB(
      255, 226, 143, 159)),
  course(cid: 1006, cname: "RedHat Linux", rating: 6, col: Color.fromARGB(
      255, 144, 163, 197)),
  course(cid: 1007, cname: "Flutter", rating: 8, col: Color.fromARGB(
      255, 235, 182, 158)),
  course(cid: 1008, cname: "Web Development", rating: 8, col: Color.fromARGB(
      255, 46, 150, 149)),
  course(cid: 1009, cname: "Competitive Coding", rating: 5, col: Color.fromARGB(
      255, 227, 107, 97)),
  course(cid: 1010, cname: "DSA", rating: 7, col: Color.fromARGB(
      255, 227, 107, 97)),
  course(cid: 1011, cname: "AI/ML", rating: 8, col: Color.fromARGB(
      255, 22, 130, 168)),
  course(cid: 1012, cname: "Salesforce", rating: 9, col: Color.fromARGB(
      255, 228, 136, 157)),
  course(cid: 1013, cname: "PEGA", rating: 7, col: Color.fromARGB(
      255, 228, 136, 157)),
];