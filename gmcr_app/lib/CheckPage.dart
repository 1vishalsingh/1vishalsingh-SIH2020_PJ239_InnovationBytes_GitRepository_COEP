import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmcr_app/first_page.dart';
import 'package:gmcr_app/home.dart';
import 'package:gmcr_app/register_page.dart';
import 'package:gmcr_app/user.dart';

class CheckPage extends StatefulWidget {
  @override
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((currentUser) {
      if (currentUser == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => FirstPage()));
      } else {

        Firestore.instance
            .collection('users')
            .document(currentUser.uid)
            .snapshots()
            .listen((event) {
          String number = currentUser.phoneNumber;
          String uid = currentUser.uid;
          try{
            String number = currentUser.phoneNumber;
            String uid = currentUser.uid;
              String name = event.data['Name'];
              String email = event.data['email'];
              print(email);
              print(uid);
              final userdetail = User(
                  uid: uid, name: name, number: number, email: email);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HomePage(
                            user: userdetail,
                          )));
          }
          catch(e) {
            final user = Num(num: number, uid: uid);

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => RegisterPage(
                      user: user,
                    )));
          }
        });
      }
    });
//    catchError((error) => print(error));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            width: 10,
          ),
          Text('  Loading'),
        ],
      ),
    )));
  }
}
