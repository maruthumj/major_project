import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class homespage extends StatefulWidget {
  homespage({Key key}) : super(key: key);

  @override
  _homespageState createState() => _homespageState();
}

class _homespageState extends State<homespage> {
  DateTime _dateTime = DateTime.now();
  List dropdownlist = ["AM", "PM"];
  List dropdownlist2 = ["AM", "PM"];
  String valueChooser, valueChooser2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "TimeLine Date",
                      style: TextStyle(
                          color: CupertinoColors.activeOrange, fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 350,
                      child: CupertinoDatePicker(
                        backgroundColor: CupertinoColors.white,
                        initialDateTime: _dateTime,
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (dateTime) {
                          print(dateTime);
                          setState(() {
                            _dateTime = dateTime;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getListview() {
    DateTime _dateTime = DateTime.now();
    List dropdownlist = ["AM", "PM"];
    List dropdownlist2 = ["AM", "PM"];
    String valueChooser, valueChooser2;
    var listview = ListView(
      children: [
        Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 30,
                width: 30,
                child: TextFormField(
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
    return listview;
  }
}

class homespage1 extends StatefulWidget {
  homespage1({Key key}) : super(key: key);

  @override
  _homespage1State createState() => _homespage1State();
}

class _homespage1State extends State<homespage> {
  DateTime _dateTime = DateTime.now();
  List dropdownlist = ["AM", "PM"];
  List dropdownlist2 = ["AM", "PM"];
  String valueChooser, valueChooser2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "TimeLine Date",
                      style: TextStyle(
                          color: CupertinoColors.activeOrange, fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 350,
                      child: CupertinoDatePicker(
                        backgroundColor: CupertinoColors.white,
                        initialDateTime: _dateTime,
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (dateTime) {
                          print(dateTime);
                          setState(() {
                            _dateTime = dateTime;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Time",
                            style: TextStyle(
                                fontSize: 18,
                                color: CupertinoColors.activeOrange),
                          ),
                          Text(
                            "         Price/Second",
                            style: TextStyle(
                                fontSize: 18,
                                color: CupertinoColors.activeOrange),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                child: TextFormField(
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(),
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                width: 40,
                                height: 30,
                                child: DropdownButton(
                                  icon: Icon(CupertinoIcons.chevron_down),
                                  iconEnabledColor: CupertinoColors.activeBlue,
                                  iconSize: 10,
                                  value: valueChooser,
                                  onChanged: (newValue) {
                                    setState(() {
                                      valueChooser = newValue;
                                    });
                                  },
                                  items: dropdownlist.map((valueItem) {
                                    return DropdownMenuItem(
                                      value: valueItem,
                                      child: Text(valueItem),
                                    );
                                  }).toList(),
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                height: 20,
                                width: 20,
                                child: Text(
                                  "to",
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                height: 30,
                                width: 30,
                                child: TextFormField(
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(),
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 30,
                                child: DropdownButton(
                                  icon: Icon(CupertinoIcons.chevron_down),
                                  iconEnabledColor: CupertinoColors.activeBlue,
                                  iconSize: 10,
                                  value: valueChooser2,
                                  onChanged: (newValue) {
                                    setState(() {
                                      valueChooser2 = newValue;
                                    });
                                  },
                                  items: dropdownlist2.map((valueItem) {
                                    return DropdownMenuItem(
                                      value: valueItem,
                                      child: Text(valueItem),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
