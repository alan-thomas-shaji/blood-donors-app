import 'package:flutter/material.dart';
import 'utils.dart' as ut;

class CoordinatorDetails extends StatefulWidget {
  final String name,
      phone,
      mail,
      taluk,
      district,
      ve_re,
      experience,
      profession,id,dis0,dis1;
  CoordinatorDetails(
      {Key key,
      this.name,
      this.phone,
      this.mail,
      this.taluk,
      this.district,
      this.ve_re,
      this.experience,
      this.profession,this.id,this.dis0,this.dis1})
      : super(key: key);

  @override
  _CoordinatorDetailsState createState() => _CoordinatorDetailsState(this.name,this.phone,this.mail,this.taluk,this.district,this.ve_re,this.experience,this.profession,this.id,this.dis0,this.dis1);
}

class _CoordinatorDetailsState extends State<CoordinatorDetails> {
String name,
      phone,
      mail,
      taluk,
      district,
      ve_re,
      experience,
      profession,id,dis0,dis1;
_CoordinatorDetailsState(String n,String p,String m,String tal,String dis,String ver,String exper,String pro,String id,String d0,String d1){
  this.name=n;
  this.phone=p;
  this.mail=m;
  this.taluk=tal;
  this.district=dis;
  this.ve_re=ver;
  this.experience=exper;
  this.profession=pro;
  this.id=id;
  this.dis0=d0;
  this.dis1=d1;
}
  Map f = {};
  @override
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ut.maintheme(),
      home: Scaffold(
         
          appBar: AppBar(
            title: Text(this.name),
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
                      name.toUpperCase(),
                      style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      profession,
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
                            "$experience years",
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
                            ve_re,
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
                  "Phone",
                  style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),
                ),
                subtitle: Text(
                  this.phone,
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
                  mail,
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
                  taluk,
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
                  district,
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
