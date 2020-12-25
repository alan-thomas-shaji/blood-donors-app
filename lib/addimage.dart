import 'package:flutter/material.dart';
import 'home.dart';
import 'utils.dart' as ut;
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
//import 'gallery.dart';
//import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'globals.dart';
import 'package:mongo_dart/mongo_dart.dart' as mon;

class Addimage extends StatefulWidget {

  @override
  AddimageState createState() => new AddimageState();
}
class AddimageState extends State<Addimage> {
  File _image;
  TextEditingController cap = new TextEditingController();
  asyncFunc(BuildContext) async {
    await initmon();
  }

    
  mon.Db db;
  initmon() async {
    db = new mon.Db(mongo_url);
    await db.open().then((val){print("$val");});
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => start(context));
  }
  void start(BuildContext){
    asyncFunc(BuildContext);
  }
  @override void dispose() {super.dispose();}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Image',
      theme: ut.maintheme(),
      home: Scaffold(
          appBar: AppBar(
            leading:BackButton(onPressed:(){
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> HomeScreen()) );}),

             
        
            title: Text('Add Image'),
          ),
          body: Container(
            decoration: ut.bg(),
            child:
            Center(
                child:
                Container(
                  //   decoration: ut.mycard(Colors.white, 10.0, 20.0),
                  margin: EdgeInsets.all(10),
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                      Container(
                          padding: EdgeInsets.all(10),
                          child: profilephotopicker()),
                      Container(
                          margin:EdgeInsets.all(10),
                          //  decoration : ut.rounded2(Colors.white,false,30),
                          child:RaisedButton(
                            onPressed:() { _upload(); },
                            child: Text("Upload"),
                          )
                      )
                    ],
                  ),
                )
            ),
          )
      ),
    );
  }

  Widget profilephotopicker(){
    return InkWell(
      onTap: _choose,
      child:
      Container(
        padding: EdgeInsets.all(10),
        color: Colors.grey[100],
        child:Row(
          children: <Widget>[
            Expanded(
              flex: 1, // 30%
              child: Container(child: Icon(Icons.add_a_photo,color: Colors.green,)),
            ),
            Expanded(
              flex: 3, // 30%
              child: Container(child: Text('PICK IMAGE',style: TextStyle(color: Colors.black),),
              ),),

            Expanded(
              flex: 6, // 70%
              child: Container(color: Colors.grey[50],
                child: _image == null
                    ? Text('No image selected.')
                    : Image.file(_image,width: 200,height: 100,),),
            ),
          ],
        ),),);
  }
  void _choose() async {
    var f= await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = f;
    });
// file = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  void _upload() async {


    if (_image == null) return;
    String base64Image = base64Encode(_image.readAsBytesSync());


    var gallery = db.collection("gallery");
    await gallery.insert({"image":base64Image}).then((onValue){

      showDialog(context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title : new Text("Image inserted succefully"),
              actions: <Widget>[
                FlatButton(onPressed:(){
                  Navigator.pop(context); }
                    , child: new Text("ok"))
              ],
            );
          });
    });
  }
}
