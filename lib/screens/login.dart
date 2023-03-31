import 'package:fb_cb/screens/data_read.dart';
import 'package:fb_cb/screens/listView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class loginScreen extends StatefulWidget {
  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  TextEditingController name = new TextEditingController();
  TextEditingController pass = new TextEditingController();
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
                  String id = await FirebaseAuth.instance.currentUser!.uid;

                  // ignore: use_build_context_synchronously
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => listView()));
                },
                child: Text('SUBMIT'))
          ],
        ),
      ),
    );
  }
}
