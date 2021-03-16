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
import 'package:better_player/better_player.dart';

class ad_normal_ad extends StatefulWidget {
  ad_normal_ad({Key key}) : super(key: key);

  @override
  _ad_normal_adState createState() => _ad_normal_adState();
}

class _ad_normal_adState extends State<ad_normal_ad> {
  // VideoPlayerController _controller;
  FirebaseAuth fauth = FirebaseAuth.instance;
  String imageLink = '',
      Language = '',
      Weakly_viewers = '',
      Description = '',
      Category = '',
      Address = '';
  String timestamp;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseFirestore fstore = FirebaseFirestore.instance;
  int _myDoc;
  File _ad_video;
  String _videoLink;
  String cname;
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

  @override
  void initState() {
    super.initState();
    this.getchannelname();
    this.getimage();
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
                  return Container(
                    height: 800,
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
                          Text(data['Break starting_time']),
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
                          Container(
                            child: CupertinoButton(
                              color: CupertinoColors.activeBlue,
                              child: Text("upload ad video"),
                              onPressed: () async {
                                _ad_video = await ImagePicker.pickVideo(
                                    source: ImageSource.gallery);
                                FirebaseStorage fs = FirebaseStorage.instance;
                                Reference rootReference = fs.ref();
                                User fuser = fauth.currentUser;
                                final email = fuser.email;
                                Reference videoFolderReference = rootReference
                                    .child("normal ad videos")
                                    .child(cname)
                                    .child(email)
                                    .child(date +
                                        " " +
                                        starting_time +
                                        " " +
                                        ending_time +
                                        " " +
                                        break_starting_time +
                                        " " +
                                        break_ending_time)
                                    .child("ad");
                                videoFolderReference
                                    .putFile(_ad_video)
                                    .then((storageTask) async {
                                  String link =
                                      await storageTask.ref.getDownloadURL();
                                  print("uploaded");
                                  setState(() {
                                    _videoLink = link;
                                  });
                                  print("Link " + _videoLink);
                                });
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
