import 'dart:ui';

import 'package:flutter/material.dart';
import 'utils.dart' as ut;

import 'package:url_launcher/url_launcher.dart';
class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ABOUT THE APP'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.red[400],
      ),
      body: Container(
        decoration: ut.bg(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20,),
              ut.logo(),
              Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    'WK Blood Book is an open source project started under Tomercon Developers in the idea of providing an online platform for the communication between blood donors and acceptors. We aim to provide a user friendly interface which facilitates the communication , resulting in an improved facility to address the needs of patients in need of blood donations. Donors will be able to search for patients in need according to their given locations and other details , and will be provided contact details of the by-stander of the respective patient. They will also have the privilage to mark themselves as unavailable if they are not available at the moment , or if they have already made a blood donation recently. Notifications will be available to the available donors including emergency cases where donation is required urgently',
                    style: TextStyle(
                      height: 1.3,
                      letterSpacing: 1,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Row(
                
                children: <Widget>[
                  Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(25, 4,25 , 8),
                                        child: RaisedButton(onPressed: (){_launchURL();},
                                        shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(18.0),
  side: BorderSide(color: Colors.red)
),
                                        color: Colors.red,
                    child: Text("PRIVACY POLICY",style: TextStyle(color:Colors.white),),),
                                      ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _launchURL() async {
  const url = 'http://vps001.qubehost.com/bloodapp/privacypolicy/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
}
