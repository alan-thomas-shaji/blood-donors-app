import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:revive/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strings/strings.dart';
import 'dart:convert';
import 'globals.dart' as g;
import 'utils.dart' as ut;
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/* creted by Sandra*/

class EditProfile extends StatefulWidget {
  final String name;
  final String age;
  final String contacts;
  final String alt_contacts;
  final String gender;
  final String weight;
  final String location;
  final String group;
  final String last_don;
  final String email;
  final String status;
  final String for_time;
  final String username;
  final String district;
  EditProfile({
    Key key,
    @required this.name,
    @required this.age,
    @required this.gender,
    @required this.weight,
    @required this.group,
    @required this.district,
    @required this.location,
    @required this.contacts,
    @required this.alt_contacts,
    @required this.email,
    @required this.last_don,
    @required this.status,
    @required this.for_time,
    @required this.username,
  }) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState(
      name,
      age,
      gender,
      weight,
      group,
      district,
      location,
      contacts,
      alt_contacts,
      email,
      last_don,
      status,
      for_time,
      username);
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class _EditProfileState extends State<EditProfile> {
  String k = '';
  String name;
  String ag;
  String contacts;
  String alt_contacts;
  String gend;
  String weigh;
  String location;
  String group;
  String last_don;
  String email;
  String sta;
  String for_time;
  String username;
  String district;
  _EditProfileState(
      String name,
      String ag,
      String gend,
      String weigh,
      String group,
      String district,
      String location,
      String contacts,
      String alt_contacts,
      String email,
      String last_don,
      String sta,
      String for_time,
      String username) {
    this.name = name;
    this.ag = ag;
    this.gend = gend;
    this.weigh = weigh;
    this.group = group;
    this.district = district;
    this.location = location;
    this.contacts = contacts;
    this.alt_contacts = alt_contacts;
    this.email = email;
    this.last_don = last_don;
    this.sta = sta;
    this.for_time = for_time;
    this.username = username;
  }
  initState() {
    super.initState();
    fn = new TextEditingController(text: this.name);
    age = new TextEditingController(text: this.ag);
    weight = new TextEditingController(text: this.weigh);
    cn = new TextEditingController(text: this.contacts);
    acn = new TextEditingController(text: this.alt_contacts);
    mail = new TextEditingController(text: this.email);
    curr=this.last_don;
    curr1=this.for_time;
    un = new TextEditingController(text: this.username);
    sbg = this.group;
    st = this.sta;
    gen = capitalize(this.gend);
    d = this.district;
    l = g.tlk[d];
    tl = this.location;
    if (st != status[0]) {
      w = callFor();
    } else {
      w = SizedBox(height: 10);
    }
  }

  //textediting controllers for all fields
  final format = DateFormat("yyyy-MM-dd");
  var curr,curr1;
  TextEditingController fn;
  TextEditingController age;
  TextEditingController weight;
  TextEditingController cn;
  TextEditingController acn;
  TextEditingController mail;
  TextEditingController un;

//required variables
  var t, r;
  bool edited=false;
  Widget w = SizedBox(height: 10);
  String reg = "", sbg, st, gen, d, tl, p, m;
  final GlobalKey<FormState> _key1 = new GlobalKey<FormState>();

  List gender = ['Male', 'Female', 'Others'];
  bool checked = false;
  List status = ['Available anytime', 'Available for', 'Unavailable for'];

  List med = [
    'None',
    'HIV',
    'Heart disease',
    'Hypertension',
    'Cancer',
    'Received Hepatitis B vaccine',
    'Major dental procedures/general surgeries in the past 1 month',
    'Fits',
    'Asthma',
    'Epilepsy',
    'Kidney ailments',
    'Diabetes',
    'Ear/body piercing/tatoo in past 6 months',
    'Undergone Immunization in the past 1 month',
    'Treated for rabies',
    'Pregnant/breast feeding',
    'Women undergone miscarriage in the past 6 months',
    'Tuberculosis',
    'Allergy to a substance used in blood donation/Severe allergy/unwell at the time of donation due to allergy'
  ];
  //list of districts

  List l = [];
  //mapping districts to their taluks

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ut.maintheme(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
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
          progressIndicator: SpinKitHourGlass(color:Colors.red,size:80,),
          inAsyncCall: edited,
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

                            //gender dropdown
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                  prefixIcon:
                                      (Icon(Icons.wc, color: Color(0xFFFB415B))),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0))),
                              isExpanded: true,
                              validator: (value) =>
                                  value == null ? 'Field required...' : null,
                              hint: Text('Choose gender',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              items: gender.map((lisVal) {
                                return DropdownMenuItem<String>(
                                  value: lisVal,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(lisVal,
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 20)),
                                      Divider(),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (String val) {
                                setState(() {
                                  FocusScope.of(context).requestFocus(new FocusNode());
                                  this.gen = val;
                                });
                              },
                              value: this.gen,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //age field
                            TextFormField(
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
                                labelText: 'Age',
                                labelStyle:
                                    TextStyle(color: Colors.black, fontSize: 20),
                                hintText: 'Between 18 and 65',
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //weight field
                            TextFormField(
                              validator: (value) =>
                                  value.isEmpty ? 'Field required...' : null,
                              controller: weight,
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                  prefixIcon: (Icon(Icons.timelapse,
                                      color: Color(0xFFFB415B))),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  labelText: 'Weight(in Kg)',
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                  hintText: 'Should be 50 or above'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //blood group dropdown
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                  prefixIcon: (Icon(Icons.invert_colors,
                                      color: Color(0xFFFB415B))),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0))),
                              isExpanded: true,
                              validator: (value) =>
                                  value == null ? 'Field required...' : null,
                              hint: Text('Choose Blood group',
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
                                  FocusScope.of(context).requestFocus(new FocusNode());
                                  this.sbg = val;
                                });
                              },
                              value: this.sbg,
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
                                  FocusScope.of(context).requestFocus(new FocusNode());
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
                                  FocusScope.of(context).requestFocus(new FocusNode());
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
                              validator: (value) {
                                if (value.isNotEmpty && value.length != 10) {
                                  return 'Please enter a valid contact number';
                                } else {
                                  return null;
                                }
                              },
                              controller: acn,
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
                            DateTimeField(
                                onChanged: (val){
                                  var c="${val.year}-${val.month}-${val.day}";
                                  curr=c;
                                },
                                  decoration: InputDecoration(
                                      prefixIcon: (Icon(Icons.calendar_today,
                                          color: Color(0xFFFB415B))),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      labelText: 'Last donated on $curr',
                                      //hintText: curr,
                                      labelStyle: TextStyle(
                                          color: Colors.black, fontSize: 20)),
                                  format: format,
                                  onShowPicker: (context, currentValue) {
                                    
                                    return showDatePicker(
                                        context: context,
                                        initialDate:
                                           currentValue??DateTime.now(),
                                        firstDate: DateTime(2019),
                                        lastDate: DateTime(2200));
                                  }),
                            SizedBox(
                              height: 20,
                            ),
                            //status-available or unavailable
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                  prefixIcon: (Icon(Icons.event_available,
                                      color: Color(0xFFFB415B))),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0))),
                              isExpanded: true,
                              validator: (value) =>
                                  value == null ? 'Field required...' : null,
                              hint: Text('Choose Status',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              items: status.map((lisVal) {
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
                                  FocusScope.of(context).requestFocus(new FocusNode());
                                  this.st = val;
                                  if (st != status[0]) {
                                    w = callFor();
                                    
                                  } else {
                                    curr1='';
                                    w = SizedBox(height: 10);
                                  }
                                });
                              },
                              value: this.st,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            w, //if available for/unavailable for till when its valid
  SizedBox(height:20),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                  prefixIcon: (Icon(Icons.local_hospital,
                                      color: Color(0xFFFB415B))),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0))),
                              isExpanded: true,
                              validator: (value) =>
                                  value == null ? 'Field required...' : null,
                              hint: Text(
                                  'Do you have any of the medical conditions given?',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              items: med.map((lisVal) {
                                return DropdownMenuItem<String>(
                                  value: lisVal,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(lisVal,
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 20)),
                                      Divider(),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (String val) {

                                setState(() {
                                  FocusScope.of(context).requestFocus(new FocusNode());
                                  this.m = val;
                                });
                              },
                              value: this.m,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //username

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
        if (int.parse(weight.text) < 50 ||
            int.parse(age.text) < 18 ||
            int.parse(age.text) > 65 ||
            m != 'None') {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text(
                    "Sorry,you are not eligible to continue",
                    style: TextStyle(fontSize: 20, color: Color(0xFFEE5623)),
                  ),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () async {
                          final SharedPreferences sp =
                              await SharedPreferences.getInstance();
                          var bd = jsonEncode({"username": username});
                          var result = await http.post(
                              g.baseUrl + "/delete_account.php",
                              body: bd);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          ut.showtoast(jsonDecode(result.body), Colors.red);
                          sp.setString('name', '');
                          sp.setString('username', '');
                          sp.setString('blood_group', '');
                          sp.setString('password', '');
                          sp.setString('location', '');
                          sp.setString("gender", '');
                          sp.setString("district", '');
                          sp.setString("age", '');
                          sp.setString("weight", '');
                          sp.setString("taluk", '');
                          sp.setString("contacts", '');
                          sp.setString("alt_contact", '');
                          sp.setString("email", '');
                          sp.setString("last_don", '');
                          sp.setString("status", '');
                          sp.setString("for_time", '');
                          setState(() {
                            g.g_n = '';
                            g.g_bg = '';
                            g.g_l = '';
                          });
                        },
                        child: Text(
                          'OK',
                          style:
                              TextStyle(fontSize: 15, color: Color(0xFFEE5623)),
                        )),
                    FlatButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Recheck Fields',
                          style:
                              TextStyle(fontSize: 15, color: Color(0xFFEE5623)),
                        ))
                  ],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  contentPadding: EdgeInsets.all(20),
                );
              });
        }

        // if every data is available post details
        else {
          postData(g.baseUrl, context);
        }
      }
    });
  }

  //to set username and password
  setPrefs1() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    Future<bool> u = sp.setString("username", un.text);
    Future<bool> v = sp.setString("name", fn.text);
    Future<bool> w = sp.setString("blood_group", sbg);
    sp.setString("gender", gen.toLowerCase());
    sp.setString("district", d);
    sp.setString("age", age.text);
    sp.setString("weight", weight.text);
    sp.setString("taluk", tl);
    sp.setString("contacts", cn.text);
    sp.setString("alt_contact", acn.text);
    sp.setString("email", mail.text);
    sp.setString("last_don",curr==null?'':curr);
    sp.setString("status", st);
    sp.setString("for_time", curr1==null?'':curr1);
    //print(u);
    // print(pa);
  }

  postData(String s, BuildContext context) async {
    setState(() {
      edited=true;
    });
    String g = gen.toLowerCase();
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String uname = sp.getString("username");
    var bd = json.encode({
      "name": fn.text,
      "gender": g,
      "age": age.text,
      "weight": weight.text,
      "bloodgroup": sbg,
      "district": d,
      "localty": tl,
      "contacts": cn.text,
      "alt_contact": acn.text,
      "email": mail.text,
      "last_don": curr==null?'':curr,
      "status": st,
      "for_time": curr1==null?'':curr1,
      "uname": uname,
    });
    var res = await http.post(s + "/edit_profile.php", body: bd);
    print(res.statusCode);
    reg = jsonDecode(res.body);
    setState(() {
      edited=false;
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
              style: TextStyle(fontSize: 30, color: Colors.purpleAccent),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40))),
            contentPadding: EdgeInsets.all(20),
          );
        });
    reg = '';
  }

  Widget callFor() {
    
    return DateTimeField(
      onChanged: (val){
        var c="${val.year}-${val.month}-${val.day}";
                                curr1=c;
                              },
        validator: (value) =>
            value!=null?(value.isBefore(DateTime.now()) ? 'Choose a valid date' : null):null,
        decoration: InputDecoration(
            prefixIcon: (Icon(Icons.date_range, color: Color(0xFFFB415B))),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            labelText: 'Stauts active upto $curr1',
            labelStyle: TextStyle(color: Colors.black, fontSize: 20)),
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              initialDate: currentValue??DateTime.now(),
              firstDate: DateTime(2019),
              lastDate: DateTime(2200));
        });
  }
}
