import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Intro extends StatefulWidget {
  @override
  IntroState createState() => new IntroState();
}

double imgsize = 150.0;
class IntroState extends State<Intro> {

  List<Slide> slides = new List();
  @override
  void initState() {
    super.initState();

    
    slides.add(
      new Slide(
        styleTitle: GoogleFonts.fugazOne(color: Colors.white,fontSize: 20),
        title: "Welcome to WK Blood Book",
        styleDescription: GoogleFonts.fugazOne(color:Colors.white),
        description: "You are somebody's life saver",
        pathImage: "assets/images/logo.png",// To shibiliya: Place logo path here then remove below line
        //centerWidget: Icon(Icons.chat,size: 140,color: Colors.white,),
        widthImage:imgsize,
        heightImage:imgsize,
        backgroundColor: Colors.red[400],
      ),
    );
    slides.add(
      new Slide(
        
        styleTitle: GoogleFonts.fugazOne(color: Colors.white,fontSize: 20),
        title: "Instant notifications",
        //pathImage: "images/intro3.png",
        description: "Never miss any notification from our side",
        styleDescription: GoogleFonts.fugazOne(color:Colors.white),

        centerWidget: Icon(Icons.notifications_active,size: 140,color: Colors.white,),

        widthImage:imgsize,
        heightImage:imgsize,
        backgroundColor: Color(0xff29B6F6),
      ),
    );
    slides.add(
      new Slide(
        styleDescription: GoogleFonts.fugazOne(color:Colors.white),
          styleTitle: GoogleFonts.fugazOne(color:Colors.white),
         
        title: "Verified Reqeusts",
        description: "We provide only verified requests",
        centerWidget: Icon(Icons.verified_user,size: 140,color: Colors.white,),
        widthImage:imgsize,
        heightImage:imgsize,
        backgroundColor: Colors.purple,
      ),
    );
    WidgetsBinding.instance
        .addPostFrameCallback((_) => start(context));
  }
  SharedPreferences prefs;
  void start(BuildContext){
    asyncFunc();
  }
  asyncFunc() async { // Async func to handle Futures easier; or use Future.then
    prefs = await SharedPreferences.getInstance();
  }
  @override
  void dispose() {
    super.dispose();
  }
  void onDonePress() async {

    prefs.setBool("frun", true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }
  @override
  Widget build(BuildContext context) {

    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
      colorDot: Color(0x55ffffff),
      colorActiveDot: Color(0xffffffff),

    );
  }
}