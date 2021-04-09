import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:major_project/screens/tv_channel/video_items.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'dart:io';

class dashboard_featured_ad extends StatefulWidget {
  dashboard_featured_ad({Key key}) : super(key: key);

  @override
  _dashboard_featured_adState createState() => _dashboard_featured_adState();
}

class _dashboard_featured_adState extends State<dashboard_featured_ad> {
  FirebaseAuth fauth = FirebaseAuth.instance;
  String timestamp;
  FirebaseFirestore fstore = FirebaseFirestore.instance;
  TextEditingController _declineController = new TextEditingController();
  TextEditingController _acceptController = new TextEditingController();
  String channel_name = '';
  String starting_time = '',
      ending_time = '',
      break_starting_time = '',
      break_ending_time = '',
      price_per_second = '',
      adlength = '',
      adslots = '',
      date = '';
  int num1;

  int _myDoc;
  @override
  void initState() {
    super.initState();
    this.getchannelname();
  }

  Future<void> getchannelname() async {
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

  Future getadrequest() async {
    FirebaseFirestore fstore1 = FirebaseFirestore.instance;
    QuerySnapshot qs =
        await fstore1.collection("featured_ad_request{$channel_name}").get();

    return qs.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getadrequest(),
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
                            Container(
                              child: IconButton(
                                  icon: Icon(
                                    CupertinoIcons.info_circle_fill,
                                    color: CupertinoColors.activeBlue,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        barrierDismissible: true,
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0))),
                                              contentPadding:
                                                  EdgeInsets.all(0.0),
                                              content: Container(
                                                  height: 200,
                                                  width: 800,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          "NAME",
                                                          style: TextStyle(
                                                              color: CupertinoColors
                                                                  .activeOrange),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          data['sender'],
                                                          style: TextStyle(
                                                              color: CupertinoColors
                                                                  .activeBlue),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          "Email Address",
                                                          style: TextStyle(
                                                              color: CupertinoColors
                                                                  .activeOrange),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          data['sender_email'],
                                                          style: TextStyle(
                                                              color: CupertinoColors
                                                                  .activeBlue),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          "Phone Number",
                                                          style: TextStyle(
                                                              color: CupertinoColors
                                                                  .activeOrange),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          data['sender_phone'],
                                                          style: TextStyle(
                                                              color: CupertinoColors
                                                                  .activeBlue),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  )),
                                            ));
                                  }),
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
                              height: 5,
                            ),
                            Text(
                              "Time Line",
                              style: TextStyle(
                                  color: CupertinoColors.activeOrange),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(data['timeline']),
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
                            Text(data['ad_quantity']),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Available slots",
                              style: TextStyle(
                                  color: CupertinoColors.activeOrange),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(data['Ad slots']),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Price per Second",
                              style: TextStyle(
                                  color: CupertinoColors.activeOrange),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(data['price']),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    "Play Video",
                                    style: TextStyle(
                                        color: CupertinoColors.activeBlue),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                IconButton(
                                  color: CupertinoColors.activeBlue,
                                  icon: Icon(
                                    CupertinoIcons.play_circle_fill,
                                  ),
                                  onPressed: () async {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => video_play(
                                                value: data['link'])));
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: CupertinoButton(
                                color: CupertinoColors.activeGreen,
                                child: Text("Accept"),
                                onPressed: () {
                                  showCupertinoDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) =>
                                        CupertinoAlertDialog(
                                      title: Text('Are you sure?'),
                                      actions: [
                                        CupertinoDialogAction(
                                            child: Text(
                                              'Yes',
                                              style: TextStyle(
                                                  color: CupertinoColors
                                                      .activeBlue),
                                            ),
                                            onPressed: () async {
                                              await fstore
                                                  .collection(
                                                      "featured ad response{" +
                                                          data['sender_email'] +
                                                          "}" +
                                                          " approved")
                                                  .add({
                                                "status": "Approved!",
                                                "channel name": channel_name,
                                                "timeline": data['timeline'],
                                                "date": data['date'],
                                                "quantity": data['ad_quantity'],
                                                "price": data['price']
                                              });
                                              Navigator.pop(context, false);
                                            }),
                                        CupertinoDialogAction(
                                          child: Text(
                                            'No',
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
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              child: CupertinoButton(
                                color: CupertinoColors.systemRed,
                                child: Text("Decline"),
                                onPressed: () {
                                  showCupertinoDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) =>
                                        CupertinoAlertDialog(
                                      title: Text(
                                          'Please Send a reason message to the Advertiser!'),
                                      content: CupertinoTextField(
                                        controller: _declineController,
                                      ),
                                      actions: [
                                        CupertinoDialogAction(
                                            child: Text(
                                              'Send',
                                              style: TextStyle(
                                                  color: CupertinoColors
                                                      .activeBlue),
                                            ),
                                            onPressed: () async {
                                              await fstore
                                                  .collection(
                                                      "featured ad response{" +
                                                          data['sender_email'] +
                                                          "}" +
                                                          " declined")
                                                  .add({
                                                "status": "declined!",
                                                "reason":
                                                    _declineController.text,
                                                "channel name": channel_name,
                                                "timeline": data['timeline'],
                                                "date": data['date'],
                                                "quantity": data['ad_quantity'],
                                                "price": data['price']
                                              });
                                              Navigator.pop(context, false);
                                            }),
                                        CupertinoDialogAction(
                                          child: Text(
                                            'Cancel',
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
                            SizedBox(
                              height: 30,
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

class video_play extends StatefulWidget {
  String value;
  video_play({this.value});

  @override
  _video_playState createState() => _video_playState(value);
}

class _video_playState extends State<video_play> {
  String value;
  _video_playState(this.value);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
        automaticallyImplyLeading: false,
        title: Text(
          'Video Ad',
          style: TextStyle(color: CupertinoColors.activeBlue),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(CupertinoIcons.chevron_back),
          color: CupertinoColors.activeBlue,
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          VideoItems(
            videoPlayerController: VideoPlayerController.network(value),
            looping: false,
            autoplay: false,
          ),
        ],
      ),
    );
  }
}
