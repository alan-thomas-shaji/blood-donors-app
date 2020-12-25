import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatelessWidget {
  final String name;
  final String age;
  final String number;
  final String hospital;
  final String units;
  final String location;
  final String group;
  final String altNumber;
  final String date;
  final String district;

  Details({
    @required this.name,
    @required this.hospital,
    @required this.location,
    @required this.units,
    @required this.group,
    @required this.age,
    @required this.number,
    @required this.altNumber,
    @required this.date,
    @required this.district,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget details = new ListView(

      children: <Widget>[
        ListTile(
          title:Text("Patient's Name:",style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
          subtitle:Text(name,style: TextStyle(fontSize: 18.0),),
        ),
        ListTile(
          title:Text("Bloodgroup",style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
          subtitle:Text(group,style: TextStyle(fontSize: 18.0),),
        ),
        ListTile(
          title:Text("Age",style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
          subtitle:Text(age,style: TextStyle(fontSize: 18.0),),
        ),
        ListTile(
          title:Text("Date:",style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
          subtitle:Text(date,style: TextStyle(fontSize: 18.0),),
        ),
        ListTile(
          title:Text("Units:",style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
          subtitle:Text(units,style: TextStyle(fontSize: 18.0),),
        ),
        ListTile(
          title:Text("Phone number:",style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
          subtitle:Text(number,style: TextStyle(fontSize: 18.0),),
        ),
        ListTile(
          title:Text("Alternate number:",style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
          subtitle:Text(altNumber,style: TextStyle(fontSize: 18.0),),
        ),
        ListTile(
          title:Text("Hospital:",style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
          subtitle:Text(hospital,style: TextStyle(fontSize: 18.0),),
        ),
        ListTile(
          title:Text("Location(Taluk):",style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
          subtitle:Text(location,style: TextStyle(fontSize: 18.0),),
        ),
        ListTile(
          title:Text("District",style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
          subtitle:Text(district,style: TextStyle(fontSize: 18.0),),
        ),
        
        Padding(
          padding: const EdgeInsets.all(30.0),
          child:RaisedButton.icon(
                                    icon: Icon(Icons.phone,size: 25,color: Colors.white,),
                                    onPressed: () {
                                      launch("tel://"+number);
                                    },
                                    
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color: Colors.red,
                                    label: Text(
                                      "Contact",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )),
          
        ),
      ],
    );
    return Scaffold(
        appBar: AppBar(
          title: Text("Details"),
        ),
        body:
        details
    );
  }
}
