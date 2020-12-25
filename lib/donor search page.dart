import 'package:flutter/material.dart';
import 'package:revive/donor%20list.dart';
import 'utils.dart' as ut;
import 'globals.dart' as g;

class DonorSearch extends StatefulWidget {
  @override
  _DonorSearchState createState() => _DonorSearchState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class _DonorSearchState extends State<DonorSearch> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String sbg, d, tl;
  List l = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ut.maintheme(),
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Donor Search'),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          prefixIcon: (Icon(Icons.invert_colors,
                              color: Color(0xFFFB415B))),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey))
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(20.0)
                          // )
                          ),
                      isExpanded: true,
                      validator: (value) =>
                          value == null ? 'Field required...' : null,
                      hint: Text('Choose Blood group',
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                      items: g.bloodgroup.map((lisVal) {
                        return DropdownMenuItem<String>(
                          value: lisVal,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(lisVal,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20))
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String val) {
                        setState(() {
                          this.sbg = val;
                        });
                      },
                      value: this.sbg,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          prefixIcon:
                              (Icon(Icons.home, color: Color(0xFFFB415B))),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey))),
                      isExpanded: true,
                      validator: (value) =>
                          value == null ? 'Field required...' : null,
                      hint: Text('Choose District',
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                      items: g.districts.map((lisVal) {
                        return DropdownMenuItem<String>(
                          value: lisVal,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(lisVal,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String val) {
                        setState(() {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          this.d = val;
                          l = g.tlk[d];
                        });
                        tl = null;
                      },
                      value: this.d,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //taluk selector
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          prefixIcon:
                              (Icon(Icons.home, color: Color(0xFFFB415B))),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey))),
                      isExpanded: true,
                      validator: (value) =>
                          value == null ? 'Field required...' : null,
                      hint: Text('Choose Taluk',
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                      items: l.map((lisVal) {
                        return DropdownMenuItem<String>(
                          value: lisVal,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(lisVal,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String val) {
                        setState(() {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          this.tl = val;
                          print(tl);
                        });
                      },
                      value: this.tl,
                    ),
                    SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        if (!_formKey.currentState.validate()) {
                          g.submitForm(_formKey, _scaffoldKey,
                              'Form is not valid!  Please review and correct.');
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DonorList(
                                        dis: d,
                                        tal: tl,
                                        bg: sbg,
                                      )));
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(30),
                        height: 56.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.0),
                          gradient: LinearGradient(
                              colors: [Color(0xFFFB415B), Color(0xFFEE5623)],
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft),
                        ),
                        child: Center(
                          child: Text(
                            "Search",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
