// ignore_for_file: prefer_const_constructors, prefer_is_empty

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:pecpocket/classes/clubClass.dart';
import 'package:pecpocket/globals.dart' as global;
import 'package:pecpocket/parsingModels/clubModel.dart';
import 'package:pecpocket/screens/ChooseClubs.dart';
import 'package:pecpocket/screens/MainPage.dart';

class ChooseClubs extends StatefulWidget {
  const ChooseClubs({Key? key}) : super(key: key);

  @override
  State<ChooseClubs> createState() => _ChooseClubsState();
}

bool isShowClubListEmpty = true;
String toSearch = "";
List<String> showClubList = [];
List<String> showClubCodeList = [];
List<String> selectedClubsList = [];
List<String> selectedClubsCodeList = [];

class _ChooseClubsState extends State<ChooseClubs> {
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
                      labelText: "Enter Club name",
                    ),
                    onChanged: (value) {
                      toSearch = value;
                      searchDatabase(value);
                    },
                  ),
                ),
                if (isShowClubListEmpty == true) ...[
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
                        itemCount: showClubList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedClubsList.insert(
                                    0, showClubList[index]);
                                selectedClubsCodeList.insert(
                                    0, showClubCodeList[index]);
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
                                        showClubList[index],
                                        style: TextStyle(fontSize: 20),
                                      ))),
                                  Center(
                                      child: Text(
                                    showClubCodeList[index],
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
                        itemCount: selectedClubsList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                                right: 5, left: 5, top: 5, bottom: 5),
                            height: 50,
                            width: 170,
                            child: GestureDetector(
                              onLongPress: () {
                                setState(() {
                                  selectedClubsList
                                      .remove(selectedClubsList[index]);
                                  selectedClubsCodeList
                                      .remove(selectedClubsCodeList[index]);
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
                                    selectedClubsList[index]
                                        .replaceAll(' ', '\n'),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(selectedClubsCodeList[index],
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
                                builder: (context) => MainPage()));
                      },
                      child: Text("Confirm Clubs"))
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
        await http.get(Uri.parse('${global.apiUrl}/Clubs/$toSearch'));
    setState(() {
      showClubList.clear();
      showClubCodeList.clear();

      if (response.body.length == 2) {
        isShowClubListEmpty = true;
      } else {
        isShowClubListEmpty = false;
      }
      print(response.body);
      var clubList = ClubList.fromJson(json.decode(response.body));
      print(ClubList);
      for (int i = 0; i < clubList.clubs.length; i++) {
        showClubList.add(clubList.clubs[i].clubName);
        showClubCodeList.add(clubList.clubs[i].clubCode);
      }

      print(isShowClubListEmpty);
    });
  }
}
