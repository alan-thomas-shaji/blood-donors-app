import 'package:flutter/material.dart';
import 'package:revive/utils.dart' as ut;


class Faq extends StatelessWidget {
  String what = "Donating blood is a life saving measure especially when you have a rare blood type. Donating blood is safe and simple. It takes approximately 10-15 minutes to complete the blood donation process. We can save up to 3 to 4 precious lives by donating blood.";
  String process ="1) You walk into a reputed and safe blood donation centre or a mobile camp organized by a reputed institution.\n2) A few questions will be asked to determine your health status (general questions on health, donation history etc). Usually you will be asked to fill out a short form.\n3) Then a quick physical check will be done to check temperature, blood pressure, pulse and hemoglobin content in blood to ensure you are a healthy donor.\n4) If found fit to donate, then you will be asked to lie down on a resting chair or a bed. Your arm will be thoroughly cleaned. Then using sterile equipments blood will be collected in a special plastic bag. Approximately 350 ml of blood will be collected in one donation. Those who weigh more than 60 Kg can donate 450 ml of blood.\n5) Then you must rest and relax for a few minutes with a light snack and something refreshing to drink. Some snacks and juice will be provided.\n6) Blood will be separated into components within eight hours of donation.\n7) The blood will then be taken to the laboratory for testing.\n8) Once found safe, it will be kept in special storage and released when required.\n9) The blood is now ready to be taken to the hospital, to save lives.";
  String why = "1) Blood transfusions save lives.\n2) There's no substitute for human blood.\n3) Every three seconds, someone needs a blood transfusion.\n4) About 60 percent of the population are eligible to donate blood, yet less than five percent do.\n5) Fulfils your desire to \"give back\" to the community.";
  String criteria = "1) If you are healthy and between the age group of 18-60 years.\n2) If your weight is 45 kgs or more.\n3) If your haemoglobin is 12.5 gm% minimum.\n4) If your last blood donation date is more than 3 months for male & 4 months for female.\n5) If you have not suffered from malaria, typhoid or other transmissible disease in the recent past.";
  String notcriteria = "1) If you had cold / fever in the past 1 week.\n2) If you were under treatment with antibiotics or any other medication.\n3) If you have cardiac problems, hypertension, epilepsy, diabetes (on insulin therapy), history of cancer, chronic kidney or liver disease, bleeding tendencies, venereal disease etc.\n4) If you had a major surgery in the last 6 months period.\n5) If you had vaccination in the last 24 hours.\n6) If you had a miscarriage in last 6 months or have been pregnant / lactating in the last one year.\n7) If you are having heavy menstrual flow or menstrual cramps and before the completion of 10 days from the start of menstrual date.\n8) If you had fainting attacks during last donation.\n9) If you had shared a needle to inject drugs/ have history of drug addiction.\n10) If you had sexual relations with different partners or with a high risk individual or you have been tested positive for antibodies to HIV.";
  String prep = "1) Have a good meal at least 3 hours before donating blood.\n2) Have a good sleep at least for 8 hours in the previous night.\n3)Avoid smoking on the day before donating. You may smoke 3 hours after donation.\n4) Don't take aspirin, or products containing aspirin, for at least 72 hours before donating blood.\n5) Don't consume alcohol within 48 hours before donation.";
  String after = "1) Accept the snacks and refreshments offered to you after the donation.\n2) You are recommended to have a good meal later.\n3) You can resume your normal activities after donating blood, though you are asked to refrain from exercise or heavy weight lifting for at least twelve hours after donation.\n4) Avoid lifting, pushing or picking up heavy objects for at least four or five hours after giving blood.\n5) Drink lots of fluids for the next 48 hours.\n6) If you choose to consume alcohol, you may do so in the next day.";
  String request = "1) We have an option called \"Request Blood\" on Home page for Registerd Users and Coordinators. Click on the link.\n2) Fill the form with accurate details.\n3) WK coordinator will verify your request in short notice and you'll get notified about the status of your request.\n4)The donors will be arranged accordingly based on your requirement.\n5)Also you can find donors using \"Search Donor\" option";
  String register = "1) We have an option called \"Register here\" on Home page. Click on the link.\n2) Fill the form with accurate details.\n3) WK coordinator will contact you based on the requirements they get.\n4) You will be guided to the hospital by WK coordinators as required.\n5) Visit Request Feed Page to get each day's blood requirements.";
  String gap = "1) You will be contacted by our team to update the last donation date.\n2) Once the last donation date is up to date, you will be shown inactive in our data system.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQ"),
        centerTitle: true,
        leading: IconButton(icon:Icon(Icons.arrow_back_ios),onPressed:(){
           Navigator.pop(context);
        },),
        backgroundColor: Colors.red[400],
      ),
      body: Container(
        width:MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10.0),
        //color: Colors.red[400],
        decoration: ut.bg(),
        child:
          ListView(
            padding: EdgeInsets.all(5.0),
            children: <Widget>[
              ExpansionTile(
                title: Text("What is blood donation?",
                  style: TextStyle(
                      color: Colors.red[400],fontWeight: FontWeight.bold,fontSize: 21),),
                trailing: Icon(Icons.arrow_drop_down,color: Colors.grey,),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child:Text(what,
                    style: TextStyle(fontSize: 17),
                  ),),
                ],
              ),
              Divider(),
              ExpansionTile(
                title: Text("What is the process?",
                  style: TextStyle(
                      color: Colors.red[400],fontWeight: FontWeight.bold,fontSize: 21),),
                trailing: Icon(Icons.arrow_drop_down,color: Colors.grey,),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child:Text(process,
                    style: TextStyle(fontSize: 17),
                    ),),
                ],
              ),
              Divider(),
              ExpansionTile(
                title: Text("Why to donate blood?",
                  style: TextStyle(
                      color: Colors.red[400],fontWeight: FontWeight.bold,fontSize: 21),),
                trailing: Icon(Icons.arrow_drop_down,color: Colors.grey,),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child:Text(why,
                      style: TextStyle(fontSize: 17),
                    ),),
                ],
              ),
              Divider(),
              ExpansionTile(
                title: Text("Who can donate blood?",
                  style: TextStyle(
                      color: Colors.red[400],fontWeight: FontWeight.bold,fontSize: 21),),
                trailing: Icon(Icons.arrow_drop_down,color: Colors.grey,),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child:Text(criteria,
                      style: TextStyle(fontSize: 17),
                    ),),
                ],
              ),
              Divider(),
              ExpansionTile(
                title: Text("Who can't donate blood?",
                  style: TextStyle(
                      color: Colors.red[400],fontWeight: FontWeight.bold,fontSize: 21),),
                trailing: Icon(Icons.arrow_drop_down,color: Colors.grey,),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child:Text(notcriteria,
                      style: TextStyle(fontSize: 17),
                    ),),
                ],
              ),
              Divider(),
              ExpansionTile(
                title: Text("Any preparation needed before a blood donation?",
                  style: TextStyle(
                      color: Colors.red[400],fontWeight: FontWeight.bold,fontSize: 21),),
                trailing: Icon(Icons.arrow_drop_down,color: Colors.grey,),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child:Text(prep,
                      style: TextStyle(fontSize: 17),
                    ),),
                ],
              ),
              Divider(),
              ExpansionTile(
                title: Text("What all should be done once a blood donation happens?",
                  style: TextStyle(
                      color: Colors.red[400],fontWeight: FontWeight.bold,fontSize: 21),),
                trailing: Icon(Icons.arrow_drop_down,color: Colors.grey,),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child:Text(after,
                      style: TextStyle(fontSize: 17),
                    ),),
                ],
              ),
              Divider(),
              ExpansionTile(
                title: Text("How can I request for blood?",
                  style: TextStyle(
                      color: Colors.red[400],fontWeight: FontWeight.bold,fontSize: 21),),
                trailing: Icon(Icons.arrow_drop_down,color: Colors.grey,),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child:Text(request, style: TextStyle(fontSize:17),
                    ),),
                ],
              ),
              Divider(),
              ExpansionTile(
                title: Text("How can I register as a blood donor?",
                  style: TextStyle(
                      color: Colors.red[400],fontWeight: FontWeight.bold,fontSize: 21),),
                trailing: Icon(Icons.arrow_drop_down,color: Colors.grey,),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child:Text(register,
                      style: TextStyle(fontSize: 17),
                    ),),
                ],
              ),
              Divider(),
              ExpansionTile(
                title: Text("After donation how do I let you know that I can't donate for the next 3 or 4 months?",
                  style: TextStyle(
                      color: Colors.red[400],fontWeight: FontWeight.bold,fontSize: 21),),
                trailing: Icon(Icons.arrow_drop_down,color: Colors.grey,),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child:Text(gap,
                      style: TextStyle(fontSize: 17),
                    ),),
                ],
              ),
             
            ],
          )
      ),
    );
  }
}
