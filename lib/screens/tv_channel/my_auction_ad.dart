import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';

class my_auction_ad extends StatefulWidget {
  my_auction_ad({Key key}) : super(key: key);

  @override
  _my_auction_adState createState() => _my_auction_adState();
}

class _my_auction_adState extends State<my_auction_ad> {
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

  Future getnormalads() async {
    FirebaseFirestore fstore1 = FirebaseFirestore.instance;
    QuerySnapshot qs =
        await fstore1.collection("Auction ads{$channel_name}").get();

    return qs.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getnormalads(),
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
                            "Ad slot number",
                            style:
                                TextStyle(color: CupertinoColors.activeOrange),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(data['Ad_slot number']),
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
                            "Minimum Ad Length(in Minutes)",
                            style:
                                TextStyle(color: CupertinoColors.activeOrange),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(data['Ad minimum_length']),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Auction Count Down",
                            style:
                                TextStyle(color: CupertinoColors.activeOrange),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(data['auction timer']),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Base price",
                            style:
                                TextStyle(color: CupertinoColors.activeOrange),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(data['base price']),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Ending Time and Date",
                            style:
                                TextStyle(color: CupertinoColors.activeOrange),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(data['ending_date_time']),
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
