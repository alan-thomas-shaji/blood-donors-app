import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:revive/home.dart';
import 'utils.dart' as ut;

import 'globals.dart';
import 'package:mongo_dart/mongo_dart.dart' as mon;

class DeleteImage extends StatefulWidget {
 List images;
 DeleteImage({this.images});
  @override
  DeleteImageState createState() => new DeleteImageState(images: images);
}
class DeleteImageState extends State<DeleteImage> {
  List images;
DeleteImageState({this.images});

  asyncFunc(BuildContext) async {
    initmon();
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
  deleteimage(String image,int index) async{
   var gallery = db.collection("gallery");
  await gallery.remove({"image":image}).then((onValue) {
   print(onValue);
  });
  setState(() {
    images.removeAt(index);
  });
  }
  @override void dispose() {super.dispose();}
  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      title: 'Delete Image',
      theme: ut.maintheme(),
      home: Scaffold(
          appBar: AppBar(
            leading:BackButton(onPressed:(){
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> HomeScreen()) );}),
            title: Text('Delete Image'),
          ),
          body:Container(
            decoration: ut.bg(),
            child: images.length == 0 ? ut.empty_server("No images to delete")  : ListView.builder(
  itemCount: images.length,
  itemBuilder: (context, index) {
    return Card(
             elevation: 10,
            child: ListTile(
        title: Image.memory(base64Decode(images[index])),
        trailing:IconButton(icon: Icon(Icons.delete), onPressed:() {
          
      showDialog(context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title : new Text("Are you sure to delete this image"),
          actions: <Widget>[
            FlatButton(onPressed:(){
          deleteimage(images[index],index);
           Navigator.pop(context); }, child: new Text("ok"))
          ],
        );
      });
          
        
        }) ,
      ),
    );
  },
),
          )
              
            
      ),
    );
  }
}