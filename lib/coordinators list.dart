import 'dart:ui';
import 'package:koukicons/openFolder.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:koukicons/businessman.dart';
import 'package:koukicons/callback.dart';
import 'package:revive/coord_details.dart';
import 'package:revive/coordinator_profile.dart';
import 'utils.dart' as ut;
import 'package:http/http.dart' as http;
import 'globals.dart' as g;
import 'dart:convert';

class CoordinatorsList extends StatefulWidget {
  @override
  _CoordinatorsListState createState() => _CoordinatorsListState();
}

class _CoordinatorsListState extends State<CoordinatorsList> {
  List lis = [];
  List lis1 = [];
  ScrollController _scroll1;
  int page = 1;
  bool p = false;
  bool empty = false;
  bool ind = false;
  getData() async {
    if (lis.isNotEmpty)
      setState(() {
        ind = true;
      });
    final res = await http.post(g.baseUrl + "/coordinator_list.php",body:jsonEncode({"pageno":page}));
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
    _scroll1= new ScrollController();
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
          title: Text('Coordinators'),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {Navigator.pop(context);lis.clear();
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
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CoordinatorDetails(
                                      name: lis[index]['name'],
                                      phone: lis[index]['phone'],
                                      mail: lis[index]['email'],
                                      taluk: lis[index]['localty'],
                                      district: lis[index]['district'],
                                      ve_re: lis[index]['verified_requests'],
                                      experience: lis[index]['experience'],
                                      profession: lis[index]['profession'],
                                      id: lis[index]['userid'],
                                      dis0: lis[index]['district0'],
                                      dis1: lis[index]['district1'])),
                            ).then((var value) {
                              setState(() {});
                            }),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                              lis[index]['name']
                                                  .toString()
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25)),
                                                   Text(lis[index]['profession'],style: TextStyle(color: Colors.orange[800],fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 10),
                                 
                                  Divider(),
                                  SizedBox(height: 10),
                                   Text('In Charge of districts:',style: TextStyle(color: Colors.red,fontSize: 15)),
                                     
                                  Padding(
                                    padding: const EdgeInsets.only(top:10.0),
                                    child: Row(
                                      children: <Widget>[
                                       
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 3, horizontal: 10),
                                          margin: EdgeInsets.all(0),
                                          decoration:
                                              ut.rounded(Colors.red, false, 40),
                                          child: Text(
                                            lis[index]['district0'],
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
                                          padding: EdgeInsets.symmetric(
                                              vertical: 3, horizontal: 10),
                                          margin: EdgeInsets.all(0),
                                          decoration:
                                              ut.rounded(Colors.red, false, 40),
                                          child: Text(
                                            lis[index]['district1'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
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
                                      Expanded(child: SizedBox()),
                                      CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.grey[100],
                                          child: IconButton(
                                              icon: KoukiconsCallback(
                                                color: Colors.green,
                                              ),
                                              onPressed: () {
                                                launch("tel://" +
                                                    lis[index]['phone']);
                                              })),
                                    ],
                                  )
                                ],
                              ),
                            )),
                          ),
                        );
                      }),
                    )
         
      ),
    );
  }
}
