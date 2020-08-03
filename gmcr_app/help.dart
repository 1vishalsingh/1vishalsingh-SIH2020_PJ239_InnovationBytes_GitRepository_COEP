import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmcr_app/faq.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('How to Register'),
      backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("1. First verify your mobile number ",style: style(),),
              space(),
              Text("2. Select your operator ",style: style(),),
              space(),
              Text("3. Select your state ",style: style(),),
              space(),
              Text("4. Select Country Code of International/Fraud call (eg: +01) ",style: style(),),
              space(),
              Text("5. Enter the intenational/Fraud number ",style: style(),),
              space(),
              Text("6. Select Date and Time when call received ",style: style(),),
              space(),
              Text("7. This is optional (write brief description)",style: style(),),
              SizedBox(height: 50,),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    elevation: 10,
                    splashColor: Colors.grey,
                    padding: EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    color: Colors.grey,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>FaQ()));
                    },

                    child: Text(
                      ' FAQ ',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
          ],),
        ),
      ),
    );
  }
  style(){
    return
    TextStyle(fontSize: 20);
  }
  space(){return
    SizedBox(height: 10,);
  }
}
