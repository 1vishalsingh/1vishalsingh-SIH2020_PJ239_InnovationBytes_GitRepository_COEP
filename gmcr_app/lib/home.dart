import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmcr_app/ComplaintList.dart';
import 'package:gmcr_app/chat/chat_screen.dart';
import 'package:gmcr_app/contect_us.dart';
import 'package:gmcr_app/user.dart';
import 'complainPage.dart';
import 'first_page.dart';

final primaryColor = Colors.deepPurpleAccent[400];

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({this.user, Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _HomePageState extends State<HomePage> {
  final green = Colors.green;
  final red = Colors.red;
  final cyan = Colors.cyan;
  final blue = Colors.blueAccent;

  String a = 'Complaint\nRegister';
  String b = 'ChatUs';
  String c = 'Complaint\nCheck';
  String d = 'ContactUs';

  final e = Icons.edit;
  final f = Icons.chat;
  final g = Icons.playlist_add_check;
  final h = Icons.contact_phone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      drawer: Drawer(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        color: Colors.blue,
                        size: 35,
                      ),
                    ),
                    width: 60,
                    height: 60,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    widget.user.name,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.user.email,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(left: 5,right: 5),
            child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: RaisedButton.icon(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContectUs()));
                  }, label: Text('Contact Us',style: TextStyle(fontSize: 20),), icon: Icon(Icons.contact_phone,size: 30,color:Colors.black54,),
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5,right: 5,top: 8),
            child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: RaisedButton.icon(
                  onPressed: (){
                    signOut(context);
                  }, label: Text('Log Out',style: TextStyle(fontSize: 20),), icon: Icon(Icons.lock,size: 30,color:Colors.black54,),
                )
            ),
          ),
        ],
      )),
      body: Center(
          child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        iconSize: 30,
                        icon: Icon(
                          Icons.menu,
                          color: Colors.black,
                        ),
                        onPressed: () => _scaffoldKey.currentState.openDrawer(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 60, top: 10, bottom: 25),
                          child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 100,
                              child: Image(image: AssetImage('images/logo.png'))),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Gray Market Complaints Register',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      getbutton(green, e, a, 1),
                      getbutton(red, f, b, 2)
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      getbutton(cyan, g, c, 3),
                      getbutton(blue, h, d, 4),
                    ],
                  ),
                ]),
          ),
        ),
      )),
    );
  }

  getbutton(color, icon, text, a) {
    return Container(
      height: 150,
      width: 150,
      child: RaisedButton(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () {
          geting(a);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),
            Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  geting(int a) {
    String uid = widget.user.uid;
    String num = widget.user.number;
    String name = widget.user.name;
    String email = widget.user.email;
    final user = User(uid: uid, name: name, number: num, email: email);

    switch (a) {
      case 1:
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ComplainPage(
                        user: user,
                      )));
        }
        break;
      case 2:
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatScreen(
                        user: user,
                      )));
        }
        break;
      case 3:
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ComplaintList(
                        user: user,
                      )));
        }
        break;
      case 4:
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ContectUs()));
        }
        break;
      default:
    }
  }

  signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => FirstPage()));
  }
}
