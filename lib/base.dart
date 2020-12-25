import 'package:flutter/material.dart';
import 'utils.dart' as ut;

import 'globals.dart';

class Base extends StatefulWidget {

  @override
  BaseState createState() => new BaseState();
}
class BaseState extends State<Base> {
  
  asyncFunc(BuildContext) async {
    
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
      title: 'Base',
      theme: ut.maintheme(),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Base'),
          ),
          body: Container(
            decoration: ut.bg(),
            child:
            Center(
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Base Activity")
                  ],
                )
            ),
          )
      ),
    );
  }
}
