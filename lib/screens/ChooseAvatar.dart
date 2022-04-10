// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pecpocket/screens/ChooseSubjects.dart';

class ChooseAvatar extends StatefulWidget {
  const ChooseAvatar({Key? key}) : super(key: key);

  @override
  State<ChooseAvatar> createState() => _ChooseAvatarState();
}

List<String> avatarList = [];
String chosenImage = 'assets/1.png';

class _ChooseAvatarState extends State<ChooseAvatar> {
  @override
  void initState() {
    super.initState();
    populateAvatarList();
  }

  int chosenIndex = 0;
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            height: 600,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: 54,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        chosenIndex = index;
                        chosenImage = 'assets/${avatarList[index]}';
                        print(chosenImage);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: chosenIndex == index
                                ? Colors.black
                                : Colors.white),
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
                      child: Image(
                        image: AssetImage('assets/${avatarList[index]}'),
                      ),
                    ),
                  );
                }),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 100),
              Container(
                height: 150,
                width: 150,
                child: Image(image: AssetImage(chosenImage)),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChooseSubjects()));
                  },
                  child: Text("Confirm"))
            ],
          )
        ]),
      ),
    );
  }

  void populateAvatarList() {
    if (avatarList.length != 0) {
      avatarList.clear();
    }
    for (int i = 1; i < 56; i++) {
      if (i == 41) continue;
      avatarList.add('${i}.png');
    }
  }
}
