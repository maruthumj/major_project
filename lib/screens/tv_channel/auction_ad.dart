import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui';
import 'dart:io';
import 'package:major_project/screens/tv_channel/loginscreen.dart';
import 'package:date_time_picker/date_time_picker.dart';

class auction_ad extends StatefulWidget {
  @override
  _auction_adState createState() => _auction_adState();
}

class _auction_adState extends State<auction_ad> {
  int num = 0;
  int _selectedValue = 1;
  var s;
  int adnum;
  DateTime _dateTime = DateTime.now();
  String text = "no value Entered";
  String title;
  List dropdownlist = ["AM", "PM"];
  List dropdownlist2 = ["AM", "PM"];
  List dropdownlist3 = ["AM", "PM"];
  List dropdownlist4 = ["AM", "PM"];
  String val1;
  List maximum_ads = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  String valueChooser, valueChooser2, valueChooser3, valueChooser4;
  int max_ad_chooser;

  FirebaseAuth fauth = FirebaseAuth.instance;
  FirebaseFirestore fstore = FirebaseFirestore.instance;
  TextEditingController _controller;
  TextEditingController _noOfTimelineController = new TextEditingController();
  TextEditingController _auctiontimerController = new TextEditingController();
  TextEditingController _basepriceController = new TextEditingController();
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
  TextEditingController _endingtimeanddateController =
      new TextEditingController();
  int noOfTimeline = 0;
  final form = GlobalKey<FormState>();
  int _value = 1;
  String channel_name;

  @override
  void initState() {
    super.initState();
    // this.getemailid();
  }

  Future getemailid() async {
    User fuser = fauth.currentUser;
    final _uid = fuser.uid;
    QuerySnapshot queryDocumentSnapshot = await fstore
        .collection("tv_channel_details")
        .where("uid", isEqualTo: "$_uid")
        .get();
    setState(() {
      queryDocumentSnapshot.docs.forEach((doc) {
        channel_name = doc['Channel name'];

        print(channel_name);
      });
    });
  }

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
          "              Auction Ad",
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
                        initialDateTime: _dateTime,
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
                      ),
                    ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Break Time",
                      style: TextStyle(
                          color: CupertinoColors.activeOrange,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      child: CupertinoTextField(
                        placeholder: "Starting Time",
                        controller: _breakstartingtimeController1,
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      width: 50,
                      child: DropdownButton(
                        value: valueChooser3,
                        onChanged: (newvalue) {
                          setState(() {
                            valueChooser3 = newvalue;
                          });
                        },
                        items: dropdownlist3.map((valueItem) {
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
                        controller: _breakendtimeController1,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      width: 50,
                      child: DropdownButton(
                        value: valueChooser4,
                        onChanged: (newvalue) {
                          setState(() {
                            valueChooser4 = newvalue;
                          });
                        },
                        items: dropdownlist4.map((valueItem) {
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
                          placeholder: "Ad Slot number",
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
                          placeholder: "Minimum ad Video Length(mins)",
                          keyboardType: TextInputType.number,
                          controller: _minimumadlengthController,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 250,
                        child: CupertinoTextField(
                          placeholder: "Base price",
                          keyboardType: TextInputType.number,
                          controller: _basepriceController,
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
                          placeholder: "Auction Ending date and time",
                          keyboardType: TextInputType.datetime,
                          controller: _endingtimeanddateController,
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
                          placeholder: "Auction Timer",
                          keyboardType: TextInputType.number,
                          controller: _auctiontimerController,
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
                      int mxnum = _selectedValue + 1;
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
                                      .collection("Auction ads{$channel_name}")
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
                                    "Break starting_time":
                                        _breakstartingtimeController1.text +
                                            "" +
                                            valueChooser3,
                                    "Break ending_time":
                                        _breakendtimeController1.text +
                                            "" +
                                            valueChooser4,
                                    "Ad_slot number": _adslotsController.text,
                                    "Ad minimum_length":
                                        _minimumadlengthController.text,
                                    "Channel name": channel_name,
                                    "Maximum ads": mxnum,
                                    "base price": _basepriceController.text,
                                    "auction timer":
                                        _auctiontimerController.text,
                                    "ending_date_time":
                                        _endingtimeanddateController.text,
                                  });

                                  await fstore.collection("Auction ads").add({
                                    "Date": s,
                                    "Timeline starting_time":
                                        _startingtimeController1.text +
                                            "" +
                                            valueChooser,
                                    "Timeline ending_time":
                                        _endtimeController1.text +
                                            "" +
                                            valueChooser2,
                                    "Break starting_time":
                                        _breakstartingtimeController1.text +
                                            "" +
                                            valueChooser3,
                                    "Break ending_time":
                                        _breakendtimeController1.text +
                                            "" +
                                            valueChooser4,
                                    "Ad_slot number": _adslotsController.text,
                                    "Ad minimum_length":
                                        _minimumadlengthController.text,
                                    "Channel name": channel_name,
                                    "Maximum ads": mxnum,
                                    "base price": _basepriceController.text,
                                    "auction timer":
                                        _auctiontimerController.text,
                                    "ending_date_time":
                                        _endingtimeanddateController.text,
                                  });
                                  setState(() {
                                    _breakendtimeController1.clear();
                                    _breakstartingtimeController1.clear();
                                    _adslotsController.clear();
                                    _minimumadlengthController.clear();

                                    Navigator.pop(context, false);
                                  });
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
