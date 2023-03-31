// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class listView extends StatefulWidget {
  listView({Key? key}) : super(key: key);

  @override
  State<listView> createState() => _listViewState();
}

class _listViewState extends State<listView> {
  Query lv = FirebaseDatabase.instance
      .ref("students/CE/6/CE1/LEC/students")
      .orderByChild('id');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List View')),
      body: Column(children: [
        Expanded(
          child: FirebaseAnimatedList(
              query: lv,
              itemBuilder: (context, snapshot, animation, index) {
                return CheckboxListTile(
                    title: Text(snapshot.child('id').value.toString()),
                    subtitle: Text(snapshot.child('name').value.toString()),
                    value: snapshot.child('cb').value as bool,
                    onChanged: ((value) {
                      setState(() {
                        DatabaseReference rf = FirebaseDatabase.instance.ref(
                            "students/CE/6/CE1/LEC/students/${snapshot.key}");
                        rf.update({"cb": value!});
                      });
                    }));
              }),
        ),
        ElevatedButton(
            onPressed: () async {
              DatabaseEvent rf = await FirebaseDatabase.instance
                  .ref("students/CE/6/CE1/LEC/students")
                  .once();
              DatabaseReference sub;
              rf.snapshot.children.forEach((uid) async {
                sub = FirebaseDatabase.instance.ref(
                    "students/CE/6/CE1/LEC/students/${uid.key}/subject/CN");
                await sub.update({'total': ServerValue.increment(1)});
              });
              rf.snapshot.children.forEach((uid) async {
                DatabaseEvent cb = await FirebaseDatabase.instance
                    .ref("students/CE/6/CE1/LEC/students/${uid.key}")
                    .once();
                List<String> sol = [];

                if (cb.snapshot.child('cb').value == true) {
                  sol.add(uid.key.toString());
                }
                sol.forEach((element) {
                  FirebaseDatabase.instance
                      .ref("students/CE/6/CE1/LEC/students/$element/subject/CN")
                      .update({'present': ServerValue.increment(1)});
                });
              });

              Navigator.pop(context);
            },
            child: Text('SUBMIT'))
      ]),
    );
  }
}
