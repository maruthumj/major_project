import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:major_project/screens/advertisers/dashboard_auction_ad_approved.dart';
import 'package:major_project/screens/advertisers/dashboard_auction_ad_declined.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'dart:io';

class bidding extends StatefulWidget {
  bidding({Key key}) : super(key: key);

  @override
  _biddingState createState() => _biddingState();
}

class _biddingState extends State<bidding> {
  bool visibility;
  FirebaseAuth fauth = FirebaseAuth.instance;
  String timestamp;
  FirebaseFirestore fstore = FirebaseFirestore.instance;
  TextEditingController _declineController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();
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
  String amt;
  @override
  void initState() {
    super.initState();
    this.biddata();
  }

  Future<void> biddata() async {
    QuerySnapshot queryDocumentSnapshot =
        await fstore.collection("last bidder").get();
    setState(() {
      queryDocumentSnapshot.docs.forEach((doc) {
        amt = doc['value'];
      });
    });
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
          "Bidding",
          style: TextStyle(color: CupertinoColors.activeBlue),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(CupertinoIcons.refresh_circled_solid),
                        onPressed: () async {
                          biddata();
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Latest Bidding amount",
                  style: TextStyle(color: CupertinoColors.activeOrange),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(amt),
                SizedBox(
                  height: 5,
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
                          controller: _priceController,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: CupertinoButton(
                    child: Text("Pay"),
                    color: CupertinoColors.activeBlue,
                    onPressed: () async {
                      await fstore
                          .collection("users")
                          .doc()
                          .update({"value": _priceController.text}).then((_) {
                        print("success!");
                      });
                      biddata();
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
