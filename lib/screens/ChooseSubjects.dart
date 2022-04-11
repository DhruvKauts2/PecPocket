// ignore_for_file: prefer_const_constructors, prefer_is_empty

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:pecpocket/classes/subjectClass.dart';
import 'package:pecpocket/globals.dart' as global;
import 'package:pecpocket/parsingModels/subjectModel.dart';
import 'package:pecpocket/screens/ChooseClubs.dart';

class ChooseSubjects extends StatefulWidget {
  const ChooseSubjects({Key? key}) : super(key: key);

  @override
  State<ChooseSubjects> createState() => _ChooseSubjectsState();
}

bool isShowSubjectListEmpty = true;
String toSearch = "";
List<String> showSubjectList = [];
List<String> showSubjectCodeList = [];
List<String> selectedSubjectsList = [];
List<String> selectedSubjectsCodeList = [];

class _ChooseSubjectsState extends State<ChooseSubjects> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // ignore: prefer_const_literals_to_create_immutables
        body: Wrap(
          children: [
            Column(
              children: [
                Container(
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
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(top: 70, left: 10, right: 10),
                  child: TextFormField(
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      labelText: "Enter subject name or subject code",
                    ),
                    onChanged: (value) {
                      toSearch = value;
                      searchDatabase(value);
                    },
                  ),
                ),
                if (isShowSubjectListEmpty == true) ...[
                  Container(
                    color: Colors.green,
                    height: 500,
                    width: 400,
                  )
                ] else ...[
                  Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    height: 475,
                    width: 400,
                    child: GridView.builder(
                        physics: ScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: (1 / 0.2),
                        ),
                        itemCount: showSubjectList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSubjectsList.insert(
                                    0, showSubjectList[index]);
                                selectedSubjectsCodeList.insert(
                                    0, showSubjectCodeList[index]);
                              });
                            },
                            child: Container(
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
                                    spreadRadius: 3,
                                    blurRadius: 3,
                                    offset: Offset(
                                        0, 0), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Center(
                                          child: Text(
                                        showSubjectList[index],
                                        style: TextStyle(fontSize: 20),
                                      ))),
                                  Center(
                                      child: Text(
                                    showSubjectCodeList[index],
                                    style: TextStyle(fontSize: 20),
                                  )),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  Container(
                    height: 125,
                    width: 350,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedSubjectsList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                                right: 5, left: 5, top: 5, bottom: 5),
                            height: 50,
                            width: 170,
                            child: GestureDetector(
                              onLongPress: () {
                                setState(() {
                                  selectedSubjectsList
                                      .remove(selectedSubjectsList[index]);
                                  selectedSubjectsCodeList
                                      .remove(selectedSubjectsCodeList[index]);
                                });
                              },
                              child: Container(
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
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: Offset(
                                          0, 0), // changes position of shadow
                                    ),
                                  ],
                                ),
                                margin: EdgeInsets.only(top: 20),
                                child: Column(children: [
                                  Text(
                                    selectedSubjectsList[index]
                                        .replaceAll(' ', '\n'),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(selectedSubjectsCodeList[index],
                                      style: TextStyle(fontSize: 20))
                                ]),
                              ),
                            ),
                          );
                        }),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChooseClubs()));
                      },
                      child: Text("Confirm Subjects"))
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }

  void searchDatabase(String value) async {
    var response =
        await http.get(Uri.parse('${global.apiUrl}/Subjects/$value'));
    setState(() {
      showSubjectList.clear();
      showSubjectCodeList.clear();

      if (response.body.length == 2) {
        isShowSubjectListEmpty = true;
      } else {
        isShowSubjectListEmpty = false;
      }
      print(response.body);
      var subjectList = SubjectList.fromJson(json.decode(response.body));
      for (int i = 0; i < subjectList.subjects.length; i++) {
        showSubjectList.add(subjectList.subjects[i].subjectName);
        showSubjectCodeList.add(subjectList.subjects[i].subjectCode);
      }

      print(isShowSubjectListEmpty);
    });
  }
}
