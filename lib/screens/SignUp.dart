// ignore_for_file: file_names, unnecessary_const

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var signUpImages = [
    '1.png',
    '11.png',
    '16.png',
    '20.png',
    '22.png',
    '25.png'
  ];
  List<double> imageHeights = [5, 40, 25, 10, 10, 10];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: prefer_const_literals_to_create_immutables
      body: Column(children: [
        Container(
            decoration: const BoxDecoration(
                color: Color(0xffffbc0b),
                borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            height: 300,
            width: 500,
            child: MasonryGridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(top: imageHeights[index]),
                    height: 150,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.yellow[300],
                        border: Border.all(color: Colors.white, width: 1.5),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(20))),
                    child: Image(
                        image: AssetImage('assets/${signUpImages[index]}')),
                  );
                })),
        Container(
          margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Enter sid",
              labelStyle: TextStyle(fontSize: 20),
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: new BorderSide()),
            ),
          ),
        ),
      ]),
    );
  }
}
