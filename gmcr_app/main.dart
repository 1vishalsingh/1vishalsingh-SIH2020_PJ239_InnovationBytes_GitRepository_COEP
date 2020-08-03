import 'package:flutter/material.dart';
import 'package:gmcr_app/CheckPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CheckPage(),
    );
  }
}
