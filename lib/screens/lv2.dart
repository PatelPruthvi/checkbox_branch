// ignore_for_file: public_member_api_docs, sort_constructors_first

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
  bool cbval = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List View'),
        actions: [
          Checkbox(
              value: cbval,
              onChanged: (val) async {
                setState(() {
                  cbval = val!;
                });
                DatabaseEvent rf =
                    await FirebaseDatabase.instance.ref(widget.path).once();
                DatabaseReference sub;
                rf.snapshot.children.forEach((uid) {
                  sub = FirebaseDatabase.instance
                      .ref("${widget.path}/${uid.key}");
                  sub.update({"cb": cbval});
                });
              })
        ],
      ),
      body: Column(children: [
        Expanded(
          child: FirebaseAnimatedList(
              query: widget.lv.orderByChild('id'),
              itemBuilder: (context, snapshot, animation, index) {
                return CheckboxListTile(
                    title: Text(snapshot.child('id').value.toString()),
                    subtitle: Text(snapshot.child('name').value.toString()),
                    value: snapshot.child('cb').value as bool,
                    onChanged: ((value) {
                      setState(() {
                        DatabaseReference rf = FirebaseDatabase.instance
                            .ref("${widget.path}/${snapshot.key}");
                        rf.update({"cb": value!});
                      });
                    }));
              }),
        ),
        ElevatedButton(
            onPressed: () async {
              DatabaseEvent rf =
                  await FirebaseDatabase.instance.ref(widget.path).once();
              DatabaseReference sub;
              rf.snapshot.children.forEach((uid) async {
                sub = FirebaseDatabase.instance
                    .ref("${widget.path}/${uid.key}/subject/${widget.sub}");
                await sub.update({'total': ServerValue.increment(1)});
              });
              rf.snapshot.children.forEach((uid) async {
                DatabaseEvent cb = await FirebaseDatabase.instance
                    .ref("${widget.path}/${uid.key}")
                    .once();
                List<String> sol = [];

                if (cb.snapshot.child('cb').value == true) {
                  sol.add(uid.key.toString());
                }
                sol.forEach((element) {
                  FirebaseDatabase.instance
                      .ref("${widget.path}/${element}/subject/${widget.sub}")
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
