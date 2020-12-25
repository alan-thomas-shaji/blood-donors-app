import 'package:flutter/material.dart';
import 'package:revive/edit_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'globals.dart';
import 'utils.dart' as ut;
import 'globals.dart' as g;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String uname = '', pass = '';
  var r;
  String n = '',
      f = '',
      g = '',
      a = '',
      w = '',
      b = '',
      d = '',
      l = '',
      c = '',
      ac = '',
      e = '',
      ld = '',
      s = '',
      at = '',
      un = '';
  //function which takes the username and password of the current user logged in and posts it to fetch the details
  postValues() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    uname = sp.getString('username');
    pass = sp.getString('password');

    setState(() {
      f = sp.getString('name');
      n = f[0];
      a = sp.getString('age');
      g = sp.getString('gender');
      w = sp.getString('weight');
      b = sp.getString('blood_group');
      d = sp.getString('district');
      l = sp.getString('taluk');
      c = sp.getString('contacts');
      ac = sp.getString('alt_contact');
      e = sp.getString('email');
      ld = sp.getString('last_don');
      ld=ld==null?'':ld;
      s = sp.getString('status');
      at = sp.getString('for_time');
      at=at==null?'':at.isEmpty?'':at;
      un = uname;
    });
  }

  @override
  void initState() {
    super.initState();
    //when app starts this is called
    postValues();
  }

  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      theme: ut.maintheme(),
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Profile'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfile(
                              name: f,
                              age: a,
                              gender: g,
                              weight: w,
                              group: b,
                              district: d,
                              location: l,
                              contacts: c,
                              alt_contacts: ac,
                              email: e,
                              last_don: ld,
                              status: s,
                              for_time: at,
                              username: un)),
                    ).then((var value) {
                      setState(() {
                        postValues();
                      });
                    }),
                  )
                ],
              )
            ],
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body:  ListView(
            children: <Widget>[
              //background settings for profile pic
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/blood_doodle.jpg"),
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.2), BlendMode.dstATop),
                  ),
                  color: Colors.deepOrange.shade300,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        //profile picture
                        CircleAvatar(
                          minRadius: 60,
                          backgroundColor: Colors.deepOrange.shade300,
                          child: CircleAvatar(
                            backgroundImage:
                                new AssetImage("assets/images/profile.jpg"),
                            minRadius: 50,
                          ),
                        ),
                      ],
                    ),
                    //Name and profession details
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      f.toUpperCase(),
                      style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      b,
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                    )
                  ],
                ),
              ),


              //Other details
              ListTile(
                title: Text(
                  "User Name",
                  style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),
                ),
                subtitle: Text(
                  uname,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  "Phone",
                  style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),
                ),
                subtitle: Text(
                  c,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  "Email",
                  style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),
                ),
                subtitle: Text(
                  e,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  "Taluk",
                  style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),
                ),
                subtitle: Text(
                  l,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  "District",
                  style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),
                ),
                subtitle: Text(
                  d,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              ListTile(
                title: Text(
                  "Age",
                  style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),
                ),
                subtitle: Text(
                  a,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  "Last Donated",
                  style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),
                ),
                subtitle: Text(
                  ld,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              Divider(),
              
              ListTile(
                title: Text(
                  "Weight",
                  style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),
                ),
                subtitle: Text(
                  w,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              Divider(),
              
              ListTile(
                title: Text(
                  "Status",
                  style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),
                ),
                subtitle: Text(
                  s,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              Divider(),
             s == "Available anytime"?Text(''):
              
              ListTile(
                title: Text(
                  "Available time",
                  style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),
                ),
                subtitle: Text(
                  at,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              Divider(),
            ],
          ),
      ),
    );
  }
 
}
