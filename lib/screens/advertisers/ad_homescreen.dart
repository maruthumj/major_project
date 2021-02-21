import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ad_homescreen extends StatefulWidget {
  ad_homescreen({Key key}) : super(key: key);

  @override
  _ad_homescreenState createState() => _ad_homescreenState();
}

class _ad_homescreenState extends State<ad_homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: Text("Hello world!"),
    )));
  }
}
