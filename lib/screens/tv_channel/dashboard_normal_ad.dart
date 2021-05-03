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
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:random_string/random_string.dart';
import 'dart:math' show Random;

class dashboard_normal_ad extends StatefulWidget {
  dashboard_normal_ad({Key key}) : super(key: key);

  @override
  _dashboard_normal_adState createState() => _dashboard_normal_adState();
}

class _dashboard_normal_adState extends State<dashboard_normal_ad> {
  FirebaseAuth fauth = FirebaseAuth.instance;
  String timestamp;
  var dio = Dio();
  FirebaseFirestore fstore = FirebaseFirestore.instance;
  TextEditingController _declineController = new TextEditingController();
  TextEditingController _acceptController = new TextEditingController();
  int total_price;
  String inc, inc2;
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
  int list_length = 0;
  int int_price_per_second, int_duration;
  int ii = 0, jj = 0;
  int _myDoc;
  String duration;
  @override
  void initState() {
    super.initState();
    this.getchannelname();
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
        await fstore1.collection("normal_ad_request{$channel_name}").get();

    return qs.docs;
  }

  void _requestDownload(String link) async {}

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
                    var lst = new List();

                    DocumentSnapshot data = snapshot.data[index];

                    int_price_per_second = int.parse(data['ad_quantity']) *
                        int.parse(data['price']);
                    VideoPlayerController _vdo =
                        new VideoPlayerController.network(data['link']);
                    _vdo.initialize().then((_) {
                      duration = _vdo.value.duration.inSeconds.toString();

                      total_price =
                          _vdo.value.duration.inSeconds * int_price_per_second;
                      inc = total_price.toString();
                    });

                    return Container(
                      height: 610,
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

                              /* */
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
                              "Break Time",
                              style: TextStyle(
                                  color: CupertinoColors.activeOrange),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(data['break_time']),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 50,
                                ),
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
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  child: Text(
                                    "Download Video",
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
                                    CupertinoIcons.arrow_down_circle_fill,
                                  ),
                                  onPressed: () async {
                                    await _launchURL(data['link']);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Video length",
                              style: TextStyle(
                                  color: CupertinoColors.activeOrange),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(duration + " Seconds"),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Total Price",
                              style: TextStyle(
                                  color: CupertinoColors.activeOrange),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(inc),
                            SizedBox(
                              height: 5,
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
                                                      "normal ad response{" +
                                                          data['sender_email'] +
                                                          "}" +
                                                          " approved")
                                                  .add({
                                                "status": "Approved!",
                                                "channel name": channel_name,
                                                "timeline": data['timeline'],
                                                "break_time":
                                                    data['break_time'],
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
                                                      "normal ad response{" +
                                                          data['sender_email'] +
                                                          "}" +
                                                          " declined")
                                                  .add({
                                                "status": "declined!",
                                                "reason":
                                                    _declineController.text,
                                                "channel name": channel_name,
                                                "timeline": data['timeline'],
                                                "break_time":
                                                    data['break_time'],
                                                "date": data['date'],
                                                "quantity": data['ad_quantity'],
                                                "price": total_price.toString(),
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
