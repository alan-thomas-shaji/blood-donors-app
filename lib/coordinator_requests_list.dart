import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:koukicons/businessman.dart';
import 'package:koukicons/calendar.dart';
import 'package:koukicons/clocktime.dart';
import 'package:koukicons/openFolder.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'globals.dart' as g;
import 'package:flutter/material.dart';
import 'package:revive/Coordinator%20Request.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils.dart' as ut;
import 'package:http/http.dart' as http;

class RequestList extends StatefulWidget {
  @override
  _RequestListState createState() => _RequestListState();
}

class _RequestListState extends State<RequestList> {
  List lis = [];
  List lis1 = [];
  ScrollController _scroll1;
  int page = 1;
  bool p = false;
  bool empty = false;
  bool ind = false;

  getData() async {
    final SharedPreferences spp = await SharedPreferences.getInstance();
    String dis0 = spp.getString('district0');
    String dis1 = spp.getString('district1');
    if (lis.isNotEmpty)
      setState(() {
        ind = true;
      });
    final res = await http.post(Uri.parse(g.baseUrl + "/request_list.php"),
        body: jsonEncode({"dis0": dis0, "dis1": dis1, "pageno": page}));
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

  void initState() {
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
        home: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.orange[50],
            appBar: AppBar(
              title: Text('Request List'),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  lis.clear();
                  lis1.clear();
                  p = false;
                  page = 1;
                  empty = false;
                },
                icon: Icon(Icons.arrow_back_ios),
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
                              'No requests',
                              style: TextStyle(
                                  color: Colors.grey[300], fontSize: 30),
                            )
                          ],
                        ),
                      )
                    : ModalProgressHUD(
                        inAsyncCall: ind,
                        child: ListView.builder(
                            controller: _scroll1,
                            itemCount: lis?.length ?? 0,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                child: Container(
                                  padding: EdgeInsets.all(5.0),
                                  // height: 420,
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                      child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            CircleAvatar(
                                              child: KoukiconsBusinessman(),
                                              radius: 30,
                                            ),
                                            SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                    lis[index]['name']
                                                        .toString()
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 25)),
                                                Text(
                                                    "Posted on :" +
                                                        lis[index][
                                                                'requested_time']
                                                            .substring(0, 10) +
                                                        "," +
                                                        lis[index][
                                                                'requested_time']
                                                            .substring(11, 16),
                                                    style: TextStyle(
                                                        color: Colors.orange))
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Divider(),
                                        SizedBox(height: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Patient name: " +
                                                  lis[index]['patient_name']
                                                      .toString()
                                                      .toUpperCase(),
                                              style: TextStyle(
                                                  color: Colors.blue[900],
                                                  fontSize: 20),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Patient case: " +
                                                  lis[index]['patient_case'],
                                              style: TextStyle(
                                                  color: Colors.blue[900],
                                                  fontSize: 20),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                KoukiconsCalendar(),
                                                Text(
                                                  "Date : " +
                                                      lis[index]['date']
                                                          .substring(0, 10),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: <Widget>[
                                                KoukiconsClocktime(
                                                  height: 43,
                                                ),
                                                Text(
                                                  "Time : " +
                                                      lis[index]['date']
                                                          .substring(11, 16),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Text(
                                          'Hospital : ' +
                                              lis[index]['hospital'] +
                                              ", " +
                                              lis[index]['taluk'],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 19),
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 3, horizontal: 10),
                                              margin: EdgeInsets.all(0),
                                              decoration: ut.rounded(
                                                  Colors.red, false, 40),
                                              child: Text(
                                                'Required units :' +
                                                    lis[index]['bloodqty'],
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
                                              decoration: ut.rounded(
                                                  Colors.red, false, 40),
                                              child: Text(
                                                lis[index]['bloodgroup'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(
                                              Icons.location_on,
                                              color: Colors.blue,
                                            ),
                                            Text(
                                              lis[index]['taluk'] +
                                                  "," +
                                                  lis[index]['district'],
                                              style: TextStyle(
                                                  color: Colors.blue[900],
                                                  fontSize: 16),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                                ),
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BloodRequestDetails(
                                            name: lis[index]['name'],
                                            age: lis[index]['age'],
                                            date: lis[index]['date'],
                                            district: lis[index]['district'],
                                            taluk: lis[index]['taluk'],
                                            hospital: lis[index]['hospital'],
                                            group: lis[index]['bloodgroup'],
                                            number: lis[index]
                                                ['bystander_contacts'],
                                            altNumber: lis[index]
                                                ['bystander_alt_contacts'],
                                            units: lis[index]['bloodqty'],
                                            requested_time: lis[index]
                                                ['requested_time'],
                                            pat_name: lis[index]
                                                ['patient_name'],
                                            pat_case: lis[index]
                                                ['patient_case'],
                                          )),
                                ).then((var value) {
                                  setState(() {
                                    if (g.del == true) lis.removeAt(index);
                                    g.del = false;
                                  });
                                }),
                              );
                            }),
                      ),
          ),
        ));
  }
}
