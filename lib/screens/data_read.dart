// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DashView extends StatefulWidget {
  String uid;
  DashView({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<DashView> createState() => _DashViewState();
}

class _DashViewState extends State<DashView> {
  @override
  void initState() {
    getD();
    super.initState();
  }

  void getD() async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("students/CE/6/CE1/LEC/students");
    DatabaseEvent eve = await ref.once();
    ref.child('name');
    ref.child('name');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [Text('hi')]),
    );
  }
}
