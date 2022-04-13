// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_init_to_null

import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pecpocket/globals.dart' as global;

class AddCustomReminder extends StatefulWidget {
  const AddCustomReminder({Key? key}) : super(key: key);

  @override
  State<AddCustomReminder> createState() => _AddCustomReminderState();
}

class _AddCustomReminderState extends State<AddCustomReminder> {
  DateTime? finalReminderDateTime = null;
  String weekDay = '';
  DateTime? finalDate = null;
  TimeOfDay? finalTime = null;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(height: 50),
        TextFormField(
          controller: titleController,
          decoration: InputDecoration(
              hintText: "Eg. Submit ML assignment", label: Text("Enter title")),
        ),
        SizedBox(height: 20),
        TextFormField(
          controller: descriptionController,
          decoration: InputDecoration(
              hintText: "Eg. Make sure to write sid",
              label: Text("Enter description")),
        ),
        SizedBox(height: 20),
        GestureDetector(
          onTap: selectDate,
          child: Row(children: [Text("Enter date"), Icon(Icons.date_range)]),
        ),
        SizedBox(height: 20),
        ElevatedButton(onPressed: sendToApi, child: Text("Confirm"))
      ]),
    );
  }

  void selectDate() async {
    var initialDate = DateTime.now();
    var selectedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: initialDate,
        lastDate: DateTime(2101));

    if (selectedDate != null && selectedDate != initialDate) {
      var initialTime = TimeOfDay.now();
      var selectedTime =
          await showTimePicker(context: context, initialTime: initialTime);

      if (selectedTime != null) {
        setState(() {
          finalDate = selectedDate;
          finalTime = selectedTime;
        });
      }
    }
  }

  void sendToApi() async {
    setState(() {
      finalReminderDateTime = DateTime(finalDate!.year, finalDate!.month,
          finalDate!.day, finalTime!.hour, finalTime!.minute);
    });
    print(finalReminderDateTime);
    var reminderTime = DateFormat('h:mm a').format(finalReminderDateTime);
    var reminderDate =
        DateFormat('EEEE, d MMM, yyyy').format(finalReminderDateTime);
    var response = await http.post(
      Uri.parse("${global.apiUrl}/CustomReminders"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<dynamic, dynamic>{
        'sid': 19103085,
        'reminderTitle': titleController.text,
        'reminderDescription': descriptionController.text,
        'reminderDate': reminderDate,
        'reminderTime': reminderTime
      }),
    );
    print(response);
  }
}
