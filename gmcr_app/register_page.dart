import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gmcr_app/first_page.dart';
import 'package:gmcr_app/home.dart';
import 'package:gmcr_app/user.dart';

final primaryColor = Colors.deepPurpleAccent[400];

class RegisterPage extends StatefulWidget {
  final Num user;
  const RegisterPage({this.user, Key key}) : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _name = TextEditingController();
  bool circuler = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: circuler
          ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      )
          : SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 75,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          color: Colors.lightBlueAccent,
                          iconSize: 40,
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => signOut(context),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: CircleAvatar(
                            backgroundColor: Colors.lightBlueAccent,
                            radius: 35,
                            child: Icon(
                              Icons.person,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: <Widget>[
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                            color: Colors.white,
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: 70,
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.call,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.user.num,
                                style:
                                    TextStyle(fontSize: 20, letterSpacing: 1),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Full Name',
                              errorStyle:
                                  TextStyle(fontSize: 20, color: Colors.red)),
                          controller: _name,
                          validator: (name) {
                            if (name.isEmpty) {
                              return 'Enter Valid Name';
                            } else {
                              return null;
                            }
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Email Address',
                            errorStyle:
                                TextStyle(fontSize: 20, color: Colors.red)),
                        validator: (email) {
                          if (!EmailValidator.validate(email)) {
                            return 'Enter Valid Email Address';
                          } else {
                            return null;
                          }
                        },
                        controller: _email,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: RaisedButton(
                              focusElevation: 10,
                              elevation: 10,
                              splashColor: Colors.lightBlueAccent,
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              color: Colors.lightBlueAccent,
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    circuler = true;
                                  });
                                  String uid = widget.user.uid;
                                  String num = widget.user.num;
                                  String name = _name.text;
                                  String email = _email.text;
                                  final user = User(
                                      uid: uid,
                                      name: name,
                                      number: num,
                                      email: email);

                                  Firestore.instance
                                      .collection("users")
                                      .document(widget.user.uid)
                                      .setData({
                                    'uid': widget.user.uid,
                                    'Name': _name.text,
                                    'email': _email.text,
                                    'Number': widget.user.num,
                                  }).then((value) => {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomePage(
                                                          user: user,
                                                        ))),
                                          });
                                } else {
                                  print(widget.user.num);
                                  print('error in login page \n\n\n');
                                }
                              })),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }

  signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => FirstPage()));
  }
}
