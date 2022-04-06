// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pecpocket/screens/IntroductionPage.dart';

void main() {
  runApp(EntryPoint());
}

class EntryPoint extends StatelessWidget {
  const EntryPoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroductionPage(),
    );
  }
}
