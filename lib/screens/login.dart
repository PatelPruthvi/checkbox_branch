import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fb_cb/screens/listView.dart';
import 'package:fb_cb/screens/lv2.dart';
import 'package:fb_cb/screens/teacher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class loginScreen extends StatefulWidget {
  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(
                  labelText: 'E-Mail', hintText: 'Enter E-mail Address'),
            ),
            TextField(
              controller: pass,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Password', hintText: 'Enter Password'),
            ),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: name.text, password: pass.text);
                  String id = FirebaseAuth.instance.currentUser!.uid;

                  // ignore: use_build_context_synchronously
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => listView()));
                },
                child: Text('SUBMIT')),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: name.text, password: pass.text);
                  String id = FirebaseAuth.instance.currentUser!.uid;

                  // ignore: use_build_context_synchronously
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => teacherUI(enroll: id)));
                },
                child: Text('faculty login'))
          ],
        ),
      ),
    );
  }
}
