import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'globals.dart' as g;
import 'package:http/http.dart' as http;
import 'utils.dart' as ut;
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'home.dart';

class BloodRequest extends StatefulWidget {
  BloodRequest({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _BloodRequestState createState() => new _BloodRequestState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class _BloodRequestState extends State<BloodRequest> {
  List status = ["Emergency", "Not Emergency"];
  var stat;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String sbg, d, tl, re = "";
  final format = DateFormat("yyyy-MM-dd");
  final timeFormat = DateFormat("hh:mm a");
  DateTime req_date, req_time;
  var curr;
  String reg = "";
  bool unchange = false;
  TextEditingController patient = new TextEditingController();
  TextEditingController caseof = new TextEditingController();
  TextEditingController fn = new TextEditingController();
  TextEditingController age = new TextEditingController();
  TextEditingController weight = new TextEditingController();
  TextEditingController cn = new TextEditingController();
  TextEditingController acn = new TextEditingController();
  TextEditingController u = new TextEditingController();
  TextEditingController h = new TextEditingController();
  List l = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ut.maintheme(),
      home: new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: new Text("Blood request"),
        ),
        body: new SafeArea(
            top: false,
            bottom: false,
            child: ModalProgressHUD(
              progressIndicator: SpinKitHourGlass(
                color: Colors.red,
                size: 80,
              ),
              inAsyncCall: unchange,
              child: SingleChildScrollView(
                child: new Form(
                    key: _formKey,
                    autovalidate: true,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: new Column(
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          new TextFormField(
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
                                labelText: 'Bystander Name',
                                labelStyle: TextStyle(
                                    color: Colors.black, fontSize: 20)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                                prefixIcon: (Icon(Icons.invert_colors,
                                    color: Color(0xFFFB415B))),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                            isExpanded: true,
                            validator: (value) =>
                                value == null ? 'Field required...' : null,
                            hint: Text('Choose Patient\'s Blood group',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20)),
                            items: g.bloodgroup.map((lisVal) {
                              return DropdownMenuItem<String>(
                                value: lisVal,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(lisVal,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20)),
                                    Divider()
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (String val) {
                              setState(() {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                this.sbg = val;
                              });
                            },
                            value: this.sbg,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          new TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) =>
                                value.isEmpty ? 'Field required...' : null,
                            controller: age,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              prefixIcon:
                                  (Icon(Icons.cake, color: Color(0xFFFB415B))),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              labelText: 'Patient Age',
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 20),
                              hintText: 'Enter age',
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          new TextFormField(
                            validator: (value) =>
                                value.isEmpty ? 'Field required...' : null,
                            controller: patient,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              prefixIcon:
                                  (Icon(Icons.mood, color: Color(0xFFFB415B))),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              labelText: 'Patient Name',
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 20),
                              hintText: 'Enter Patient name',
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          new TextFormField(
                            validator: (value) =>
                                value.isEmpty ? 'Field required...' : null,
                            controller: caseof,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              prefixIcon: (Icon(Icons.local_hospital,
                                  color: Color(0xFFFB415B))),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              labelText: 'Case',
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 20),
                              hintText: 'Enter Case',
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          DateTimeField(
                              validator: (value) =>
                                  value == null ? 'Field required...' : null,
                              onChanged: (val) async {
                                req_date = val == null ? 0 : val;

                                var c = "${val.year}-${val.month}-${val.day}";
                                curr = c;
                                print(req_date);
                              },
                              decoration: InputDecoration(
                                  prefixIcon: (Icon(Icons.calendar_today,
                                      color: Color(0xFFFB415B))),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  labelText: 'When you need blood?',
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              format: format,
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                    context: context,
                                    initialDate: currentValue ?? DateTime.now(),
                                    firstDate: DateTime(2019),
                                    lastDate: DateTime(2200));
                              }),
                          SizedBox(height: 20),
                          DateTimeField(
                              validator: (value) =>
                                  value == null ? 'Field required...' : null,
                              onChanged: (val) async {
                                req_time = val == null ? 0 : val;
                                //print("req:$req_time");
                                //print(req_date.add(Duration(hours: req_time.hour,minutes: req_time.minute)));
                                print(req_time);
                              },
                              decoration: InputDecoration(
                                  prefixIcon: (Icon(Icons.access_time,
                                      color: Color(0xFFFB415B))),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  labelText: 'When you need blood?',
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              format: timeFormat,
                              onShowPicker: (context, currentValue) async {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(
                                      currentValue ?? DateTime.now()),
                                );
                                // print(DateTimeField.convert(time));
                                // print(time);

                                return DateTimeField.convert(time);
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          new TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) =>
                                value.isEmpty ? 'Field required...' : null,
                            controller: u,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              prefixIcon:
                                  (Icon(Icons.dock, color: Color(0xFFFB415B))),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              labelText: 'Units',
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 20),
                              hintText: 'Units of blood you need',
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            validator: (value) => value.isEmpty
                                ? 'Field required...'
                                : value.length != 10
                                    ? 'Enter a valid number'
                                    : null,
                            controller: cn,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
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
                            validator: (value) {
                              if (value.isNotEmpty && value.length != 10) {
                                return 'Please enter a valid contact number';
                              } else {
                                return null;
                              }
                            },
                            controller: acn,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.phone,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                                prefixIcon: (Icon(Icons.phone,
                                    color: Color(0xFFFB415B))),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                labelText: 'Alternate Contact number',
                                labelStyle: TextStyle(
                                    color: Colors.black, fontSize: 20)),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                                prefixIcon: (Icon(Icons.home,
                                    color: Color(0xFFFB415B))),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(lisVal,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20)),
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
                                    borderRadius: BorderRadius.circular(20.0))),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(lisVal,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20)),
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

                          new TextFormField(
                            validator: (value) =>
                                value.isEmpty ? 'Field required...' : null,
                            controller: h,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              prefixIcon: (Icon(Icons.local_hospital,
                                  color: Color(0xFFFB415B))),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              labelText: 'Hospital',
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 20),
                              hintText: 'Hospital name',
                            ),
                          ),
                          new SizedBox(height: 20),
                          g.g_l.isNotEmpty
                              ? DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                      prefixIcon: (Icon(Icons.label_important,
                                          color: Color(0xFFFB415B))),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0))),
                                  isExpanded: true,
                                  validator: (value) => value == null
                                      ? 'Field required...'
                                      : null,
                                  hint: Text('Emergency/Not Emergency',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 20)),
                                  items: status.map((lisVal) {
                                    return DropdownMenuItem<String>(
                                      value: lisVal,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(lisVal,
                                              style: TextStyle(fontSize: 20)),
                                          Divider()
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String val) {
                                    setState(() {
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                      this.stat = val;
                                    });
                                  },
                                  value: this.stat,
                                )
                              : SizedBox(width: 1),
                          //button
                          InkWell(
                            onTap: () {
                              _submitForm();
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
                                  "SUBMIT",
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
                    )),
              ),
            )),
      ),
    );
  }

  void _submitForm() {
    final FormState form = _formKey.currentState;

    if (!_formKey.currentState.validate()) {
      showMessage('Form is not valid!  Please review and correct.');
    } else {
      form.save();
      if (req_date != null && req_time != null)
        req_date = req_date
            .add(Duration(hours: req_time.hour, minutes: req_time.minute));
      getNotified();
      g.g_l.isEmpty
          ? postData1(context, g.baseUrl)
          : postData3(context, g.baseUrl); //This invokes each onSaved event
    }
  }

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
        backgroundColor: color,
        content: new Text(
          message,
          style: TextStyle(
            fontSize: 16,
          ),
        )));
  }

  getNotified() async {
    var scheduledNotificationDateTime = req_date.add(Duration(hours: 12));
    print(scheduledNotificationDateTime);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your other channel id', 'your other channel name',
        channelDescription: 'your other channel description',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails();
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Hi ' + fn.text,
        'Blood Request',
        scheduledNotificationDateTime,
        platformChannelSpecifics,
        payload: cn.text);
  }

  postData3(BuildContext context, String s) async {
    setState(() {
      unchange = true;
    });
    final SharedPreferences sp = await SharedPreferences.getInstance();
    var uname = sp.getString("username");
    //  String token=sp.getString("fcm_token");
    var bd = json.encode({
      "name": fn.text,
      "age": age.text,
      "bloodgroup": sbg,
      "district": d,
      "localty": tl,
      "contacts": cn.text,
      "alt_contacts": acn.text,
      "date": req_date.toString(),
      "status": stat,
      "units": u.text,
      "hosp": h.text,
      "verified": "Verified",
      "id": uname,
      "patient": patient.text,
      "case": caseof.text,
      "requested_time": DateTime.now().toString()
    });
    print(req_date);
    var res =
        await http.post(Uri.parse(s + "/coordinator_request.php"), body: bd);
    print(res.statusCode);
    reg = jsonDecode(res.body);
    setState(() {
      unchange = false;
    });
    print(reg);
    if (reg != "Try Again") {
      setState(() {
        Navigator.pop(context, () {
          setState(() {});
        });
        ut.showtoast(reg, Colors.green);
      });
    }
    reg = '';
  }

  postData1(BuildContext context, String s) async {
    setState(() {
      unchange = true;
    });
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString("fcm_token");
    var bd = json.encode({
      "name": fn.text,
      "age": age.text,
      "bloodgroup": sbg,
      "date": req_date.toString(),
      "district": d,
      "taluk": tl,
      "qty": u.text,
      "contacts": cn.text,
      "alt_contacts": acn.text,
      "hospital": h.text,
      "patient": patient.text,
      "case": caseof.text,
      "requested_time": DateTime.now().toString()
    });
    print(req_date);
    http.Response res =
        await http.post(Uri.parse(s + "/request.php"), body: bd);
    print(res.statusCode);
    print(res.body);
    re = jsonDecode(res.body);
    setState(() {
      unchange = false;
    });
    print(re);
    if (re != "Contact number Already Exists..!" && re != "Try Again") {
      _firebaseMessaging.subscribeToTopic(cn.text);
      Navigator.pop(context);
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              jsonDecode(res.body),
              style: TextStyle(fontSize: 20, color: Colors.purpleAccent),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            contentPadding: EdgeInsets.all(20),
          );
        });
  }
}
