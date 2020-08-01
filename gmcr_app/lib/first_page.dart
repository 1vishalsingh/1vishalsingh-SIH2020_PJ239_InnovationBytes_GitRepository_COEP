import 'package:flutter/material.dart';
import 'package:gmcr_app/phone_auth.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Builder(
                  builder: (context) => Column(children: <Widget>[
                    Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 60, right: 60, top: 40, bottom: 40),
                          child: Image(image: AssetImage('images/logo.png')),
                        )),
                    Text(
                      'Gray Market Complaints Register',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton.icon(
                          elevation: 10,
                          splashColor: Colors.lightBlueAccent,
                          padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                          color: Colors.lightBlueAccent,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => SignUp()));
                          },
                          icon: Icon(Icons.person,color: Colors.white,),
                          label: Text(
                            '    Login / SignUp',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ]),
                ),
              ),
            ),
          ),
        ));
  }
}
