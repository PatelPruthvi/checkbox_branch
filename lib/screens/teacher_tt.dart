// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fb_cb/screens/lv2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class TimeTable extends StatefulWidget {
  String day;
  TimeTable({
    Key? key,
    required this.day,
  }) : super(key: key);

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  @override
  Widget build(BuildContext context) {
    String id = FirebaseAuth.instance.currentUser!.uid;
    Query lv = FirebaseDatabase.instance.ref('faculty/$id/${widget.day}');
    return Scaffold(
      body: FirebaseAnimatedList(
        query: lv,
        itemBuilder: (context, snapshot, animation, index) {
          Map data = snapshot.value as Map;

          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Query pathtott =
                      FirebaseDatabase.instance.ref().child(data['path']);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => listView2(
                              lv: pathtott,
                              path: data['path'],
                              sub: data['subject'])));
                },
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  tileColor: Color.fromARGB(255, 209, 192, 238),
                  title: Text(snapshot.key.toString()),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
