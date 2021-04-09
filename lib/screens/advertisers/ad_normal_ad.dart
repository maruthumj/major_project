import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui';
import 'dart:io';
import 'package:major_project/screens/advertisers/video_items.dart';
import 'package:video_player/video_player.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class ad_normal_ad extends StatefulWidget {
  ad_normal_ad({Key key}) : super(key: key);

  @override
  _ad_normal_adState createState() => _ad_normal_adState();
}

class _ad_normal_adState extends State<ad_normal_ad> {
  // VideoPlayerController _controller;

  TextEditingController num_of_ads = new TextEditingController();
  TextEditingController ad_quantity_controller = new TextEditingController();
  FirebaseAuth fauth = FirebaseAuth.instance;
  int max_num, max_ads1;
  int channel_max_num;
  String imageLink = '',
      Language = '',
      Weakly_viewers = '',
      Description = '',
      Category = '',
      Address = '';
  String timestamp;
  bool visibility = false;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseFirestore fstore = FirebaseFirestore.instance;
  int _myDoc;
  File _ad_video;
  String _videoLink;
  String cname, name, phonenum, emailid;
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
  int maxads;

  @override
  void initState() {
    super.initState();
    this.getchannelname();
    this.getimage();
    this.getadvertiserdeatils();
  }

  Future<void> getadvertiserdeatils() async {
    User fuser = fauth.currentUser;
    final _uid = fuser.uid;
    DocumentSnapshot documentSnapshot =
        await fstore.collection("advertisers_details").doc(_uid).get();
    this.setState(() {
      name = documentSnapshot.data()['Name'];
      emailid = documentSnapshot.data()['Email'];
      phonenum = documentSnapshot.data()['Phone'];
    });
  }

  Future<void> getchannelname() async {
    QuerySnapshot queryshot = await fstore
        .collection("Normal ads")
        .where("Channel name", isEqualTo: "$channel_name")
        .get();
    setState(() {
      queryshot.docs.forEach((doc) {
        imageLink = doc['image link'];

        print(imageLink);
      });
    });
  }

  Future<void> getimage() async {
    String imageLink = '';
  }

  Future getfeaturedads() async {
    FirebaseFirestore fstore1 = FirebaseFirestore.instance;
    QuerySnapshot qs = await fstore1.collection("Normal ads").get();

    return qs.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getfeaturedads(),
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
                  // maxads = int.parse(data['Maximum ads']);
                  //max_ads1 = int.parse(data['Maximum ads']);
                  return Container(
                    height: 900,
                    child: Card(
                      elevation: 5,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: IconButton(
                              icon: Icon(CupertinoIcons.info_circle_fill),
                              onPressed: () async {
                                cname = data['Channel name'];
                                QuerySnapshot queryDocumentSnapshot =
                                    await fstore
                                        .collection("tv_channel_details")
                                        .where("Channel name",
                                            isEqualTo: "$cname")
                                        .get();
                                setState(() {
                                  queryDocumentSnapshot.docs.forEach((doc) {
                                    imageLink = doc['image url'];
                                    Description = doc['Description'];
                                    Language = doc['Language'];
                                    Weakly_viewers = doc['Weekly Viewers'];
                                    Category = doc['Category'];
                                    Address = doc['Address'];
                                  });
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            contentPadding: EdgeInsets.all(0.0),
                                            content: Container(
                                                height: 600,
                                                width: 800,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: 70.0,
                                                      height: 70.0,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image:
                                                            new DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: NetworkImage(
                                                              imageLink),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        "Channel Name",
                                                        style: TextStyle(
                                                            color: CupertinoColors
                                                                .activeOrange),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        cname,
                                                        style: TextStyle(
                                                            color:
                                                                CupertinoColors
                                                                    .black),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        "Description",
                                                        style: TextStyle(
                                                            color: CupertinoColors
                                                                .activeOrange),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        Description,
                                                        style: TextStyle(
                                                            color:
                                                                CupertinoColors
                                                                    .black),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        "Category",
                                                        style: TextStyle(
                                                            color: CupertinoColors
                                                                .activeOrange),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        Category,
                                                        style: TextStyle(
                                                            color:
                                                                CupertinoColors
                                                                    .black),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        "Language",
                                                        style: TextStyle(
                                                            color: CupertinoColors
                                                                .activeOrange),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        Language,
                                                        style: TextStyle(
                                                            color:
                                                                CupertinoColors
                                                                    .black),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        "Weekly Viewers",
                                                        style: TextStyle(
                                                            color: CupertinoColors
                                                                .activeOrange),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        Weakly_viewers,
                                                        style: TextStyle(
                                                            color:
                                                                CupertinoColors
                                                                    .black),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        "Address",
                                                        style: TextStyle(
                                                            color: CupertinoColors
                                                                .activeOrange),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        Address,
                                                        style: TextStyle(
                                                            color:
                                                                CupertinoColors
                                                                    .black),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ));
                                  /* */
                                });
                              },
                            ),
                            /* */
                          ),
                          Text(
                            "Channel Name",
                            style:
                                TextStyle(color: CupertinoColors.activeOrange),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(data['Channel name']),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Starting Time",
                            style:
                                TextStyle(color: CupertinoColors.activeOrange),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(data['Timeline starting_time']),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "End Time",
                            style:
                                TextStyle(color: CupertinoColors.activeOrange),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(data['Timeline ending_time']),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Break Starting Time",
                            style:
                                TextStyle(color: CupertinoColors.activeOrange),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(data['Break starting_time']),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Break End Time",
                            style:
                                TextStyle(color: CupertinoColors.activeOrange),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(data['Break ending_time']),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Remaining ad Slots",
                            style:
                                TextStyle(color: CupertinoColors.activeOrange),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(data['Ad slots']),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Date",
                            style:
                                TextStyle(color: CupertinoColors.activeOrange),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(data['Date']),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Minimum Ad Length in Minutes",
                            style:
                                TextStyle(color: CupertinoColors.activeOrange),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(data['Ad minimum_length']),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Maximum Ad slots per user",
                            style:
                                TextStyle(color: CupertinoColors.activeOrange),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(data['Maximum ads']),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Available Ad slots",
                            style:
                                TextStyle(color: CupertinoColors.activeOrange),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(data['Ad slots']),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Price per second",
                            style:
                                TextStyle(color: CupertinoColors.activeOrange),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(data['price']),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Upload Ad Video",
                            style:
                                TextStyle(color: CupertinoColors.activeOrange),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: IconButton(
                                  color: CupertinoColors.activeBlue,
                                  icon: Icon(CupertinoIcons.cloud_upload_fill),
                                  onPressed: () async {
                                    _ad_video = await ImagePicker.pickVideo(
                                        source: ImageSource.gallery);
                                    FirebaseStorage fs =
                                        FirebaseStorage.instance;
                                    Reference rootReference = fs.ref();
                                    User fuser = fauth.currentUser;
                                    final email = fuser.email;
                                    Reference videoFolderReference =
                                        rootReference
                                            .child("normal ad videos")
                                            .child(data['Channel name'])
                                            .child(emailid)
                                            .child(data['Date'] +
                                                " " +
                                                data['Timeline starting_time'] +
                                                " - " +
                                                data['Timeline ending_time'] +
                                                data['Break starting_time'] +
                                                " - " +
                                                data['Break ending_time'])
                                            .child("ad");
                                    videoFolderReference
                                        .putFile(_ad_video)
                                        .then((storageTask) async {
                                      String link = (await videoFolderReference
                                              .getDownloadURL())
                                          .toString();

                                      print("uploaded");
                                      setState(() {
                                        _videoLink = link;
                                        print("Link " + _videoLink);
                                        visibility = false;
                                      });
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Offstage(
                                offstage: visibility,
                                child: Container(
                                  child: IconButton(
                                    icon: Icon(CupertinoIcons.play_circle_fill),
                                    color: CupertinoColors.activeBlue,
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => video_play(
                                                  value: _videoLink)));
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: CupertinoButton(
                              color: CupertinoColors.activeBlue,
                              child: Text("Advertise"),
                              onPressed: () {
                                showCupertinoDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) =>
                                      CupertinoAlertDialog(
                                    title: CupertinoTextField(
                                      placeholder: "Ad Quantity",
                                      keyboardType: TextInputType.number,
                                      controller: ad_quantity_controller,
                                    ),
                                    actions: [
                                      CupertinoDialogAction(
                                          child: Text(
                                            'Place ads',
                                            style: TextStyle(
                                                color:
                                                    CupertinoColors.activeBlue),
                                          ),
                                          onPressed: () async {
                                            max_num = int.parse(
                                                ad_quantity_controller.text);

                                            await fstore
                                                .collection(
                                                    "normal_ad_request{" +
                                                        data['Channel name'] +
                                                        "}")
                                                .add({
                                              "ad_quantity":
                                                  ad_quantity_controller.text,
                                              "sender": name,
                                              "receiver": data['Channel name'],
                                              "sender_email": emailid,
                                              "sender_phone": phonenum,
                                              "timeline": data[
                                                      'Timeline starting_time'] +
                                                  " - " +
                                                  data['Timeline ending_time'],
                                              "break_time":
                                                  data['Break starting_time'] +
                                                      " - " +
                                                      data['Break ending_time'],
                                              "date": data['Date'],
                                              "link": _videoLink,
                                              "Ad slots": data['Ad slots'],
                                              "price": data['price'],
                                            });
                                            ad_quantity_controller.clear();
                                            Navigator.pop(context, false);
                                          }),
                                      CupertinoDialogAction(
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                              color: CupertinoColors.systemRed),
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
                },
              );
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
