import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:koukicons/businessman.dart';
import 'package:koukicons/calendar.dart';
import 'package:koukicons/callback.dart';
import 'package:koukicons/clocktime.dart';
import 'package:koukicons/openFolder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils.dart' as ut;
import 'package:http/http.dart' as http;
import 'globals.dart' as g;
import 'package:url_launcher/url_launcher.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

Widget j;
List lis = [];
List lis1 = [];
List categ = ['Emergency', 'All'];
int index = 0;
String sbg, ch;
var dis, dis1, dis2;
int page = 1;
bool p = false;
bool empty = false;
bool ind = false;
ScrollController _scroll;

//Emergency newsfeed
class EmergencyGroupBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:0.0),
      child: Container(
        
      padding: const EdgeInsets.only(bottom:145.0),
          margin: EdgeInsets.symmetric(vertical: 10.0),
          height: MediaQuery.of(context).size.height,
          child: lis.isEmpty && empty == false
              ? SpinKitHourGlass(
                  color: Colors.red,
                  size: 80,
                )
              : lis.isEmpty && empty == true
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          KoukiconsOpenFolder(
                            height: 80,
                            color: Colors.grey[300],
                          ),
                          Text(
                            'No requests',
                            style: TextStyle(
                                color: Colors.grey[300], fontSize: 30),
                          )
                        ],
                      ),
                    )
                  : ListView.builder(
                      controller: _scroll,
                      itemCount: lis?.length ?? 0,
                      itemBuilder: (context, index) {
                        Widget w = SizedBox(width: 1);

                        if (lis[index]['status'] == 'Emergency') {
                          if (g.g_bg.isNotEmpty) {
                            if (lis[index]['district'] == dis) {
                              w = RequestCard(
                                i: index,
                              );
                            }
                          } else if (g.g_l.isNotEmpty &&
                              dis1 != null &&
                              dis2 != null) {
                            if (lis[index]['district'] == dis1 ||
                                lis[index]['district'] == dis2) {
                              w = RequestCard(
                                i: index,
                              );
                            }
                          } else {
                            w = RequestCard(
                              i: index,
                            );
                          }
                        }

                        return w;
                      })),
    );
  }
}

//Other requirements newsfeed
class GroupBox extends StatelessWidget {
  final String group;

  GroupBox({@required this.group});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom:135.0),
          margin: EdgeInsets.only(bottom:0),
          height: MediaQuery.of(context).size.height,
          child: lis.isEmpty && empty == false
              ? SpinKitHourGlass(
                  color: Colors.red,
                  size: 80,
                )
              : lis.isEmpty && empty == true
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          KoukiconsOpenFolder(
                            height: 80,
                            color: Colors.grey[300],
                          ),
                          Text(
                            'No requests',
                            style: TextStyle(
                                color: Colors.grey[300], fontSize: 30),
                          )
                        ],
                      ),
                    )
                  : ListView.builder(
                      controller: _scroll,
                      itemCount: lis?.length ?? 0,
                      itemBuilder: (context, index) {
                        Widget w = SizedBox(width: 1);
                        if (lis[index]['bloodgroup'] == this.group) {
                          if (g.g_bg.isNotEmpty && dis != null) {
                            if (lis[index]['district'] == dis &&
                                empty == false) {
                              w = RequestCard(
                                i: index,
                              );
                            }
                          } else if (g.g_l.isNotEmpty &&
                              dis1 != null &&
                              dis2 != null) {
                            if (lis[index]['district'] == dis1 ||
                                lis[index]['district'] == dis2) {
                              w = RequestCard(
                                i: index,
                              );
                            }
                          } else {
                            w = RequestCard(
                              i: index,
                            );
                          }
                        }

                        return w;
                      }),
    );
  }
}

class RequestCard extends StatelessWidget {
  final int i;

  RequestCard({
    @required this.i,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(5.0),
      // height: 420,
      width: MediaQuery.of(context).size.width,
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  child: KoukiconsBusinessman(),
                  radius: 30,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(lis[i]['name'].toString().toUpperCase(),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25)),
                    Text(
                        "Posted on :" +
                            lis[i]['requested_time'].substring(0, 10) +
                            "," +
                            lis[i]['requested_time'].substring(11, 16),
                        style: TextStyle(color: Colors.orange))
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Text(
                  'Approved by ' + lis[i]['coor_id'],
                  style: TextStyle(color: Colors.blue[900], fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Patient name: " +
                      lis[i]['patient_name'].toString().toUpperCase(),
                  style: TextStyle(color: Colors.blue[900], fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Patient case: " + lis[i]['patient_case'],
                  style: TextStyle(color: Colors.blue[900], fontSize: 20),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    KoukiconsCalendar(
                      height: 50,
                    ),
                    Text(
                      "Date : " + lis[i]['date'].substring(0, 10),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    KoukiconsClocktime(height: 45),
                    Text(
                      "Time : " + lis[i]['date'].substring(11, 16),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            Text(
              'Hospital : ' + lis[i]['hospital'] + ", " + lis[i]['taluk'],
              style: TextStyle(color: Colors.black, fontSize: 19),
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  margin: EdgeInsets.all(0),
                  decoration: ut.rounded(Colors.red, false, 40),
                  child: Text(
                    'Required units :' + lis[i]['bloodqty'],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  margin: EdgeInsets.all(0),
                  decoration: ut.rounded(Colors.red, false, 40),
                  child: Text(
                    lis[i]['bloodgroup'],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  color: Colors.blue,
                ),
                Text(
                  lis[i]['taluk'] + "," + lis[i]['district'],
                  style: TextStyle(color: Colors.blue[900], fontSize: 16),
                ),
                Expanded(child: SizedBox()),
                CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[100],
                    child: IconButton(
                        icon: KoukiconsCallback(
                          color: Colors.green,
                        ),
                        onPressed: () {
                          launch("tel://" + lis[i]['bystander_contacts']);
                        })),
              ],
            ),
          ],
        ),
      )),
    );
  }
}

class NewsFeed extends StatefulWidget {
  NewsFeed({Key key, this.emergency, this.group}) : super(key: key);

  final bool emergency;
  String group;

  @override
  _NewsFeedState createState() => _NewsFeedState(emergency, group);
}

class _NewsFeedState extends State<NewsFeed> {
  bool emergency; //TO FILTER EMERGENCY ONLY
  String group;
  Timer _countdownTimer;
  // TO FILTER BLOOD GROUP
  _NewsFeedState(bool a, String b) {
    emergency = a;
    group = b;
    sbg = group;
    if (emergency == true) sbg = null;
    if (emergency == false) ch = categ[1];
    emergency == true ? getData1() : getData2();
  }

  @override
  void initState() {
    _scroll = new ScrollController();
    super.initState();
    _scroll.addListener(() {
      if (_scroll.position.pixels == _scroll.position.maxScrollExtent) {
        setState(() {
          if (p == false) {
            page = page + 1;
            emergency == true ? getData1() : getData2();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ut.maintheme(),
      home: Scaffold(
          backgroundColor: Colors.orange[50],
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  lis.clear();
                  lis1.clear();
                  p = false;
                  page = 1;
                  empty = false;
                  Navigator.pop(context);
                }),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("Newsfeed"),
                Expanded(child: SizedBox()),
              ],
            ),
          ),
          body: ModalProgressHUD(
            dismissible: true,
            inAsyncCall: ind,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  title: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        emergency == false
                            ? DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton<String>(
                                    hint: Text(
                                      'Choose',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),

                                    isDense: true,
                                    //hint: ut.roundedtext(
                                    //     'Choose', Colors.white, Colors.red),
                                    isExpanded: false,
                                    items: g.bloodgroup.map((lisVal) {
                                      return DropdownMenuItem<String>(
                                          value: lisVal,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 4),
                                            margin: EdgeInsets.all(0),
                                            decoration: ut.rounded(
                                                Colors.white, false, 40),
                                            child: Text(
                                              lisVal,
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14),
                                            ),
                                          ));
                                    }).toList(),
                                    onChanged: (String val) {
                                      setState(() {
                                        sbg = val;
                                        lis.clear();
                                        lis1.clear();
                                        p = false;
                                        page = 1;
                                        empty = false;
                                        getData2();
                                      });
                                    },
                                    value: sbg,
                                  ),
                                ),
                              )
                            : SizedBox(width: 1),

                        //ut.roundedtext("$group", Colors.white, Colors.red),
                        SizedBox(
                          width: 2,
                        ),
                        DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              isDense: true,
                              isExpanded: false,
                              items: categ.map((lisVal) {
                                return DropdownMenuItem<String>(
                                    value: lisVal,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 3, horizontal: 4),
                                      margin: EdgeInsets.all(0),
                                      decoration:
                                          ut.rounded(Colors.white, false, 40),
                                      child: Text(
                                        lisVal,
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 14),
                                      ),
                                    ));
                              }).toList(),
                              onChanged: (String val) {
                                setState(() {
                                  ch = val;
                                  emergency = ch == categ[0] ? true : false;
                                  sbg = ch == categ[0] ? null : sbg;
                                  if (ch == categ[0]) {
                                    setState(() {
                                      lis.clear();
                                      lis1.clear();
                                      p = false;
                                      page = 1;
                                      empty = false;
                                      getData1();
                                    });
                                  }
                                  if (ch == categ[1]) {
                                    setState(() {
                                      lis.clear();
                                      lis1.clear();
                                      p = false;
                                      page = 1;
                                      empty = false;
                                      getData2();
                                    });
                                  }
                                });
                              },
                              value: ch,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  backgroundColor: Colors.orange[50],
                  floating: false,
                  pinned: true,
                  expandedHeight: 40,
                  actions: <Widget>[],
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      child: emergency == true
                          ? EmergencyGroupBox()
                          : GroupBox(
                              group: sbg,
                            ),
                    ),
                  ]),
                )
              ],
            ),
          )),
    );
  }

  getData1() async {
    print(sbg);
    print('page is $page');
    final SharedPreferences sp = await SharedPreferences.getInstance();
    dis = g.g_bg.isNotEmpty ? sp.getString('district') : null;
    dis1 = g.g_l.isNotEmpty ? sp.getString('district0') : null;
    dis2 = g.g_l.isNotEmpty ? sp.getString('district1') : null;
    if (lis.isNotEmpty)
      setState(() {
        ind = true;
      });
    final res = await http.post(g.baseUrl + "/newsfeed.php",
        body: jsonEncode({
          "pageno": page,
          "dis": dis,
          "dis0": dis1,
          "dis1": dis2,
          "group": sbg
        }));
    print(res.statusCode);
    setState(() {
      if (lis.isNotEmpty) ind = false;
      lis1 = jsonDecode(res.body);
      print(lis1.length);
      if (lis1.length == 0 && page == 1) empty = true;
      if (lis1.length == 0) p = true;
      if (lis1.length != 0) {
        lis1.forEach((f) {
          lis.add(f);
        });
      }
      print(lis);
    });
  }

  getData2() async {
    print('page is $page');
    print(sbg);
    final SharedPreferences sp = await SharedPreferences.getInstance();
    dis = g.g_bg.isNotEmpty ? sp.getString('district') : null;
    dis1 = g.g_l.isNotEmpty ? sp.getString('district0') : null;
    dis2 = g.g_l.isNotEmpty ? sp.getString('district1') : null;
    if (lis.isNotEmpty)
      setState(() {
        ind = true;
      });
    final res = await http.post(g.baseUrl + "/newsfeed.php",
        body: jsonEncode({
          "pageno": page,
          "group": sbg,
          "dis": dis,
          "dis0": dis1,
          "dis1": dis2
        }));
    print(res.statusCode);
    setState(() {
      if (lis.isNotEmpty) ind = false;
      lis1 = jsonDecode(res.body);
      print(lis1.length);
      if (lis1.length == 0 && page == 1) empty = true;
      print('empty is $empty');
      if (lis1.length == 0) p = true;
      if (lis1.length != 0) {
        lis1.forEach((f) {
          lis.add(f);
        });
        print(lis);
      }
    });
  }
}
