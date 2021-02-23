import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:catcher/catcher.dart';

void main() {
  final debugOptions = CatcherOptions(DialogReportMode(), [
    ConsoleHandler(),
  ]);

  Catcher(
    rootWidget: ad_homescreen(),
    debugConfig: debugOptions,
    enableLogger: false,
  );
}

class ad_homescreen extends StatefulWidget {
  ad_homescreen({Key key}) : super(key: key);

  @override
  _ad_homescreenState createState() => _ad_homescreenState();
}

class _ad_homescreenState extends State<ad_homescreen> {
  int _currentindex = 0;

  final List tabs = [
    Center(child: Text("home")),
    Center(child: Text("Settings")),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: tabs[_currentindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            title: Text("Home"),
            backgroundColor: Colors.grey.shade400.withOpacity(0.5),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.plus_circle),
            title: Text("Add"),
            backgroundColor: Colors.grey.shade400.withOpacity(0.5),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentindex = index;
          });
        },
      ),
    );
  }
}

class ad_home extends StatefulWidget {
  ad_home({Key key}) : super(key: key);

  @override
  _ad_homeState createState() => _ad_homeState();
}

class _ad_homeState extends State<ad_home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
