import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'signup.dart';
import 'utils.dart' as ut;
import 'package:firebase_auth/firebase_auth.dart';
import 'globals.dart';

class MobileVerfication extends StatefulWidget {
  @override
  MobileVerficationState createState() => new MobileVerficationState();
}

class MobileVerficationState extends State<MobileVerfication> {
  final mobilecontroller = new TextEditingController();
  bool otpverified = false;
  String verificationId;
  String phonenumber;
  asyncFunc(BuildContext) async {}
  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      print("completed");
      setState(() {
        otpverified = true;
        phonenumber = mobilecontroller.text;
      });
      print(authResult);
      // FirebaseAuth.instance.signInWithCredential(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
      setState(() {
        otpverified = false;
      });
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      ut.showtoast("Please Enter a Mobile in this device", Colors.black);
      //  setState(() {
      //  this.codeSent = true;
      // });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 59),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

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
      title: 'Base',
      theme: ut.maintheme(),
      home: Scaffold(
          body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: ut.bg(),
        child: SingleChildScrollView(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipPath(
                clipper: ClippingClass(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xFFFB415B), Color(0xFFEE5623)],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 20),
                        child: Text(
                          'Welcome',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'To our family',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Text(
                          "Please enter your mobile number to continue",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        onChanged: (String text) {
                          if (text.length == 10) {
                            verifyPhone("+91" + text);
                          } else {
                            setState(() {
                              otpverified = false;
                            });
                          }
                        },
                        validator: (value) => value.isEmpty
                            ? 'Field required...'
                            : value.length != 10
                                ? 'Enter a valid number'
                                : null,
                        controller: mobilecontroller,
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                        keyboardType: TextInputType.phone,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            suffixIcon: otpverified
                                ? Icon(
                                    Icons.verified_user,
                                    color: Colors.green,
                                  )
                                : Text(""),
                            prefixIcon:
                                (Icon(Icons.phone, color: Color(0xFFFB415B))),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelText: 'Contact number',
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 20)),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(30, 10, 30, 10),
                              child: Opacity(
                                opacity: otpverified ? 1.0 : 0.0,
                                child: RaisedButton(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    onPressed: () {
                                      if (otpverified) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => SignUp(
                                                      contact_number:
                                                          phonenumber,
                                                    )));
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color: Colors.red,
                                    child: Text(
                                      "Continue",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ))
            ],
          )),
        ),
      )),
    );
  }
}
