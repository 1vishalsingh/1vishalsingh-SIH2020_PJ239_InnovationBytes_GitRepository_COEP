import 'package:flutter/material.dart';
import 'package:gmcr_app/user.dart';

final primaryColor = Colors.deepPurpleAccent[400];


class ContectUs extends StatefulWidget {
  const ContectUs({Key key}) : super(key: key);

  @override
  _ContectUsState createState() => _ContectUsState();
}

class _ContectUsState extends State<ContectUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Contact Us'),
      ),
      body: Column(
        children: <Widget>[
          getcard('Toll free Nos. ', '1963/1800110420', Icons.phone),
          getcard('email ', 'gmcr@gmail.com', Icons.email),
          getcard('Address ', 'New Delhi, India', Icons.home)

        ],
      ),
    );
  }

  getcard(title,subtitle,icon){
    return
    Card(
      child: ListTile(
        leading: Icon(icon,
          color: primaryColor,
          size: 40,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
