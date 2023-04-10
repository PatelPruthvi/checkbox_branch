import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

String FY = "20";
String stream = "CE";
String div = "2";

Future userDetails() async {
  String id = FirebaseAuth.instance.currentUser!.uid;
  DatabaseEvent rf = await FirebaseDatabase.instance
      .ref("students/CE/6/CE2/LEC/students/$id")
      .once();

  return rf;
}

String email(String a) {
  String year = a.substring(0, 2);
  String stream = a.substring(3, 2);
  String div = a.substring(5, 3) as int > 60 ? "1" : "2";

  return year;
}
