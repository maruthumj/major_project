import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:major_project/screens/advertisers/dashboard_featured_ad_approved.dart';
//import 'package:major_project/screens/advertisers/dashboard_featured_ad_declined.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'dart:io';

class dashboard_featured_ad_approved extends StatefulWidget {
  dashboard_featured_ad_approved({Key key}) : super(key: key);

  @override
  _dashboard_featured_ad_approvedState createState() =>
      _dashboard_featured_ad_approvedState();
}

class _dashboard_featured_ad_approvedState
    extends State<dashboard_featured_ad_approved> {
  bool visibility;
  int price1, ads;
  int total;
  FirebaseAuth fauth = FirebaseAuth.instance;
  String timestamp;
  FirebaseFirestore fstore = FirebaseFirestore.instance;
  TextEditingController _declineController = new TextEditingController();
  TextEditingController _acceptController = new TextEditingController();
  String channel_name = '';
  String sts;
  String starting_time = '',
      ending_time = '',
      break_starting_time = '',
      break_ending_time = '',
      price_per_second = '',
      adlength = '',
      adslots = '',
      date = '';
  int num1;
  String emailid;
  int _myDoc;
  @override
  void initState() {
    super.initState();

    this.getadvertiseremail();
    this.getapprovalrequest();
  }

  Future<void> getadvertiseremail() async {
    User fuser = fauth.currentUser;
    emailid = fuser.email.toString();

    setState(() {
      print(emailid);
    });
  }

  Future getapprovalrequest() async {
    FirebaseFirestore fstore1 = FirebaseFirestore.instance;
    QuerySnapshot qs = await fstore1
        .collection("featured ad response{$emailid} approved")
        .get();

    return qs.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
        leading: IconButton(
          color: CupertinoColors.activeBlue,
          icon: Icon(CupertinoIcons.chevron_back),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        centerTitle: true,
        title: Text(
          "Approved Ads",
          style: TextStyle(color: CupertinoColors.activeBlue),
        ),
      ),
      body: FutureBuilder(
          future: getapprovalrequest(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Loading...."),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    DocumentSnapshot data = snapshot.data[index];
                    return Container(
                      height: 500,
                      child: Card(
                        elevation: 5,
                        child: Column(
                          children: [
                            Text(
                              "Status",
                              style: TextStyle(
                                  color: CupertinoColors.activeOrange),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(data['status']),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "channel name",
                              style: TextStyle(
                                  color: CupertinoColors.activeOrange),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(data['channel name']),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Ad Quantity",
                              style: TextStyle(
                                  color: CupertinoColors.activeOrange),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(data['quantity']),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Date",
                              style: TextStyle(
                                  color: CupertinoColors.activeOrange),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(data['date']),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Timeline",
                              style: TextStyle(
                                  color: CupertinoColors.activeOrange),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(data['timeline']),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: CupertinoButton(
                                child: Text("Pay"),
                                color: CupertinoColors.activeBlue,
                                onPressed: () async {
                                  price1 = int.parse(data['price']);
                                  ads = int.parse(data['quantity']);
                                  total = price1 * ads;
                                  showCupertinoDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) =>
                                        CupertinoAlertDialog(
                                      content: Text("$total"),
                                      actions: [
                                        CupertinoDialogAction(
                                            child: Text("pay"),
                                            onPressed: () async {
                                              Navigator.pop(context, false);
                                            }),
                                        CupertinoDialogAction(
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                                color:
                                                    CupertinoColors.systemRed),
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
                      ),
                    );
                  });
            }
          }),
    );
  }
}
