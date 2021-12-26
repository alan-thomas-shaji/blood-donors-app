import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:revive/coord_pass_reset.dart';
import 'package:revive/password_reset.dart';
import 'utils.dart' as ut;
import 'globals.dart' as g;
import 'package:http/http.dart' as http;

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/material.dart';

class Passwordresetverify extends StatefulWidget {
  String type;
  Passwordresetverify({this.type});
  @override
  PasswordresetverifyState createState() =>
      new PasswordresetverifyState(type: type);
}

class PasswordresetverifyState extends State<Passwordresetverify> {
  String type;
  String username;
  String contactnumber, smsotp;
  PasswordresetverifyState({this.type});
  bool verifyform = false;
  asyncFunc(BuildContext) async {}

  final GlobalKey<ScaffoldState> _scaffoldKey1 = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey1 = new GlobalKey<FormState>();
  bool passchange = false;
  TextEditingController un = new TextEditingController();
  TextEditingController otp = new TextEditingController();

  bool otpverified = false;
  String verificationId;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => start(context));
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
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
        title: 'Base',
        theme: ut.maintheme(),
        home: Scaffold(
            key: _scaffoldKey1,
            appBar: AppBar(
              title: Text('Password Reset'),
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios),
              ),
            ),
            body: ModalProgressHUD(
              progressIndicator: SpinKitHourGlass(
                color: Colors.red,
                size: 80,
              ),
              inAsyncCall: passchange,
              child: SingleChildScrollView(
                  child: Stack(
                children: <Widget>[
                  verifyform
                      ? verifyformscreen()
                      : Form(
                          key: _formKey1,
                          autovalidate: true,
                          child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  //username
                                  Text(
                                    "Please Enter the Username to continue",
                                    style: GoogleFonts.fugazOne(),
                                  ),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter a username';
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: un,
                                    style: TextStyle(fontSize: 20),
                                    decoration: InputDecoration(
                                        prefixIcon: (Icon(Icons.person,
                                            color: Color(0xFFFB415B))),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        labelText: 'Username',
                                        labelStyle: TextStyle(
                                            color: Colors.black, fontSize: 20)),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  RaisedButton(
                                      onPressed: () {
                                        postData2(g.baseUrl, context);
                                      },
                                      padding:
                                          EdgeInsets.fromLTRB(25, 5, 25, 5),
                                      color: Colors.red,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Text("Continue"))
                                ],
                              )),
                        ),
                ],
              )),
            )));
  }

  postData2(String s, BuildContext context) async {
    setState(() {
      passchange = true;
      username = un.text;
    });
    print(type);
    var bd = jsonEncode({"username": un.text, "type": type});
    var res = await http.post(Uri.parse(s + "/user_details.php"), body: bd);
    var reg = "";
    print(res.statusCode);
    setState(() {
      passchange = false;
    });
    if (res.body == 'Invalid Username') {
      ut.showtoast(reg, Colors.red);
    } else {
      var data = jsonDecode(res.body);

      if (type == 'coordinators') {
        setState(() {
          verifyform = true;
          contactnumber = data['phone'].toString();
          verifyPhone("+91" + contactnumber);
        });
      } else {
        print("here");
        setState(() {
          verifyform = true;
          contactnumber = data['contacts'].toString();
          verifyPhone("+91" + contactnumber);
        });
      }
    }
  }

  Widget verifyformscreen() => Form(
        key: _formKey1,
        autovalidate: true,
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                //username
                Text(
                  "Enter the Otp  send to your mobile",
                  style: GoogleFonts.fugazOne(),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: otp,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      prefixIcon:
                          (Icon(Icons.person, color: Color(0xFFFB415B))),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'OTP',
                      labelStyle: TextStyle(color: Colors.black, fontSize: 20)),
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                    padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: () {
                      signIn();
                    },
                    //postData2(g.baseUrl, context);},
                    child: Text(
                      "Continue",
                      style: TextStyle(),
                    ))
              ],
            )),
      );

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      print("completed");
      setState(() {
        otpverified = true;
      });

      type == 'users'
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => PasswordReset1(
                        username: username,
                      )))
          : Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => PasswordReset(
                        username: username,
                      )));
      print(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
      setState(() {
        otpverified = false;
      });
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

  signIn() async {
    if (otpverified) {
      type == 'users'
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => PasswordReset1(
                        username: username,
                      )))
          : Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => PasswordReset(
                        username: username,
                      )));
    } else {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp.text,
      );
      try {
        await _auth
            .signInWithCredential(credential)
            .then((UserCredential value) {
          if (value.user != null) {
            type == 'users'
                ? Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PasswordReset1(
                              username: username,
                            )))
                : Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PasswordReset(
                              username: username,
                            )));
            _auth.signOut();
          } else {
            ut.showtoast("Wrong otp ", Colors.red);
          }
        });
      } catch (e) {
        ut.showtoast("Invalid otp ", Colors.red);
      }
    }
  }
}
