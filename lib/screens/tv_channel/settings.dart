import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class settings extends StatefulWidget {
  settings({Key key}) : super(key: key);

  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Stack(
        children: [
          Column(
            children: [],
          ),
        ],
      )),
    );
  }
}
