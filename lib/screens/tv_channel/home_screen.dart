import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:blur_bottom_bar/blur_bottom_bar.dart';
import 'package:major_project/screens/tv_channel/loginscreen.dart';

import 'package:major_project/screens/tv_channel/homespage.dart';
import 'package:major_project/screens/tv_channel/profile.dart';
import 'package:major_project/screens/tv_channel/create.dart';
import 'package:flutter/src/rendering/box.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    homespage(),
    create(),
    Text('Search Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.home,
              ),
              label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.add_circled_solid),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.gauge,
            ),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person), label: "Profile"),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: CupertinoColors.systemGrey,
        selectedItemColor: CupertinoColors.activeBlue,
        onTap: _onItemTapped,
      ),
    );
  }
}
