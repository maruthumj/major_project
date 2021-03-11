import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:major_project/screens/tv_channel/normal_ad.dart';
import 'package:major_project/screens/tv_channel/featured_ad.dart';

class create extends StatefulWidget {
  create({Key key}) : super(key: key);

  @override
  _createState createState() => _createState();
}

class _createState extends State<create> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 280,
                    ),
                    Container(
                      child: CupertinoButton(
                        color: CupertinoColors.activeBlue,
                        child: Text("Normal Ad"),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => normal_ad()));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      child: CupertinoButton(
                        color: CupertinoColors.activeBlue,
                        child: Text("Featured Ad"),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => featured_ad()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
