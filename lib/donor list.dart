import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:koukicons/openFolder.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'utils.dart' as ut;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'globals.dart' as g;
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:koukicons/report.dart';
import 'package:koukicons/share2.dart';
import 'package:koukicons/comments.dart';
import 'package:koukicons/callback.dart';
import 'package:koukicons/businessman.dart';

class DonorList extends StatefulWidget {
  final String dis, tal, bg;
  DonorList({Key key, this.dis, this.tal, this.bg}) : super(key: key);
  @override
  _DonorListState createState() => _DonorListState(this.dis, this.tal, this.bg);
}

class _DonorListState extends State<DonorList> {
  int _grp;
  List lis = [];
  List lis1 = [];
  ScrollController _scroll1;
  int page = 1;
  bool p = false;
  bool empty = false;
  bool ind = false;
  String dis, tal, bg, _txt = '';
  _DonorListState(String d, String t, String b) {
    this.dis = d;
    this.tal = t;
    this.bg = b;
  }
  Widget w = SizedBox(
    width: 1,
  );
  TextEditingController un = TextEditingController();

  getData() async {
    if (lis.isNotEmpty)
      setState(() {
        ind = true;
      });
    var bd = jsonEncode({"district": dis, "taluk": tal, "group": bg,"pageno":page});
    final res = await http.post(
        
        g.baseUrl + "/donor_list1.php",
        body: bd);
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

  @override
  void initState() {
    _grp = 0;
    super.initState();
    _scroll1 = new ScrollController();
    getData();
    _scroll1.addListener(() {
      if (_scroll1.position.pixels == _scroll1.position.maxScrollExtent) {
        setState(() {
          if (p == false) {
            page = page + 1;
            getData();
          }
        });
      }
    });
  }
 @override
  void dispose() {
    _scroll1.dispose();
    super.dispose();
  } 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ut.maintheme(),
      home: Scaffold(
        backgroundColor: Colors.orange[50],
        appBar: AppBar(
          title: Text('Donors List'),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 30,
            ),
            onPressed: (){ Navigator.pop(context);lis.clear();
                  lis1.clear();
                  p = false;
                  page = 1;
                  empty = false;}
          ),
        ),
        body: lis.isEmpty && empty == false
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
                              'No records',
                              style: TextStyle(
                                  color: Colors.grey[300], fontSize: 30),
                            )
                          ],
                        ),
                      )
                    :ModalProgressHUD(
                      inAsyncCall: ind,
                                          child: ListView.builder(
                        controller: _scroll1,
                      itemCount: lis?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Container(
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
                                    Text(
                                        lis[index]['name']
                                            .toString()
                                            .toUpperCase(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25)),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Last Donated on: " +
                                            lis[index]['last_don'],
                                        style: TextStyle(
                                            color: Colors.blue[900],
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      lis[index]['status'] == 'Unavailable for'
                                          ? Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 3, horizontal: 10),
                                              margin: EdgeInsets.all(0),
                                              decoration: ut.rounded(
                                                  Colors.red, false, 40),
                                              child: Text(
                                                lis[index]['status'] +
                                                    " upto " +
                                                    lis[index]['for_time'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold),
                                              ))
                                          : Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 3, horizontal: 10),
                                              margin: EdgeInsets.all(0),
                                              decoration: ut.rounded(
                                                  Colors.green, false, 40),
                                              child: lis[index]['status'] ==
                                                      'Available anytime'
                                                  ? Text(
                                                      lis[index]['status'],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  : Text(
                                                      lis[index]['status'] +
                                                          " upto " +
                                                          lis[index]['for_time'],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                            ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 10),
                                        margin: EdgeInsets.all(0),
                                        decoration:
                                            ut.rounded(Colors.red, false, 40),
                                        child: Text(
                                          lis[index]['bloodgroup'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        lis[index]['localty'] +
                                            "," +
                                            lis[index]['district'],
                                        style: TextStyle(
                                            color: Colors.blue[900],
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.grey[100],
                                          child: IconButton(
                                              icon: KoukiconsCallback(),
                                              onPressed: () {
                                                launch("tel://" +
                                                    lis[index]['contacts']);
                                              })),
                                      CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.grey[100],
                                          child: IconButton(
                                              icon: KoukiconsComments(),
                                              onPressed: () {
                                                launch("sms:" +
                                                    lis[index]['contacts']);
                                              })),
                                      CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.grey[100],
                                          child: IconButton(
                                              icon: KoukiconsShare2(),
                                              onPressed: () {
                                                Share.share("Name:" +
                                                    lis[index]['name'] +
                                                    "\nContacts:" +
                                                    lis[index]['contacts'] +
                                                    "\nLocation:" +
                                                    lis[index]['localty'] +
                                                    "," +
                                                    lis[index]['district']);
                                              })),
                                      CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.grey[100],
                                          child: IconButton(
                                              icon: KoukiconsReport(),
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (context) => AlertDialog(
                                                              actions: <Widget>[
                                                                FlatButton(
                                                                    onPressed:
                                                                        () {
                                                                      _txt = _grp ==
                                                                              4
                                                                          ? un.text
                                                                          : _txt;
                                                                      print(_txt);
                                                                      launch('mailto:tomercondeveloper@gmail.com?subject=' +
                                                                          _txt +
                                                                          '&body=' +
                                                                          lis[index]
                                                                              [
                                                                              'name'] +
                                                                          ' is reported with the issue of ' +
                                                                          _txt);
                                                                    },
                                                                    child: Text(
                                                                        'Report'))
                                                              ],
                                                              content: StatefulBuilder(
                                                                  builder: (BuildContext
                                                                          context,
                                                                      setState) {
                                                                return Container(
                                                                  height: 500,
                                                                  width: double
                                                                      .maxFinite,
                                                                  child: ListView(
                                                                    children: <
                                                                        Widget>[
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                                .all(
                                                                            10.0),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            lis[index]
                                                                                [
                                                                                'name'],
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 20),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      RadioListTile(
                                                                          title: Text(
                                                                              "Wrong number"),
                                                                          value:
                                                                              0,
                                                                          groupValue:
                                                                              _grp,
                                                                          onChanged:
                                                                              (val) {
                                                                            setState(
                                                                                () {
                                                                              _txt =
                                                                                  "Wrong number";
                                                                              _grp =
                                                                                  val;
                                                                              print(val);
                                                                            });
                                                                          }),
                                                                      Divider(),
                                                                      RadioListTile(
                                                                          title: Text(
                                                                              "Denied Request"),
                                                                          value:
                                                                              1,
                                                                          groupValue:
                                                                              _grp,
                                                                          onChanged:
                                                                              (val) {
                                                                            setState(
                                                                                () {
                                                                              _txt =
                                                                                  "Denied Request";
                                                                              _grp =
                                                                                  val;
                                                                              print(val);
                                                                            });
                                                                          }),
                                                                      Divider(),
                                                                      RadioListTile(
                                                                          title: Text(
                                                                              "Someone else is using"),
                                                                          value:
                                                                              2,
                                                                          groupValue:
                                                                              _grp,
                                                                          onChanged:
                                                                              (val) {
                                                                            setState(
                                                                                () {
                                                                              _txt =
                                                                                  "Someone else is using";
                                                                              _grp =
                                                                                  val;
                                                                              print(val);
                                                                            });
                                                                          }),
                                                                      Divider(),
                                                                      RadioListTile(
                                                                          title: Text(
                                                                              "Asked for money"),
                                                                          value:
                                                                              3,
                                                                          groupValue:
                                                                              _grp,
                                                                          onChanged:
                                                                              (val) {
                                                                            setState(
                                                                                () {
                                                                              _txt =
                                                                                  "Asked for money";
                                                                              _grp =
                                                                                  val;
                                                                              print(val);
                                                                            });
                                                                          }),
                                                                      Divider(),
                                                                      RadioListTile(
                                                                          title: Text(
                                                                              "Others"),
                                                                          value:
                                                                              4,
                                                                          groupValue:
                                                                              _grp,
                                                                          onChanged:
                                                                              (val) {
                                                                            setState(
                                                                                () {
                                                                              _grp =
                                                                                  val;
                                                                              w = TextFormField(
                                                                                validator: (value) {
                                                                                  if (value.isEmpty) {
                                                                                    return 'Field required';
                                                                                  } else {
                                                                                    return null;
                                                                                  }
                                                                                },
                                                                                controller: un,
                                                                                style: TextStyle(fontSize: 20),
                                                                                decoration: InputDecoration(
                                                                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                                                                ),
                                                                              );
                                                                              _txt =
                                                                                  un.text;
                                                                            });
                                                                          }),
                                                                      _grp == 4
                                                                          ? w
                                                                          : SizedBox(
                                                                              width:
                                                                                  2)
                                                                    ],
                                                                  ),
                                                                );
                                                              }),
                                                            ));
                                              })),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                        );
                      }),
                    ),
            
      ),
    );
  }
}
