// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, curly_braces_in_flow_control_structures, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_types_as_parameter_names, prefer_is_empty, camel_case_types

import 'package:fb_cb/screens/txt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class getuserName extends StatefulWidget {
  String percent;
  String name;
  String roll;
  String DocumentID;
  String str;
  getuserName({
    Key? key,
    required this.percent,
    required this.name,
    required this.roll,
    required this.DocumentID,
    required this.str,
  }) : super(key: key);
  @override
  State<getuserName> createState() => _getuserNameState();
}

class _getuserNameState extends State<getuserName> {
  //String? DocumentID; // = FirebaseAuth.instance.currentUser!.uid;
  String? sname;

  int? dbAtt;
  int? dbTot;
  num overallTotal = 0;
  num overallAtt = 0;
  bool isLoading = true;
  TextStyle styleh2 = const TextStyle(
      color: Colors.deepPurpleAccent,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.0,
      fontSize: 20.0);

  ScrollController ScCont = ScrollController();
  @override
  void initState() {
    setState(() {
      getD();
    });

    super.initState();
  }

  Future getD() async {
    DatabaseEvent perc = await FirebaseDatabase.instance
        .ref('trydb1/${widget.DocumentID}/subject')
        .once();
    perc.snapshot.children.forEach((element) {
      Map data = element.value as Map;
      overallAtt = overallAtt + data['present'];
      overallTotal = overallTotal + data['present'];
    });
  }
  // Future getD() async {
  //   await FirebaseFirestore.instance
  //       .collection('user')
  //       .doc(widget.DocumentID)
  //       .collection('subject')
  //       .get()
  //       .then((value) {
  //     value.docs.forEach((element) {
  //       overallAtt = overallAtt + element['Att'];
  //       overallTotal = overallTotal + element['Tot'];
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // CollectionReference users = FirebaseFirestore.instance.collection('user');
    Query lv =
        FirebaseDatabase.instance.ref('/trydb1/${widget.DocumentID}/subject');
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text(
          widget.roll,
          style: TextStyle(
            letterSpacing: 2.0,
          ),
        ),
        backgroundColor: Colors.deepPurple[700],
        actions: <Widget>[
          // IconButton(
          //     onPressed: () {
          //       showDialog(context: context, builder: (ctx) => alertSign());
          //     },
          //     icon: Icon(Icons.power_settings_new_sharp))
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 30),
          TxtStyle(info1: 'NAME', info2: 'ID'),
          SizedBox(
            height: 5,
          ),
          Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              Expanded(
                child: Text(
                  " " + widget.name,
                  style: styleh2,
                ),
              ),
              Expanded(
                child: Text(widget.roll, style: styleh2),
              ),
            ],
          ),
          SizedBox(height: 30.0),
          TxtStyle(info1: 'PROGRAM', info2: 'ATTENDANCE PERCENT'),
          SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(widget.str, style: styleh2),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(widget.percent, style: styleh2),
                ),
              ),

              // Expanded(
              //     child: Lottie.network(
              //         'https://lottiefiles.com/132695-winking-emoji'))
              // Expanded(
              //   child: Text(
              //       double.parse(widget.percent) > 90
              //           ? ""
              //           : double.parse(widget.percent) > 80
              //               ? "GOOD"
              //               : double.parse(widget.percent) > 70
              //                   ? "AVERAGE"
              //                   : "DISASTER",
              //       style: styleh2),
              // ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Divider(color: Colors.black),
          SizedBox(height: 25),
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.deepPurpleAccent,
                  height: 35,
                  child: Center(
                    child: Text(
                      'ATTENDANCE SUMMARY',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 30,
                  color: Colors.deepPurpleAccent,
                  child: Center(
                    child: Text(
                      'Subject',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              VerticalDivider(width: 5),
              Expanded(
                child: Container(
                  height: 30,
                  color: Colors.deepPurpleAccent,
                  child: Center(
                    child: Text(
                      'Attended',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              VerticalDivider(width: 5),
              Expanded(
                child: Container(
                  height: 30,
                  color: Colors.deepPurpleAccent,
                  child: Center(
                    child: Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              VerticalDivider(width: 5),
              Expanded(
                child: Container(
                  height: 30,
                  color: Colors.deepPurpleAccent,
                  child: Center(
                    child: Text(
                      'Percent(%)',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
              child: FirebaseAnimatedList(
                  query: lv,
                  itemBuilder: ((context, snapshot, animation, index) {
                    Map data = snapshot.value as Map;

                    return Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Center(
                                  child: Text(snapshot.key.toString(),
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black)))),
                          Expanded(
                              child: Center(
                                  child: Text(data['present'].toString(),
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black)))),
                          Expanded(
                              child: Center(
                                  child: Text(data['total'].toString(),
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black)))),
                          Expanded(
                              child: Center(
                                  child: Text(
                                      ((data['present'] / data['total']) * 100)
                                          .toStringAsFixed(2),
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black)))),
                        ],
                      ),
                    );
                  }))),
          // Expanded(
          //   child: StreamBuilder(
          //     stream: FirebaseFirestore.instance
          //         .collection('user')
          //         .doc(widget.DocumentID)
          //         .collection('subject')
          //         .snapshots(),
          //     builder: (BuildContext,
          //         AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting)
          //         return Text('Please Wait');

          //       if (snapshot.hasData) {
          //         if (snapshot.data!.docs.length == 0) {
          //           return Center(
          //             child: Text("No data Found"),
          //           );
          //         } else {
          //           return ListView.builder(
          //               scrollDirection: Axis.vertical,
          //               controller: ScCont,
          //               physics: ScrollPhysics(),
          //               itemCount: snapshot.data!.docs.length,
          //               itemBuilder: (context, index) {
          //                 sname =
          //                     snapshot.data!.docs.elementAt(index).get('Sname');
          //                 dbAtt =
          //                     snapshot.data!.docs.elementAt(index).get('Att');
          //                 dbTot =
          //                     snapshot.data!.docs.elementAt(index).get('Tot');

          //                 return Padding(
          //                   padding: const EdgeInsets.only(top: 15.0),
          //                   child: Row(
          //                     children: [
          //                       Expanded(
          //                           child: Center(
          //                               child: Text(sname!,
          //                                   style: TextStyle(
          //                                       fontSize: 18.0,
          //                                       color: Colors.black)))),
          //                       Expanded(
          //                           child: Center(
          //                               child: Text(dbAtt.toString(),
          //                                   style: TextStyle(
          //                                       fontSize: 18.0,
          //                                       color: Colors.black)))),
          //                       Expanded(
          //                           child: Center(
          //                               child: Text(dbTot.toString(),
          //                                   style: TextStyle(
          //                                       fontSize: 18.0,
          //                                       color: Colors.black)))),
          //                       Expanded(
          //                           child: Center(
          //                               child: Text(
          //                                   (dbAtt! * 100 / dbTot!)
          //                                       .toStringAsFixed(2),
          //                                   style: TextStyle(
          //                                       fontSize: 18.0,
          //                                       color: Colors.black)))),
          //                     ],
          //                   ),
          //                 );
          //               });
          //         }
          //       } else {
          //         return Center(
          //           child: Text("Getting Error"),
          //         );
          //       }
          //     },
          //   ),
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                'Overall Attendance :  ' +
                    ((overallAtt / overallTotal) * 100).toStringAsFixed(2) +
                    "%",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
