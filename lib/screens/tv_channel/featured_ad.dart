import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

import 'dart:ui';
import 'dart:io';

class featured_ad extends StatefulWidget {
  featured_ad({Key key}) : super(key: key);

  @override
  _featured_adState createState() => _featured_adState();
}

class _featured_adState extends State<featured_ad> {
  int noOfTimeline = 0;
  final form = GlobalKey<FormState>();
  int _value = 1;
  String s;
  var d;
  String channel_name;
  int num = 0;
  int adnum;
  String date;
  DateTime _dateTime = DateTime.now();
  String text = "no value Entered";
  String title;
  List dropdownlist = ["AM", "PM"];
  List dropdownlist2 = ["AM", "PM"];
  List dropdownlist3 = ["AM", "PM"];
  List dropdownlist4 = ["AM", "PM"];
  String valueChooser, valueChooser2, valueChooser3, valueChooser4;

  FirebaseAuth fauth = FirebaseAuth.instance;
  FirebaseFirestore fstore = FirebaseFirestore.instance;
  TextEditingController _controller;

  TextEditingController _noOfTimelineController = new TextEditingController();
  TextEditingController _pricepersecondController = new TextEditingController();
  TextEditingController _noOfadbreakController = new TextEditingController();
  TextEditingController _startingtimeController1 = new TextEditingController();
  TextEditingController _endtimeController1 = new TextEditingController();
  TextEditingController _breakstartingtimeController1 =
      new TextEditingController();
  TextEditingController _breakendtimeController1 = new TextEditingController();
  TextEditingController _priceController1 = new TextEditingController();
  TextEditingController _adslotsController = new TextEditingController();
  TextEditingController _minimumadlengthController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      appBar: AppBar(
        backgroundColor: CupertinoColors.lightBackgroundGray,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.chevron_back,
            color: CupertinoColors.activeBlue,
          ),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        title: Text(
          "         Featured Ad",
          style: TextStyle(color: CupertinoColors.activeBlue),
        ),
      ),
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
                          color: CupertinoColors.activeOrange,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
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
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (dateTime) {
                          print(dateTime);
                          _dateTime = dateTime;

                          setState(() {
                            s = DateFormat('dd-MM-yyyy').format(_dateTime);
                            print(s);
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        "Timeline",
                        style: TextStyle(
                            color: CupertinoColors.activeOrange,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      child: CupertinoTextField(
                        placeholder: "Starting Time",
                        controller: _startingtimeController1,
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      width: 50,
                      child: DropdownButton(
                        value: valueChooser,
                        onChanged: (newvalue) {
                          setState(() {
                            valueChooser = newvalue;
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
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        width: 200,
                        child: CupertinoTextField(
                          placeholder: "End Time",
                          controller: _endtimeController1,
                          keyboardType: TextInputType.datetime,
                        )),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      width: 50,
                      child: DropdownButton(
                        value: valueChooser2,
                        onChanged: (newvalue) {
                          setState(() {
                            valueChooser2 = newvalue;
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
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 250,
                        child: CupertinoTextField(
                          placeholder: "Ad Slots",
                          keyboardType: TextInputType.number,
                          controller: _adslotsController,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 250,
                        child: CupertinoTextField(
                          placeholder: "Total ad Video Length",
                          keyboardType: TextInputType.text,
                          controller: _minimumadlengthController,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 250,
                        child: CupertinoTextField(
                          placeholder: "Price per Second",
                          keyboardType: TextInputType.text,
                          controller: _pricepersecondController,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: CupertinoButton(
                    child: Text(
                      "Generate Ad Slots",
                    ),
                    color: CupertinoColors.activeBlue,
                    onPressed: () {
                      showCupertinoDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) => CupertinoAlertDialog(
                          content: Text("Are you sure to generate ad slots?"),
                          actions: [
                            CupertinoDialogAction(
                                child: Text("Yes"),
                                onPressed: () async {
                                  User fuser = fauth.currentUser;
                                  final _uid = fuser.uid;
                                  QuerySnapshot queryDocumentSnapshot =
                                      await fstore
                                          .collection("tv_channel_details")
                                          .where("uid", isEqualTo: "$_uid")
                                          .get();
                                  setState(() {
                                    queryDocumentSnapshot.docs.forEach((doc) {
                                      channel_name = doc['Channel name'];

                                      print(channel_name);
                                    });
                                  });

                                  await fstore
                                      .collection("Featured ads{$channel_name}")
                                      .add({
                                    "Date": s,
                                    "Timeline starting_time":
                                        _startingtimeController1.text +
                                            "" +
                                            valueChooser,
                                    "Timeline ending_time":
                                        _endtimeController1.text +
                                            "" +
                                            valueChooser2,
                                    "Ad slots": _adslotsController.text,
                                    "Ad minimum_length":
                                        _minimumadlengthController.text,
                                    "Channel name": channel_name,
                                    "price": _pricepersecondController.text,
                                  });

                                  await fstore.collection("Featured ads").add({
                                    "Date": s,
                                    "Timeline starting_time":
                                        _startingtimeController1.text +
                                            "" +
                                            valueChooser,
                                    "Timeline ending_time":
                                        _endtimeController1.text +
                                            "" +
                                            valueChooser2,
                                    "Ad slots": _adslotsController.text,
                                    "Ad minimum_length":
                                        _minimumadlengthController.text,
                                    "Channel name": channel_name,
                                    "price": _pricepersecondController.text,
                                  });

                                  _adslotsController.clear();
                                  _minimumadlengthController.clear();
                                  Navigator.pop(context, false);
                                }),
                            CupertinoDialogAction(
                              child: Text(
                                "Cancel",
                                style:
                                    TextStyle(color: CupertinoColors.systemRed),
                              ),
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
