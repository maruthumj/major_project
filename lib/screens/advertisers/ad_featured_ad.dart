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

class ad_featured_ad extends StatefulWidget {
  ad_featured_ad({Key key}) : super(key: key);

  @override
  _ad_featured_adState createState() => _ad_featured_adState();
}

class _ad_featured_adState extends State<ad_featured_ad> {
  File _ad_video;
  String _videoLink;
  String cname;

  String imageLink = '',
      Language = '',
      Weakly_viewers = '',
      Description = '',
      Category = '',
      Address = '';
  FirebaseAuth fauth = FirebaseAuth.instance;
  String timestamp;
  FirebaseFirestore fstore = FirebaseFirestore.instance;
  int _myDoc;
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
  String link1 = " ";
  @override
  void initState() {
    super.initState();
    if (_videoLink != null) {
      link1 = _videoLink;
    }
  }

  Future getfeaturedads() async {
    FirebaseFirestore fstore1 = FirebaseFirestore.instance;
    QuerySnapshot qs = await fstore1.collection("Featured ads").get();

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
                    height: 500,
                    child: Card(
                      elevation: 5,
                      child: Column(
                        children: [
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
                          Text(
                            "Minimum Ad Length in Minutes",
                            style:
                                TextStyle(color: CupertinoColors.activeOrange),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(data['Ad minimum_length']),
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
                                    .child("featured ad videos")
                                    .child(cname)
                                    .child(email)
                                    .child(date +
                                        " " +
                                        starting_time +
                                        " " +
                                        ending_time)
                                    .child("ad");
                                videoFolderReference
                                    .putFile(_ad_video)
                                    .then((storageTask) async {
                                  String link =
                                      await storageTask.ref.getDownloadURL();
                                  print("uploaded");
                                  setState(() async {
                                    _videoLink = link;
                                    CollectionReference normal_ad_collection =
                                        FirebaseFirestore.instance.collection(
                                            "featured_ad_video{$cname}");

                                    await normal_ad_collection.add({
                                      'video_link': _videoLink,
                                      'sender': email,
                                      'date': date,
                                      'timeline starting_time': starting_time,
                                      'timeline ending_time': ending_time,
                                    }).then((value) {
                                      print("channel added");
                                    }).catchError((error) {
                                      return "Failed to create Channel: $error";
                                    });
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
