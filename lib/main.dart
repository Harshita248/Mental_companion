import "package:mental_companion/Class/Tabs.dart";
import 'package:mental_companion/Screen/DoctorLogin.dart';
import 'package:mental_companion/Screen/IntroSlider.dart';
import 'package:mental_companion/Screen/LoginScreen.dart';
import 'package:mental_companion/Screen/RegistrationScreen.dart';
import 'package:mental_companion/Screen/WelcomeScreen.dart';
import 'package:mental_companion/helper/helperfunctions.dart';
import 'package:flutter/material.dart';

import 'Screen/Home.dart';

void main() => runApp(MeditationApp());

class MeditationApp extends StatefulWidget {
  @override
  _MeditationAppState createState() => _MeditationAppState();
}

class _MeditationAppState extends State<MeditationApp> {

  @override

  late bool userIsLoggedIn;
  late bool firstseendon;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }


  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn  = value;
      });
    });
  }



  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Mental Companion",
      builder: (context,child)=> MediaQuery(
        data:MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child,
  
      ),
      home: userIsLoggedIn != null ?  userIsLoggedIn ? Tabs() : WelcomeScreen():Container(child: Center(child: IntroSlider()),),
      routes: <String,WidgetBuilder>{
//          '/': (context) => Splash(),
//        '/tabs':(context) => defaultTabController(),

        WelcomeScreen.id:(BuildContext context) => WelcomeScreen(),
        LoginScreen.id:(BuildContext context) => LoginScreen(),
        RegistrationScreen.id:(BuildContext context)=> RegistrationScreen(),
        IntroSlider.id:(BuildContext context)=> IntroSlider(),
        DoctorLogin.id:(BuildContext context)=>DoctorLogin(),
        Home.id:(BuildContext context) => Home(),

      },
    );
  }
}


