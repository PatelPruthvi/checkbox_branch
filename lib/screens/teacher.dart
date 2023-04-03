// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fb_cb/screens/listView.dart';
import 'package:fb_cb/screens/lv2.dart';
import 'package:fb_cb/screens/teacher_tt.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class teacherUI extends StatefulWidget {
  String enroll;
  teacherUI({
    Key? key,
    required this.enroll,
  }) : super(key: key);

  @override
  State<teacherUI> createState() => _teacherUIState();
}

class _teacherUIState extends State<teacherUI> {
  var dateInputController = TextEditingController();
  DateTime? pickDate;
  String? dbDay;
  String day1 = DateFormat.EEEE().format(DateTime.now());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateInputController.text = DateFormat.EEEE().format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: dateInputController,
              // initialValue: day1.toString(),
              decoration: InputDecoration(
                  suffix: IconButton(
                    icon: Icon(Icons.calendar_month_outlined),
                    onPressed: () async {
                      pickDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2022),
                          lastDate: DateTime(2024));
                      dateInputController.text =
                          DateFormat.EEEE().format(pickDate!);
                    },
                  ),
                  hintText: 'Date',
                  border: OutlineInputBorder()),
              readOnly: true,
            ),
            ElevatedButton(
                onPressed: () {
                  day1 = dateInputController.text.toString();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TimeTable(day: day1)));
                },
                child: Text('Get Classes')),
          ],
        ),
      ),
    );
  }
}
