import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:catcher/catcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:major_project/screens/advertisers/ad_login.dart';
import 'package:major_project/screens/advertisers/ad_profile.dart';
import 'package:major_project/screens/advertisers/ad_homespage.dart';
import 'package:major_project/screens/advertisers/ad_dashboard.dart';

class ad_homescreen extends StatefulWidget {
  ad_homescreen({Key key}) : super(key: key);

  @override
  _ad_homescreenState createState() => _ad_homescreenState();
}

class _ad_homescreenState extends State<ad_homescreen> {
  FirebaseAuth fauth = FirebaseAuth.instance;
  FirebaseFirestore fstore = FirebaseFirestore.instance;
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    homespage(),
    dashboard(),
    ad_profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Online Marketplace for TV ads',
            style: TextStyle(color: CupertinoColors.activeBlue),
          ),
          backgroundColor: CupertinoColors.extraLightBackgroundGray),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.home,
              ),
              title: Text(
                "Home",
              )),
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.gauge,
              ),
              title: Text(
                "Dashboard",
              )),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person),
              title: Text(
                "Profile",
              )),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: CupertinoColors.systemGrey,
        selectedItemColor: CupertinoColors.activeBlue,
        onTap: _onItemTapped,
      ),
    );
  }
}
