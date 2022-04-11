// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:pecpocket/screens/ChooseAvatar.dart';
import 'package:pecpocket/screens/ChooseClubs.dart';
import 'package:pecpocket/screens/ChooseSubjects.dart';
import 'package:pecpocket/screens/IntroductionPage.dart';
import 'package:pecpocket/screens/MainPage.dart';
import 'package:pecpocket/screens/SignUp.dart';

void main() {
  runApp(EntryPoint());
}

class EntryPoint extends StatelessWidget {
  const EntryPoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
