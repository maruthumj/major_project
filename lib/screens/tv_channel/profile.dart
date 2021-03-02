import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';

class profile extends StatefulWidget {
  profile({Key key}) : super(key: key);

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth fauth = FirebaseAuth.instance;
    FirebaseFirestore fstore = FirebaseFirestore.instance;
    User fuser = fauth.currentUser;
    String uid = fuser.uid;
    String name, phonenum, emailid;
    fstore
        .collection("tv_channel_users_details")
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        name = documentSnapshot.data()['name'];
        emailid = documentSnapshot.data()['email'];
        phonenum = documentSnapshot.data()['phone'];
      } else {}
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: CupertinoColors.secondarySystemBackground,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        CupertinoIcons.paintbrush_fill,
                        color: CupertinoColors.activeBlue,
                      ),
                      Text(
                        "Personalization",
                        style: TextStyle(
                            color: CupertinoColors.activeBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      IconButton(
                        icon: Icon(CupertinoIcons.ellipsis),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Account Details",
                      style: TextStyle(
                          color: CupertinoColors.activeOrange, fontSize: 17),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  color: CupertinoColors.secondarySystemBackground,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        CupertinoIcons.person_alt_circle,
                        size: 30,
                      ),
                      Text(
                        name,
                        style: TextStyle(color: CupertinoColors.black),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
