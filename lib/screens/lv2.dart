// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:ffi';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class listView2 extends StatefulWidget {
  String sub;
  String path;
  Query lv;
  listView2({
    Key? key,
    required this.sub,
    required this.path,
    required this.lv,
  }) : super(key: key);

  @override
  State<listView2> createState() => _listView2State();
}

class _listView2State extends State<listView2> {
  bool checkbox = true;
  List<String> sol = [];
  List<String> id = [];
  List<String> name = [];
  List<bool> cbval = [];

  late Map data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getD();
  }

  void getD() async {
    DatabaseEvent db = await FirebaseDatabase.instance.ref(widget.path).once();

    db.snapshot.children.forEach((element) async {
      sol.add(element.value.toString());
    });
    sol.forEach((element) async {
      DatabaseEvent rf =
          await FirebaseDatabase.instance.ref('trydb1/$element').once();
      Map data = rf.snapshot.value as Map;
      setState(() {
        id.add(data["id"]);
        name.add(data["name"]);
        cbval.add(data["cb"]);
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List View'),
        actions: [
          Checkbox(
              value: checkbox,
              onChanged: (val) {
                setState(() {
                  checkbox = val!;
                  for (int i = 0; i < cbval.length; i++) {
                    cbval[i] = checkbox;
                  }
                });
              })
        ],
      ),
      body: Column(children: [
        Expanded(
            child: ListView.builder(
                itemCount: id.length,
                itemBuilder: ((context, index) {
                  return CheckboxListTile(
                      title: Text(id[index]),
                      subtitle: Text(name[index]),
                      value: cbval[index],
                      onChanged: (val) {
                        setState(() {
                          cbval[index] = val!;
                        });
                      });
                }))),
        ElevatedButton(
            onPressed: () async {
              sol.forEach((element) async {
                await FirebaseDatabase.instance
                    .ref('trydb1/$element/subject/${widget.sub}')
                    .update({"total": ServerValue.increment(1)});
              });
              for (int i = 0; i < id.length; i++) {
                if (cbval[i] == true) {
                  await FirebaseDatabase.instance
                      .ref('trydb1/${sol[i]}/subject/${widget.sub}')
                      .update({"present": ServerValue.increment(1)});
                }
              }

              // DatabaseReference sub;
              // rf.snapshot.children.forEach((uid) async {
              //   sub = FirebaseDatabase.instance
              //       .ref("${widget.path}/${uid.key}/subject/${widget.sub}");
              //   await sub.update({'total': ServerValue.increment(1)});
              // });
              // rf.snapshot.children.forEach((uid) async {
              //   DatabaseEvent cb = await FirebaseDatabase.instance
              //       .ref("${widget.path}/${uid.key}")
              //       .once();
              //   List<String> sol = [];

              //   if (cb.snapshot.child('cb').value == true) {
              //     sol.add(uid.key.toString());
              //   }
              //   sol.forEach((element) {
              //     FirebaseDatabase.instance
              //         .ref("${widget.path}/${element}/subject/${widget.sub}")
              //         .update({'present': ServerValue.increment(1)});
              //   });
              // });

              Navigator.pop(context);
            },
            child: Text('SUBMIT'))
      ]),
    );
  }
}
