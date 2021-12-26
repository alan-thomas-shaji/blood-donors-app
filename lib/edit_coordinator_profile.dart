import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:revive/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strings/strings.dart';
import 'dart:convert';
import 'globals.dart' as g;
import 'utils.dart' as ut;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
/* creted by Sandra*/

class EditCoordinatorProfile extends StatefulWidget {
  final String name;
  final String contacts;
  final String profession;
  final String location;
  final String email;
  final String vdr;
  final String exp;
  final String username;
  final String district;
  EditCoordinatorProfile({
    Key key,
    @required this.name,
    @required this.contacts,
    @required this.profession,
    @required this.location,
    @required this.email,
    @required this.vdr,
    @required this.exp,
    @required this.username,
    @required this.district,
  }) : super(key: key);
  @override
  _EditCoordinatorProfileState createState() => _EditCoordinatorProfileState(
      name,
      contacts,
      profession,
      location,
      email,
      vdr,
      exp,
      username,
      district);
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class _EditCoordinatorProfileState extends State<EditCoordinatorProfile> {
  String name;
  String contacts;
  String profession;
  String location;
  String email;
  String vdr;
  String exp;
  String username;
  String district;
  _EditCoordinatorProfileState(
    String name,
    String contacts,
    String profession,
    String location,
    String email,
    String vdr,
    String exp,
    String username,
    String district,
  ) {
    this.name = name;
    this.contacts = contacts;
    this.profession = profession;
    this.location = location;
    this.email = email;
    this.vdr = vdr;
    this.exp = exp;
    this.username = username;
    this.district = district;
  }

  initState() {
    super.initState();
    fn = new TextEditingController(text: this.name);
    pr = new TextEditingController(text: this.profession);
    cn = new TextEditingController(text: this.contacts);
    vd = new TextEditingController(text: this.vdr);
    mail = new TextEditingController(text: this.email);
    coexp = new TextEditingController(text: this.exp);
    d = this.district;
    tl = this.location;
    l = g.tlk[d];
  }

  //textediting controllers for all fields
  TextEditingController fn;
  TextEditingController pr;
  TextEditingController vd;
  TextEditingController cn;
  TextEditingController coexp;
  TextEditingController mail;

//required variables
  var t, r;
  Widget w = SizedBox(height: 10);
  String reg = "", d, tl, p;
  final GlobalKey<FormState> _key1 = new GlobalKey<FormState>();
  bool coord = false;

  List l = [];
  //mapping districts to their taluks

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ut.maintheme(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Edit Coordinator Profile'),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        body: ModalProgressHUD(
          progressIndicator: SpinKitHourGlass(
            color: Colors.red,
            size: 80,
          ),
          inAsyncCall: coord,
          child: Container(
            //upper beizer curved container
            decoration: ut.bg(),
            child: Scrollbar(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Form(
                        autovalidate: true,
                        key: _key1,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              //first name
                              validator: (value) =>
                                  value.isEmpty ? 'Field required...' : null,

                              controller: fn,
                              style: TextStyle(fontSize: 20),

                              decoration: InputDecoration(
                                  prefixIcon: (Icon(Icons.mood,
                                      color: Color(0xFFFB415B))),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide:
                                          BorderSide(color: Color(0xFFFB415B))),
                                  labelText: 'Name',
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                            ),

                            SizedBox(
                              height: 20,
                            ),
                            //district selector
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                  prefixIcon: (Icon(Icons.home,
                                      color: Color(0xFFFB415B))),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0))),
                              isExpanded: true,
                              validator: (value) =>
                                  value == null ? 'Field required...' : null,
                              hint: Text('Choose District',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              items: g.districts.map((lisVal) {
                                return DropdownMenuItem<String>(
                                  value: lisVal,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(lisVal,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20)),
                                      Divider()
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (String val) {
                                setState(() {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  this.d = val;
                                  l = g.tlk[d];
                                });
                                tl = null;
                              },
                              value: this.d,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //taluk selector
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                  prefixIcon: (Icon(Icons.home,
                                      color: Color(0xFFFB415B))),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0))),
                              isExpanded: true,
                              validator: (value) =>
                                  value == null ? 'Field required...' : null,
                              hint: Text('Choose Taluk',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              items: l.map((lisVal) {
                                return DropdownMenuItem<String>(
                                  value: lisVal,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(lisVal,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20)),
                                      Divider()
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (String val) {
                                setState(() {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  this.tl = val;
                                  print(tl);
                                });
                              },
                              value: this.tl,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //contact number
                            TextFormField(
                              validator: (value) => value.isEmpty
                                  ? 'Field required...'
                                  : value.length != 10
                                      ? 'Enter a valid number'
                                      : null,
                              controller: cn,
                              keyboardType: TextInputType.phone,
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                  prefixIcon: (Icon(Icons.phone,
                                      color: Color(0xFFFB415B))),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  labelText: 'Contact number',
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //alternate contact number
                            TextFormField(
                              validator: (value) =>
                                  value.isEmpty ? 'Field required...' : null,
                              controller: coexp,
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                  prefixIcon: (Icon(Icons.calendar_today,
                                      color: Color(0xFFFB415B))),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  labelText: 'Experience',
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //email
                            TextFormField(
                              controller: mail,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                  prefixIcon: (Icon(Icons.mail,
                                      color: Color(0xFFFB415B))),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //last donated
                            TextFormField(
                              controller: pr,
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                prefixIcon: (Icon(Icons.calendar_today,
                                    color: Color(0xFFFB415B))),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                labelText: 'Profession',
                                labelStyle: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            //button
                            InkWell(
                              onTap: () {
                                callIt(context);
                              },
                              child: Container(
                                margin: EdgeInsets.all(30),
                                height: 56.0,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40.0),
                                  gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFFB415B),
                                        Color(0xFFEE5623)
                                      ],
                                      begin: Alignment.centerRight,
                                      end: Alignment.centerLeft),
                                ),
                                child: Center(
                                  child: Text(
                                    "UPDATE",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  callIt(BuildContext context) {
    setState(() {
      //checking weight and age
      if (!_key1.currentState.validate()) {
        g.submitForm(_key1, _scaffoldKey,
            'Form is not valid!  Please review and correct.');
      } else {
        // if every data is available post details

        postData(g.baseUrl, context);
      }
    });
  }

  //to set username and password
  setPrefs1() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("name", fn.text);

    sp.setString("district", d);
    sp.setString("email", mail.text);
    sp.setString("profession", pr.text);
    sp.setString("location", tl);
    sp.setString("phone", cn.text);
    sp.setString("experience", coexp.text);
    sp.setString("verified_requests", vd.text);
  }

  postData(String s, BuildContext context) async {
    setState(() {
      coord = true;
    });
    var bd = json.encode({
      "name": fn.text,
      "district": d,
      "localty": tl,
      "contacts": cn.text,
      "profession": pr.text,
      "email": mail.text,
      "experience": coexp.text,
      "requests": vd.text,
      "uname": username,
    });
    var res = await http
        .post(Uri.parse(g.baseUrl + "/edit_coordinator_profile.php"), body: bd);
    print(res.statusCode);
    reg = jsonDecode(res.body);
    setState(() {
      coord = false;
    });
    print(res.body);
    if (reg != "Contact number Already Exists..!") {
      Navigator.pop(context, () {
        setState(() {});
      });
      setPrefs1();
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              jsonDecode(res.body),
              style: TextStyle(fontSize: 20, color: Color(0xFFEE5623)),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            contentPadding: EdgeInsets.all(20),
          );
        });
    reg = '';
  }
}
