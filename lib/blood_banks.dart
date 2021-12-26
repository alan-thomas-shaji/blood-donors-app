import 'dart:async';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:koukicons/callback.dart';
import 'package:koukicons/like.dart';
import 'package:koukicons/news.dart';
import 'package:mongo_dart/mongo_dart.dart' as mon;
import 'utils.dart' as ut;
import 'globals.dart' as g;

class BloodBanks extends StatefulWidget {
  @override
  _BloodBanksState createState() => _BloodBanksState();
}

class _BloodBanksState extends State<BloodBanks> {
  List<Map<String, dynamic>> banks = [];
  bool isloading = true;
  Map<String, dynamic> edit = {};
  int index = 0;
  TextEditingController nameedit = new TextEditingController();
  TextEditingController locationedit = new TextEditingController();
  TextEditingController contactedit = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController location = new TextEditingController();
  TextEditingController contact = new TextEditingController();
  mon.Db db;
  initmon() async {
    db = new mon.Db(g.mongo_url);
    await db.open().then((val) {
      print("$val");
    });
    load();
  }

  void addtolist(Map a) {
    setState(() {
      banks.add(a);
    });
  }

  load() async {
    banks.clear();
    var gallery = db.collection("bloodbanks");
    await gallery.find().forEach(addtolist).then((onValue) {
      print(onValue);
      setState(() {
        index = 1;
        isloading = false;
      });
    });
  }

  FutureOr<bool> myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    if (index == 2 || index == 3) {
      setState(() {
        index = 1;
      });
    } else {
      //Navigator.pop(context);
      return Future<bool>.value(false);
    }

    return Future<bool>.value(true);
  }

  asyncFunc(BuildContext) async {
    await initmon();
  }

  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    WidgetsBinding.instance.addPostFrameCallback((_) => start(context));
  }

  void start(BuildContext) {
    asyncFunc(BuildContext);
  }

  deleteimage() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Are you sure you want to delete"),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    var gallery = db.collection("bloodbanks");
                    gallery.remove({"_id": edit['_id']}).then((onValue) {
                      print(onValue);
                      setState(() {
                        ut.showtoast(" Deleted succesfully", Colors.teal);
                        this.index = 0;
                      });
                      load();
                    });
                    Navigator.pop(context);
                  },
                  child: new Text("ok"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ut.maintheme(),
      home: Scaffold(
          backgroundColor: Colors.orange[50],
          appBar: AppBar(
            title: Text("Blood Banks in Kerala"),
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  if (index == 2 || index == 3) {
                    setState(() {
                      index = 1;
                    });
                  } else {
                    Navigator.pop(context);
                  }
                }),
            actions: <Widget>[
              g.g_l.isEmpty
                  ? SizedBox(height: 1)
                  : index == 3
                      ? IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          color: Colors.white,
                          onPressed: () {
                            deleteimage();
                          })
                      : IconButton(
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              index = 2;
                            });
                          })
            ],
          ),
          body: IndexedStack(
            index: index,
            children: <Widget>[
              ut.loader(),
              listofbanks(),
              formforadd(this),
              editbanks()
            ],
          )),
    );
  }

  void _update() async {
    if (nameedit.text == "" ||
        locationedit.text == "" ||
        contactedit.text == "") {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Fields Cannot be empty"),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: new Text("ok"))
              ],
            );
          });
    } else {
      setState(() {
        this.index = 0;
      });

      //_image = testCompressAndGetFile(_image, targetPath)

      var gallery = db.collection("bloodbanks");
      await gallery.findAndModify(query: {
        "_id": edit['_id']
      }, update: {
        "name": nameedit.text,
        "location": locationedit.text,
        "contact": contactedit.text
      }).then((onValue) {
        ut.showtoast(" Updated succesfully", Colors.teal);
        // images.clear();
        setState(() {
          edit.clear();
          nameedit.clear();
          locationedit.clear();
          contactedit.clear();
        });
        load();
      });
    }
  }

  void _upload() async {
    if (name.text == "" || location.text == "" || contact.text == "") {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Fields Cannot be empty"),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: new Text("ok"))
              ],
            );
          });
    } else {
      setState(() {
        index = 0;
      });

      //_image = testCompressAndGetFile(_image, targetPath)

      var gallery = db.collection("bloodbanks");
      await gallery.insert({
        "name": name.text,
        "location": location.text,
        "contact": contact.text
      }).then((onValue) {
        ut.showtoast(" Inserted succesfully", Colors.teal);
        // images.clear();
        setState(() {
          name.clear();
          location.clear();
          contact.clear();
        });
        load();
      });
    }
  }

  Widget editbanks() {
    return Center(
      child: Container(
          color: Colors.orange[50],
          padding: const EdgeInsets.only(top: 10.0, bottom: 20),
          child: Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                TextField(
                  autofocus: false,
                  controller: nameedit,
                  decoration: InputDecoration(labelText: "Name"),
                ),
                TextField(
                  autofocus: false,
                  controller: locationedit,
                  decoration: InputDecoration(labelText: "Location"),
                ),
                TextField(
                  autofocus: false,
                  controller: contactedit,
                  decoration: InputDecoration(labelText: "Contact"),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ButtonStyle(
                      // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 45),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      )),

                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    _update();
                  },
                  child: Text(
                    "Update ",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ]),
            ),
          )),
    );
  }

  Widget formforadd(State m) {
    return Center(
      child: Container(
          color: Colors.orange[50],
          padding: const EdgeInsets.only(top: 10.0, bottom: 20),
          child: Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                TextField(
                  autofocus: false,
                  controller: name,
                  decoration: InputDecoration(labelText: "Name"),
                ),
                TextField(
                  autofocus: false,
                  controller: location,
                  decoration: InputDecoration(labelText: "Location"),
                ),
                TextField(
                  autofocus: false,
                  controller: contact,
                  decoration: InputDecoration(labelText: "Contact"),
                ),
                SizedBox(height: 10),
                RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 45),
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    _upload();
                  },
                  child: Text(
                    "Add ",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ]),
            ),
          )),
    );
  }

  void handletap() {
    setState(() {
      this.index = 3;
    });
  }

  Widget listofbanks() {
    return Container(
      color: Colors.orange[50],
      padding: const EdgeInsets.only(top: 10.0, bottom: 20),
      child: ListView.builder(
          itemCount: banks.length,
          itemBuilder: (context, index) {
            return Container(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19)),
                margin: EdgeInsets.all(10),
                elevation: 5,
                child: InkWell(
                  onTap: () {
                    if (g.g_l.isNotEmpty) {
                      setState(() {
                        nameedit.text = banks[index]["name"];
                        locationedit.text = banks[index]["location"];
                        contactedit.text = banks[index]["contact"];
                        edit = (banks[index]);
                        handletap();
                        //print("hai");
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Row(
                        children: <Widget>[
                          KoukiconsNews(),
                          Text(
                            "  " + banks[index]['name'].toString(),
                            style: GoogleFonts.fugazOne(),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "  " + banks[index]['location'].toString(),
                                style: GoogleFonts.fugazOne(),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(children: [
                        KoukiconsCallback(
                          color: Colors.red,
                          height: 37,
                        ),
                        Text(
                          "  " + banks[index]['contact'].toString(),
                          style: GoogleFonts.fugazOne(),
                        )
                      ])
                    ]),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
