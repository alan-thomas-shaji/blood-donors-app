import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

String mongo_url =
    "mongodb://developers:123456@vps001.qubehost.com:27017/Bloodproject?authSource=Bloodproject&authMechanism=SCRAM-SHA-1";
String app_name = "revive";
String app_version = "0.01-a";
String baseUrl =
    "http://vps001.qubehost.com/bloodapp/"; //Need to update after setup server
Color prim_color = Colors.red[400]; //Color for appbar
String bg_image = "assets/images/bg.png"; //background image for all pages
//=============== VARIABLES FOR HOLDING CURRENT USER INFO ===============
String cu_id;
String cu_name;
String cu_type;
String g_bg = '', g_n = '', g_l = '';
bool del = false;
//=======================================================================
List bloodgroup = [
  'A+',
  'A-',
  'O+',
  'O-',
  'B+',
  'B-',
  'AB+',
  'AB-',
  'Oh',
  'A2B+',
  'A2B-',
  '-D-/-D-',
  'In(a+b-)',
  'Co(a-b-)',
  'I-i-',
  'Mg'
];
Map<String, List<String>> tlk = {
  "Thiruvananthapuram": [
    'Neyyattinkara',
    'Kattakada',
    'Nedumangadu',
    'Thiruvananthapuram',
    'Chirayankeezhu',
    'Varkala'
  ],
  "Kollam": [
    'Kollam',
    'Kunnathoor',
    'Karunagappally',
    'Kottarakara',
    'Punalur',
    'Pathanapuram'
  ],
  "Pathanamthitta": [
    'Adoor',
    'Konni',
    'Kozhencherry(HO:Pathanamthitta)',
    'Ranni',
    'Mallappally',
    'Thiruvalla'
  ],
  "Alappuzha": [
    'Chenganoor',
    'Mavelikara',
    'Karthikappally',
    'Kuttanad',
    'Ambalappuzha',
    'Cherthala'
  ],
  "Kottayam": [
    'Kottayam',
    'Vaikom',
    'Kanjirappally',
    'Meenachil',
    'Changanassery'
  ],
  "Idukki": ['Devikulam', 'Thodupuzha', 'Peermedu', 'Udumbanchola', 'Idukki'],
  "Ernakulam": [
    'Kanayannur',
    'Kochi',
    'Aluva',
    'Kunnathunad',
    'Kothamangalam',
    'Muvattupuzha',
    'Paravur'
  ],
  "Thrissur": [
    'Kodungallur',
    'Chavakkad',
    'Mukundapuram',
    'Thrissur',
    'Thalapilly',
    'Chalakudy',
    'Kunnamkulam'
  ],
  "Palakkad": [
    'Palakkad',
    'Chittur',
    'Alathoor',
    'Mannarkkad',
    'Ottappalam',
    'Pattambi'
  ],
  "Malappuram": [
    'Perinthalmanna',
    'Eranad',
    'Nilambur',
    'Tirur',
    'Ponnani',
    'Thiroorangadi',
    'Kondotty'
  ],
  "Kozhikode": ['Kozhikode', 'Koilandy', 'Vadakara', 'Thamarassery'],
  "Wayanad": ['Mananthavady', 'Vythiri', 'Sulthan Bathery'],
  "Kannur": ['Taliparamba', 'Thalassery', 'Kannur', 'Iritty', 'Payyannur'],
  "Kasargod": ['Hosdurg', 'Vellarikundu', 'Manjeshwaram', 'Kasaragod']
};
List districts = [
  "Thiruvananthapuram",
  "Kollam",
  "Pathanamthitta",
  "Alappuzha",
  "Kottayam",
  "Idukki",
  "Ernakulam",
  "Thrissur",
  "Palakkad",
  "Malappuram",
  "Kozhikode",
  "Wayanad",
  "Kannur",
  "Kasargod"
];
void submitForm(GlobalKey<FormState> key1, GlobalKey<ScaffoldState> scaffoldKey,
    String message) {
  final FormState form = key1.currentState;
  if (!key1.currentState.validate()) {
    showMessage(scaffoldKey, message);
  } else {
    form.save(); //This invokes each onSaved event
  }
}

void showMessage(GlobalKey<ScaffoldState> scaffoldKey, String message,
    [MaterialColor color = Colors.red]) {
  scaffoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: color,
      content: new Text(
        message,
        style: TextStyle(
          fontSize: 16,
        ),
      )));
}

class UserLocationTracker {
  void getCurrentUserLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
  }
} //import this class for current user location.

var fcm_token;
