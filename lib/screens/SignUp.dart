// ignore_for_file: file_names, unnecessary_const, prefer_const_constructors

import 'dart:convert';
import 'dart:math';
import 'package:mailer2/mailer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pecpocket/globals.dart' as global;
import 'package:http/http.dart' as http;
import 'package:pecpocket/screens/ChooseAvatar.dart';

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
  bool isActive = false;
  TextEditingController sidTextController = TextEditingController();
  TextEditingController otpTextController = TextEditingController();

  int otp = 100000 + Random().nextInt(999999 - 100000);

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
            controller: sidTextController,
            decoration: InputDecoration(
              labelText: "Enter sid",
              labelStyle: TextStyle(fontSize: 20),
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide()),
            ),
          ),
        ),
        Center(
          child: Container(
            child: ElevatedButton(
              child: Text("Submit SID"),
              onPressed: checkSidInSuper,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: TextFormField(
            controller: otpTextController,
            decoration: InputDecoration(
              labelText: "Enter OTP sent to your PEC email id",
              labelStyle: TextStyle(fontSize: 20),
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide()),
            ),
          ),
        ),
        Center(
          child: Container(
            child: ElevatedButton(
              child: Text("Submit OTP"),
              onPressed: isActive ? checkOTP : null,
            ),
          ),
        ),
      ]),
    );
  }

  checkSidInSuper() async {
    var response = await http.post(
      Uri.parse("${global.apiUrl}/signUp"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'sid': sidTextController.text,
      }),
    );

    print(response.body);

    if (response.body == "200") {
      setState(() {
        isActive = true;
      });

      var options = GmailSmtpOptions()
        ..username = 'pecpocket@gmail.com'
        ..password = 'pecpocket123';

      var emailTransport = SmtpTransport(options);

      var envelope = Envelope()
        ..from = 'pecpocket@gmail.com'
        ..recipients.add('theofficial.kauts@gmail.com')
        ..subject = 'Welcome to PecPocket'
        ..html = '<h3>$otp<h3>\n<p></p>';

      await emailTransport.send(envelope);
    }
  }

  void checkOTP() {
    if (otpTextController.text == otp.toString()) {
      setState(() {
        for (int i = 1; i < 56; i++) {
          if (i == 41) continue;
          avatarList.add('${i}.png');
        }
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChooseAvatar()));
      });
    }
  }
}
