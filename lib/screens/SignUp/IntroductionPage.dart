// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:pecpocket/screens/SignUp/SignUp.dart';

class IntroductionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: OnBoardingPage(),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,

      pages: [
        PageViewModel(
          title: "Welcome to PecPocket",
          body:
              "A one stop app for all your college needs. Swipe to see what we can help you with",
          image: _buildImage('intro0.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Custom Reminders",
          body: "Never forget any other task you need to get done",
          image: _buildImage('intro1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Attendance Manager",
          body: "Wanna manage your attendance better? We got you covered.",
          image: _buildImage('intro2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "TimeTable",
          body:
              "Organize your schedule better with an inbuilt timetable manager",
          image: _buildImage('intro3.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Study Material",
          body:
              "Syllabus, notes, previous years question papers...\nYou name it we got it.",
          image: _buildImage('intro4.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Pec Social",
          body: "Connect and get more done",
          image: _buildImage('intro5.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.black,
      ),
      done: const Text('Done',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xffffbc0b),
        activeSize: Size(22.0, 10.0),
        activeColor: Color(0xffffbc0b),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
