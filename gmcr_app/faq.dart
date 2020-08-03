import 'package:flutter/material.dart';

class FaQ extends StatefulWidget {
  @override
  _FaQState createState() => _FaQState();
}

class _FaQState extends State<FaQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FAQ'),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("1. what is grey market? ",style: style(),),
              space(),
              Text("Ans: Grey market is defined as the use of illegal telephone  exchanges for making international calls bypassing the legal route and exchanges. ",style: style(),),
              space(),
              Text("2. who can register on  this ? ",style: style(),),
              space(),
              Text("Ans: The person who have got a international fruad  call on his mobile  number.",style: style(),),
              space(),
              Text("3.what is LSA? ",style: style(),),
              space(),
              Text("Ans: LSA means Local Service Area.The telecom circle which your sim card is registered  ",style: style(),),
              space(),
              Text("4. what is country code?",style: style(),),
              Text("Ans: Country codes are short alpahababetic or numeric geographical codes developed to represent countries and dependent areas, for use in data processing and communication. example india country code is +91.",style: style(),),
              space(),
              Text("5. Will My data  be in safe hand ?",style: style(),),
              space(),
              Text("Ans: yes. your data is in safa hand as it is  under the control  of department of Telecommunication Goverment of india.",style: style(),),
              space(),
              Text("6. what is the work  of Department of Telecommunication Goverment of india? ",style: style(),),
              space(),
              Text("Ans: Funtion of DoT is policy, Liensing and coordination , telephones , wireless ,data , facsimile , and telematic services and other like forms of communication.",style: style(),),
              space(),
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

