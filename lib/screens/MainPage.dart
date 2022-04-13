// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe, prefer_const_constructors_in_immutables

// ignore: unnecessary_import
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:http/http.dart' as http;
import 'package:pecpocket/globals.dart' as global;
import 'package:pecpocket/main.dart';
import 'package:pecpocket/parsingModels/customReminderModel.dart';
import 'package:pecpocket/screens/AddCustomReminder.dart';
import 'dart:convert';
import 'package:pecpocket/screens/Attendance.dart';
import 'package:pecpocket/screens/PecSocial.dart';
import 'package:pecpocket/screens/StudyMaterial.dart';
import 'package:pecpocket/screens/TimeTable.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

List<String> reminderTitleList = [];
List<String> reminderDescriptionList = [];
List<String> reminderDateList = [];
List<String> reminderTimeList = [];

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
    print(activePage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DraggableBottomSheet(
        backgroundWidget: Scaffold(
          body: Container(),
        ),
        previewChild: Container(
          height: 100, width: 100,
          decoration: BoxDecoration(
              border: Border.all(width: 0.5),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          // ignore: prefer_const_literals_to_create_immutables
          child: Column(children: [
            Center(child: Icon(Icons.keyboard_arrow_up_outlined)),
            Expanded(
              child: ListView.builder(
                  itemCount: reminderTitleList.length > 3
                      ? 3
                      : reminderTitleList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(left: 20),
                      // height: 100,
                      // width: 100,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(reminderDateList[index]),
                                SizedBox(width: 100),
                                IconButton(
                                  onPressed: () {
                                    deleteReminder(index);
                                  },
                                  icon: Icon(Icons.cancel),
                                )
                              ],
                            ),
                            Divider(
                                color: Colors.black,
                                endIndent:
                                    MediaQuery.of(context).size.width * 0.3),
                            Text(
                              reminderTitleList[index],
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 10),
                            Text(
                              reminderDescriptionList[index],
                              textAlign: TextAlign.start,
                            ),
                            Divider(
                                thickness: 0.8,
                                color: Colors.black,
                                endIndent:
                                    MediaQuery.of(context).size.width * 0.3),
                            Row(
                              children: [
                                Text(reminderTimeList[index]),
                              ],
                            )
                          ]),
                    );
                  }),
            )
          ]),
        ),
        expandedChild: Container(
          height: 100, width: 100,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 0.5),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          // ignore: prefer_const_literals_to_create_immutables
          child: Column(children: [
            Center(child: Icon(Icons.keyboard_arrow_down_outlined)),
            Expanded(
              child: ListView.builder(
                  itemCount: reminderTitleList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(left: 20),
                      // height: 100,
                      // width: 100,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(reminderDateList[index]),
                                SizedBox(width: 100),
                                IconButton(
                                  onPressed: () {
                                    deleteReminder(index);
                                  },
                                  icon: Icon(Icons.cancel),
                                )
                              ],
                            ),
                            Divider(
                                color: Colors.black,
                                endIndent:
                                    MediaQuery.of(context).size.width * 0.3),
                            Text(
                              reminderTitleList[index],
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 10),
                            Text(
                              reminderDescriptionList[index],
                              textAlign: TextAlign.start,
                            ),
                            Divider(
                                thickness: 0.8,
                                color: Colors.black,
                                endIndent:
                                    MediaQuery.of(context).size.width * 0.3),
                            Row(
                              children: [
                                Text(reminderTimeList[index]),
                              ],
                            )
                          ]),
                    );
                  }),
            )
          ]),
        ),
        minExtent: 300,
        maxExtent: MediaQuery.of(context).size.height * 0.85,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu_book_rounded),
              onPressed: () {
                setState(() {
                  activePage = "StudyMaterial";
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StudyMaterial()));
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  activePage = "PecSocial";
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PecSocial()));
              },
            ),
            IconButton(
              icon: activePage == "MainPage"
                  ? Icon(Icons.add_circle_outline_rounded)
                  : Icon(Icons.home),
              onPressed: () {
                setState(() {
                  activePage = "MainPage";
                  if (activePage == "MainPage") {
                    print("Add Custom Reminder");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddCustomReminder()));
                  }
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.timelapse),
              onPressed: () {
                setState(() {
                  activePage = "Attendance";
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Attendance()));
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.calendar_month),
              onPressed: () {
                setState(() {
                  activePage = "TimeTable";
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TimeTable()));
              },
            ),
          ],
        ),
      ),
    );
  }

  void fetchDataFromApi() async {
    var response =
        await http.get(Uri.parse("${global.apiUrl}/CustomReminders/19103085"));

    setState(() {
      var customRemindersList =
          CustomReminderList.fromJson(json.decode(response.body));
      // print(customRemindersList.customReminders[0].reminderTitle);
      // print(customRemindersList.customReminders[0].reminderDescription);
      // print(customRemindersList.customReminders[0].reminderDate);
      // print(customRemindersList.customReminders[0].reminderTime);
      for (int i = 0; i < customRemindersList.customReminders.length; i++) {
        reminderTimeList
            .add(customRemindersList.customReminders[i].reminderTime);

        reminderDateList
            .add(customRemindersList.customReminders[i].reminderDate);

        reminderDescriptionList
            .add(customRemindersList.customReminders[i].reminderDescription);

        reminderTitleList
            .add(customRemindersList.customReminders[i].reminderTitle);
      }
      print(reminderTitleList);
      print(reminderDescriptionList);
      print(reminderDateList);
      print(reminderTimeList);

      activePage = "MainPage";
    });
  }

  Future<void> deleteReminder(int index) async {
    var response = await http.delete(
      Uri.parse("${global.apiUrl}/CustomReminders"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "sid": 19103085,
        "reminderTitle": reminderTitleList[index],
        "reminderDescription": reminderDescriptionList[index],
        "reminderDate": reminderDateList[index],
        "reminderTime": reminderTimeList[index],
      }),
    );

    print(response.body);

    setState(() {
      reminderTitleList.remove(reminderTitleList[index]);
      reminderDescriptionList.remove(reminderDescriptionList[index]);
      reminderDateList.remove(reminderDateList[index]);
      reminderTimeList.remove(reminderTimeList[index]);
    });
  }
}
