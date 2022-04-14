// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pecpocket/globals.dart' as global;
import 'package:pecpocket/main.dart';
import 'package:pecpocket/parsingModels/attendanceModel.dart';
import 'package:pecpocket/screens/AddCustomReminder.dart';
import 'package:pecpocket/screens/PecSocial.dart';
import 'package:pecpocket/screens/StudyMaterial.dart';
import 'package:pecpocket/screens/TimeTable.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

List<String> attendanceSubjects = [];
List<int> classesAttended = [];
List<int> classesMissed = [];
List<String> classStatus = [];
bool isTile = false;

class _AttendanceState extends State<Attendance> {
  @override
  void initState() {
    super.initState();
    fetchAttendanceDataFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Attendance"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: isTile == false
                                ? MaterialStateProperty.all<Color>(Colors.black)
                                : MaterialStateProperty.all<Color>(
                                    Colors.white)),
                        onPressed: () {
                          setState(() {
                            isTile = false;
                          });
                        },
                        child: Text("Tile view")),
                  ),
                  SizedBox(width: 10),
                  Container(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: isTile == true
                                ? MaterialStateProperty.all<Color>(Colors.black)
                                : MaterialStateProperty.all<Color>(
                                    Colors.white)),
                        onPressed: () {
                          setState(() {
                            isTile = true;
                          });
                        },
                        child: Text("List view")),
                  )
                ],
              ),
            ),
            Container(
              height: 580,
              margin: EdgeInsets.only(top: 20),
              width: 360,
              child: isTile
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 3 / 4,
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                      itemCount: attendanceSubjects.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6),
                                bottomLeft: Radius.circular(6),
                                bottomRight: Radius.circular(6)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5),
                                Text(
                                  attendanceSubjects[index],
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                    'Classes Attended : ${classesAttended[index]}'),
                                Row(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 40,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(),
                                        child: Text(
                                          "-",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () async {
                                          setState(() {
                                            classesAttended[index]--;
                                            classStatus[index] =
                                                checkClassStatus(
                                                    classesAttended[index],
                                                    classesMissed[index]);
                                          });

                                          var response = await http.put(
                                              Uri.parse(
                                                  '${global.apiUrl}/Attendance'),
                                              headers: <String, String>{
                                                'Content-Type':
                                                    'application/json; charset=UTF-8',
                                              },
                                              body:
                                                  jsonEncode(<dynamic, dynamic>{
                                                'sid': 19103085,
                                                'subject':
                                                    attendanceSubjects[index],
                                                'classesAttended':
                                                    classesAttended[index],
                                                'classesMissed':
                                                    classesMissed[index],
                                                'classStatus':
                                                    classStatus[index]
                                              }));
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 30),
                                    Container(
                                      height: 20,
                                      width: 40,
                                      child: ElevatedButton(
                                          child: Text(
                                            "+",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () async {
                                            setState(() {
                                              classesAttended[index]++;
                                              classStatus[index] =
                                                  checkClassStatus(
                                                      classesAttended[index],
                                                      classesMissed[index]);
                                            });
                                            var response = await http.put(
                                                Uri.parse(
                                                    '${global.apiUrl}/Attendance'),
                                                headers: <String, String>{
                                                  'Content-Type':
                                                      'application/json; charset=UTF-8',
                                                },
                                                body: jsonEncode(<dynamic,
                                                    dynamic>{
                                                  'sid': 19103085,
                                                  'subject':
                                                      attendanceSubjects[index],
                                                  'classesAttended':
                                                      classesAttended[index],
                                                  'classesMissed':
                                                      classesMissed[index],
                                                  'classStatus':
                                                      classStatus[index]
                                                }));
                                          }),
                                    ),
                                  ],
                                ),
                                Text(
                                    'Classes Missed : ${classesMissed[index]}'),
                                Row(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 40,
                                      color: Colors.black,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(),
                                        child: Text(
                                          "-",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () async {
                                          setState(() {
                                            classesMissed[index]--;
                                            classStatus[index] =
                                                checkClassStatus(
                                                    classesAttended[index],
                                                    classesMissed[index]);
                                          });
                                          var response = await http.put(
                                              Uri.parse(
                                                  '${global.apiUrl}/Attendance'),
                                              headers: <String, String>{
                                                'Content-Type':
                                                    'application/json; charset=UTF-8',
                                              },
                                              body:
                                                  jsonEncode(<dynamic, dynamic>{
                                                'sid': 19103085,
                                                'subject':
                                                    attendanceSubjects[index],
                                                'classesAttended':
                                                    classesAttended[index],
                                                'classesMissed':
                                                    classesMissed[index],
                                                'classStatus':
                                                    classStatus[index]
                                              }));
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 30),
                                    Container(
                                      color: Colors.black,
                                      height: 20,
                                      width: 40,
                                      child: ElevatedButton(
                                        child: Text(
                                          "+",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () async {
                                          setState(() {
                                            classesMissed[index]++;
                                            classStatus[index] =
                                                checkClassStatus(
                                                    classesAttended[index],
                                                    classesMissed[index]);
                                          });
                                          var response = await http.put(
                                              Uri.parse(
                                                  '${global.apiUrl}/Attendance'),
                                              headers: <String, String>{
                                                'Content-Type':
                                                    'application/json; charset=UTF-8',
                                              },
                                              body:
                                                  jsonEncode(<dynamic, dynamic>{
                                                'sid': 19103085,
                                                'subject':
                                                    attendanceSubjects[index],
                                                'classesAttended':
                                                    classesAttended[index],
                                                'classesMissed':
                                                    classesMissed[index],
                                                'classStatus':
                                                    classStatus[index]
                                              }));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Text(classStatus[index])
                              ]),
                        );
                      })
                  : ListView.builder(
                      itemCount: attendanceSubjects.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                          margin: EdgeInsets.all(10),
                          height: 110,
                          child: Row(children: [
                            Container(
                              width: 200,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${index + 1}) ${attendanceSubjects[index]}",
                                        style: TextStyle(fontSize: 20)),
                                    Text(classStatus[index]),
                                  ]),
                            ),
                            Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5),
                                    Text(
                                        'Classes Attended : ${classesAttended[index]}'),
                                    Row(
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 40,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(),
                                            child: Text(
                                              "-",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () async {
                                              setState(() {
                                                classesAttended[index]--;
                                                classStatus[index] =
                                                    checkClassStatus(
                                                        classesAttended[index],
                                                        classesMissed[index]);
                                              });

                                              var response = await http.put(
                                                  Uri.parse(
                                                      '${global.apiUrl}/Attendance'),
                                                  headers: <String, String>{
                                                    'Content-Type':
                                                        'application/json; charset=UTF-8',
                                                  },
                                                  body: jsonEncode(<dynamic,
                                                      dynamic>{
                                                    'sid': 19103085,
                                                    'subject':
                                                        attendanceSubjects[
                                                            index],
                                                    'classesAttended':
                                                        classesAttended[index],
                                                    'classesMissed':
                                                        classesMissed[index],
                                                    'classStatus':
                                                        classStatus[index]
                                                  }));
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 30),
                                        Container(
                                          height: 20,
                                          width: 40,
                                          child: ElevatedButton(
                                              child: Text(
                                                "+",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () async {
                                                setState(() {
                                                  classesAttended[index]++;
                                                  classStatus[index] =
                                                      checkClassStatus(
                                                          classesAttended[
                                                              index],
                                                          classesMissed[index]);
                                                });
                                                var response = await http.put(
                                                    Uri.parse(
                                                        '${global.apiUrl}/Attendance'),
                                                    headers: <String, String>{
                                                      'Content-Type':
                                                          'application/json; charset=UTF-8',
                                                    },
                                                    body: jsonEncode(<dynamic,
                                                        dynamic>{
                                                      'sid': 19103085,
                                                      'subject':
                                                          attendanceSubjects[
                                                              index],
                                                      'classesAttended':
                                                          classesAttended[
                                                              index],
                                                      'classesMissed':
                                                          classesMissed[index],
                                                      'classStatus':
                                                          classStatus[index]
                                                    }));
                                              }),
                                        ),
                                      ],
                                    ),
                                    Text(
                                        'Classes Missed : ${classesMissed[index]}'),
                                    Row(
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 40,
                                          color: Colors.black,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(),
                                            child: Text(
                                              "-",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () async {
                                              setState(() {
                                                classesMissed[index]--;
                                                classStatus[index] =
                                                    checkClassStatus(
                                                        classesAttended[index],
                                                        classesMissed[index]);
                                              });
                                              var response = await http.put(
                                                  Uri.parse(
                                                      '${global.apiUrl}/Attendance'),
                                                  headers: <String, String>{
                                                    'Content-Type':
                                                        'application/json; charset=UTF-8',
                                                  },
                                                  body: jsonEncode(<dynamic,
                                                      dynamic>{
                                                    'sid': 19103085,
                                                    'subject':
                                                        attendanceSubjects[
                                                            index],
                                                    'classesAttended':
                                                        classesAttended[index],
                                                    'classesMissed':
                                                        classesMissed[index],
                                                    'classStatus':
                                                        classStatus[index]
                                                  }));
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 30),
                                        Container(
                                          color: Colors.black,
                                          height: 20,
                                          width: 40,
                                          child: ElevatedButton(
                                            child: Text(
                                              "+",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () async {
                                              setState(() {
                                                classesMissed[index]++;
                                                classStatus[index] =
                                                    checkClassStatus(
                                                        classesAttended[index],
                                                        classesMissed[index]);
                                              });
                                              var response = await http.put(
                                                  Uri.parse(
                                                      '${global.apiUrl}/Attendance'),
                                                  headers: <String, String>{
                                                    'Content-Type':
                                                        'application/json; charset=UTF-8',
                                                  },
                                                  body: jsonEncode(<dynamic,
                                                      dynamic>{
                                                    'sid': 19103085,
                                                    'subject':
                                                        attendanceSubjects[
                                                            index],
                                                    'classesAttended':
                                                        classesAttended[index],
                                                    'classesMissed':
                                                        classesMissed[index],
                                                    'classStatus':
                                                        classStatus[index]
                                                  }));
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                          ]),
                        );
                      }),
            ),
          ],
        ),
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

  increaseAttended(int index) {}

  void fetchAttendanceDataFromAPI() async {
    var response =
        await http.get(Uri.parse('${global.apiUrl}/Attendance/19103085'));
    var data = AttendanceList.fromJson(json.decode(response.body));

    setState(() {
      activePage = "Attendance";
      for (int i = 0; i < data.attendance.length; i++) {
        attendanceSubjects.add(data.attendance[i].subject);
        classesAttended.add(data.attendance[i].classesAttended);
        classesMissed.add(data.attendance[i].classesMissed);
        classStatus.add(data.attendance[i].classStatus);
      }
    });
  }

  String checkClassStatus(int classesAttended, int classesMissed) {
    double percentage =
        (classesAttended / (classesAttended + classesMissed)) * 100;
    if (percentage < 75) {
      int missable = 0;
      while (classesAttended / (classesAttended + classesMissed) < 0.75) {
        classesAttended++;
        missable++;
      }
      return "You must attend $missable classes to reach 75%";
    } else if (percentage > 75) {
      int missable = 0;
      while (classesAttended / (classesAttended + classesMissed) > 0.75) {
        classesMissed++;
        missable++;
      }
      return "You can miss $missable classes";
    } else {
      return "You are at 75% attendance, don't miss more classes";
    }
  }
}
