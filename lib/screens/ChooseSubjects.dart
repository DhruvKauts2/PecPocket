// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pecpocket/classes/subjectClass.dart';
import 'package:pecpocket/globals.dart' as global;
import 'package:pecpocket/parsingModels/subjectModel.dart';

class ChooseSubjects extends StatefulWidget {
  const ChooseSubjects({Key? key}) : super(key: key);

  @override
  State<ChooseSubjects> createState() => _ChooseSubjectsState();
}

class _ChooseSubjectsState extends State<ChooseSubjects> {
  String toSearch = "";
  List<String> showSubjectList = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // ignore: prefer_const_literals_to_create_immutables
        body: Column(children: [
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
          showSubjectList.isEmpty
              ? Container(
                  color: Colors.green,
                  height: 500,
                  width: 400,
                )
              : Container(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  color: Colors.red,
                  height: 500,
                  width: 400,
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                      ),
                      itemCount: showSubjectList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 10,
                          color: Colors.amber,
                          child: Text(showSubjectList[index]),
                        );
                      }),
                )
        ]),
      ),
    );
  }

  void searchDatabase(String value) async {
    setState(() async {
      showSubjectList.clear();
      var response =
          await http.get(Uri.parse('${global.apiUrl}/Subjects/$value'));
      var subjectList = SubjectList.fromJson(json.decode(response.body));
      for (int i = 0; i < subjectList.subjects.length; i++) {
        showSubjectList.add(subjectList.subjects[i].subjectName);
      }
    });
  }
}
