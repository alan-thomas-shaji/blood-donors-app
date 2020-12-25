import 'dart:convert';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils.dart' as ut;
import 'globals.dart' as g;
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';


bool reset=false;
class PasswordReset extends StatefulWidget {
  String username;
  PasswordReset({this.username});
  @override
  _PasswordResetState createState() => _PasswordResetState(username: username);
}

final GlobalKey<ScaffoldState> _scaffoldKey1 = new GlobalKey<ScaffoldState>();

class _PasswordResetState extends State<PasswordReset> {
  String username;
  _PasswordResetState({this.username});
  final GlobalKey<FormState> _formKey1 = new GlobalKey<FormState>();
  TextEditingController un = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  TextEditingController repass = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ut.maintheme(),
      home: ModalProgressHUD(
        progressIndicator: SpinKitHourGlass(color:Colors.red,size:80,),
        inAsyncCall: reset,
              child: Scaffold(
          key: _scaffoldKey1,
          appBar: AppBar(
            title: Text('Password Reset'),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
                key: _formKey1,
                autovalidate: true,
                child: Padding(
                  padding: EdgeInsets.all(50),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      //password
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter the new password';
                          } else {
                            return null;
                          }
                        },
                        obscureText: true,
                        controller: pass,
                        keyboardType: TextInputType.visiblePassword,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            prefixIcon:
                                (Icon(Icons.lock, color: Color(0xFFFB415B))),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelText: 'New Password',
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 20)),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty || value != pass.text) {
                            return "Passwords don't match";
                          } else {
                            return null;
                          }
                        },
                        obscureText: true,
                        controller: repass,
                        keyboardType: TextInputType.visiblePassword,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            prefixIcon:
                                (Icon(Icons.lock, color: Color(0xFFFB415B))),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelText: 'Confirm New Password',
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 20)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          callIt1(context);
                        },
                        child: Container(
                          margin: EdgeInsets.all(30),
                          height: 56.0,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                            gradient: LinearGradient(
                                colors: [Color(0xFFFB415B), Color(0xFFEE5623)],
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft),
                          ),
                          child: Center(
                            child: Text(
                              "Change",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  callIt1(BuildContext context) {
    setState(() {
      //checking weight and age
      if (!_formKey1.currentState.validate()) {
        g.submitForm(_formKey1, _scaffoldKey1,
            'Form is not valid!  Please review and correct.');
      } else {
        postData3(g.baseUrl, context);
      }
    });
  }

  postData3(String s, BuildContext context) async {
    setState(() {
      reset=true;
    });
    var bd = jsonEncode({
      "username": username,
      "password": pass.text,
    });
    var res = await http.post(s+"/coord_pass_reset.php", body: bd);
    String reg = "";
    reg = jsonDecode(res.body);
    setState(() {
      reset=false;
    });
    if (reg != 'Invalid Username..!' && reg != 'Try Again') {
      ut.showtoast(reg, Colors.green);
      Navigator.pop(context);
    }
    else{
      ut.showtoast(reg, Colors.red);
    }
  }
}
