import 'package:flutter/material.dart';
import 'package:revive/edit_coordinator_profile.dart';
import 'globals.dart' as g;
import 'package:shared_preferences/shared_preferences.dart';
import 'utils.dart' as ut;

class CoordinatorProfile extends StatefulWidget {
  CoordinatorProfile({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CoordinatorProfileState createState() => _CoordinatorProfileState();
}

class _CoordinatorProfileState extends State<CoordinatorProfile> {
  Map f = {};
  @override
  void initState() {
    postValues();
    super.initState();
  }

  String uname = '', pass = '';
  var r;
  String n = '',
      pr = '',
      d = '',
      l = '',
      c = '',
      re = '',
      ex = '',
      e = '',
      un = '',dis0='',dis1='';
  //function to post userid and password and accepts full details
  postValues() async {
    final SharedPreferences spp = await SharedPreferences.getInstance();
    uname = spp.getString('username');
    pass = spp.getString('password');

    //stores the details to string variables

    setState(() {
      n = spp.getString('name');
      d = spp.getString('district');
      l = spp.getString('location');
      c = spp.getString('phone');
      e = spp.getString('email');
      re = spp.getString('verified_requests');
      ex = spp.getString('experience');
      pr = spp.getString('profession');
      dis0=spp.getString('district0');
      dis1=spp.getString('district1');
      un = uname;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ut.maintheme(),
      home: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditCoordinatorProfile(
                        name: n,
                        contacts: c,
                        profession: pr,
                        location: l,
                        email: e,
                        vdr: re,
                        exp: ex,
                        username: uname,
                        district: d,
                      )),
            ).then((var value) {
              postValues();
            }),
            child: Icon(Icons.edit),
            backgroundColor: Colors.deepOrange,
          ),
          appBar: AppBar(
            title: Text('Coordinator Profile'),
            leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          ),
          body: ListView(
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
                      n.toUpperCase(),
                      style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      pr,
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                    )
                  ],
                ),
              ),

              Container(
                // height: 50,
                child: Row(
                  children: <Widget>[
                    //Experience details
                    Expanded(
                      child: Container(
                        color: Colors.deepOrange.shade400,
                        child: ListTile(
                          title: Text(
                            "$ex years",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0),
                          ),
                          subtitle: Text(
                            "of trusted service",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ),
                    //Details of donors' verified
                    Expanded(
                      child: Container(
                        color: Colors.red,
                        child: ListTile(
                          title: Text(
                            re,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0),
                          ),
                          subtitle: Text(
                            "verified donor requests",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //Other details
              ListTile(
                title: Text(
                  "Coordinator ID",
                  style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),
                ),
                subtitle: Text(
                  un,
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
                  "In charge of Districts",
                  style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),
                ),
                subtitle: Text(
                  dis0+","+dis1,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              Divider(),
            ],
          )),
    );
  }
}
