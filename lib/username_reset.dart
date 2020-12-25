import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils.dart' as ut;
import 'globals.dart' as g;
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UsernameReset1 extends StatefulWidget {
  @override
  _UsernameReset1State createState() => _UsernameReset1State();
}

final GlobalKey<ScaffoldState> _scaffoldKey1 = new GlobalKey<ScaffoldState>();

class _UsernameReset1State extends State<UsernameReset1> {
  bool changed=false;
  final GlobalKey<FormState> _formKey1 = new GlobalKey<FormState>();
  TextEditingController un = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  TextEditingController repass = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ut.maintheme(),
      home: Scaffold(
        key: _scaffoldKey1,
        appBar: AppBar(
          title: Text('Username Reset'),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: ModalProgressHUD(
          progressIndicator: SpinKitHourGlass(color:Colors.red,size:80,),
          inAsyncCall: changed,
                  child: SingleChildScrollView(
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
                      //username
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your registered mobile number';
                          } else {
                            return null;
                          }
                        },
                        controller: un,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            prefixIcon:
                                (Icon(Icons.phone_android, color: Color(0xFFFB415B))),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelText: 'Registered Mobile Number',
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 20)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //password
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter the new username';
                          } else {
                            return null;
                          }
                        },
                       
                        controller: pass,
                        
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            prefixIcon:
                                (Icon(Icons.person, color: Color(0xFFFB415B))),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelText: 'New Username',
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
      changed=true;
   });
    final SharedPreferences sp = await SharedPreferences.getInstance();
    var bd = jsonEncode({
      "contacts": un.text,
      "username": pass.text,
    });
    var res = await http.post(s+"/username_reset.php", body: bd);
    String reg = "";
    print(res.statusCode);
    reg = jsonDecode(res.body);
    setState(() {
      changed=false;
    });
    print(res.body);
    if (reg != 'Invalid Username..!' && reg != 'Try Again') {
      sp.setString("password", ut.encrypt(pass.text));
      ut.showtoast(reg, Colors.green);
      Navigator.pop(context);
    }
    else{
      ut.showtoast(reg, Colors.red);
    }
  }
}
