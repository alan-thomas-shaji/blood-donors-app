import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:revive/notify.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils.dart' as ut;
import 'home.dart';
import 'intro.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'globals.dart' as g;

void main() async {
  //asyncFunc();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: Splash(),
    debugShowCheckedModeBanner: false,
  ));
}

SharedPreferences prefs;
asyncFunc(BuildContext) async {
  // Async func to handle Futures easier; or use Future.then
  prefs = await SharedPreferences.getInstance();
  var frun = prefs.getBool("frun");
  if (frun == true) {
    //Navigate to home
    Navigator.pushReplacement(
      BuildContext,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  } else {
    //Navigate to Intro
    Navigator.pushReplacement(
      BuildContext,
      MaterialPageRoute(builder: (context) => Intro()),
    );
  }
}

class Splash extends StatefulWidget {
  //HomeScreen({Key key}) : super(key: key);

  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => start(context));
  }

  void start(BuildContext) {
    asyncFunc(BuildContext);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Student Login',
        theme: ut.maintheme(),
        home: Scaffold(
            /*appBar: AppBar(
              title: Text("Splash"),
            ),*/

            body: Container(decoration: ut.bg())));
  }
}
