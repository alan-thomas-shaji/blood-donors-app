import 'package:flutter/material.dart';
import 'package:revive/newsfeed.dart';
import 'utils.dart' as ut;

class ChooseGroup extends StatefulWidget {
  ChooseGroup({Key key, this.emergency}) : super(key: key);

  final bool emergency;

  @override
  ChooseGroupState createState() => new ChooseGroupState(emergency);
}
class ChooseGroupState extends State<ChooseGroup> {
  bool emergency;
  List groups = ["A+","A-","B+","B-","AB+","AB-","O+","O-","Oh","A2B+","A2B-","-D-/-D-","In(a+b-)","Co(a-b-)","I-i-","Mg"];
  ChooseGroupState(bool a){
    emergency = a;
    
  }
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
      title: 'Choose group',
      theme: ut.maintheme(),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Choose bloodgroup'),
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          body: Container(
            decoration: ut.bg(),
            child:
            Center(
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child:Container(
                      width: 300,
                      height: 300,
                      child: gridview(),
                    )
                    ),


                  ],
                )
            ),
          )
      ),
    );
  }
  gridview(){
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 2,
      // Generate 100 widgets that display their index in the List.
      children: List.generate(groups.length, (index) {
        return Center(
          child: InkWell(
            child:Container(
              decoration: ut.rounded(Colors.red, false, 50),
              width: 100,height: 100,
              padding: EdgeInsets.all(10),
              child:Align(
                  alignment: Alignment.center,
                  child:Text(
            '${groups[index]}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 35,color: Colors.white)
          )
              )
          ),
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewsFeed(emergency:false,
                        group: groups[index],)));
            },
          )
        );
      }),
    );

  }
//  newsfeed(){
//    Navigator.push(
//        context,
//        MaterialPageRoute(
//            builder: (context) => ChooseGroup(emergency: true,)));
//  }
}
