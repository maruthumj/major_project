import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:major_project/screens/tv_channel/loginscreen.dart';

class ad_profile extends StatefulWidget {
  ad_profile({Key key}) : super(key: key);

  @override
  _ad_profileState createState() => _ad_profileState();
}

class _ad_profileState extends State<ad_profile> {
  @override
  void initState() {
    super.initState();
    User fuser = fauth.currentUser;

    if (fuser != null) {
      this.get_ad_profile();
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Scaffold(body: LoginScreen())));
    }
  }

  TextEditingController _nameeditController = new TextEditingController();
  TextEditingController _emaileditController = new TextEditingController();
  TextEditingController _phoneeditController = new TextEditingController();
  FirebaseAuth fauth = FirebaseAuth.instance;
  FirebaseFirestore fstore = FirebaseFirestore.instance;

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  get_ad_profile() async {
    DocumentSnapshot documentSnapshot =
        await fstore.collection("tv_channel_users_details").doc(_uid).get();
    this.setState(() {
      name = documentSnapshot.data()['name'];
      emailid = documentSnapshot.data()['email'];
      phonenum = documentSnapshot.data()['phone'];
    });
  }

  final String _uid = FirebaseAuth.instance.currentUser.uid;
  String name = '', emailid = '', phonenum = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
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
                        CupertinoIcons.rectangle_stack_person_crop,
                        color: CupertinoColors.activeGreen,
                        size: 35,
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(
                            color: CupertinoColors.activeGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      IconButton(
                        icon: Icon(CupertinoIcons.ellipsis),
                        onPressed: () async {},
                      ),
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
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.activeOrange,
                          fontSize: 17),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  color: CupertinoColors.secondarySystemBackground,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        CupertinoIcons.person_alt_circle,
                        size: 30,
                        color: CupertinoColors.activeBlue,
                      ),
                      Text(
                        name,
                        style: TextStyle(color: CupertinoColors.black),
                      ),
                      IconButton(
                        icon: Icon(CupertinoIcons.pencil_outline),
                        color: CupertinoColors.black,
                        onPressed: () {
                          showCupertinoDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                              content: CupertinoTextField(
                                placeholder: "Name",
                                controller: _nameeditController,
                              ),
                              actions: [
                                CupertinoDialogAction(
                                    child: Text("Update"),
                                    onPressed: () async {
                                      final CollectionReference users =
                                          fstore.collection(
                                              'tv_channel_users_details');
                                      await users.doc(_uid).update({
                                        'name': _nameeditController.text
                                      }).then((value) {
                                        print("updated successfully");
                                        _phoneeditController.clear();
                                      });
                                      get_ad_profile();

                                      Navigator.pop(context, false);
                                    }),
                                CupertinoDialogAction(
                                  child: Text(
                                    "Cancel",
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
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: CupertinoColors.secondarySystemBackground,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.mail_solid,
                        size: 30,
                        color: CupertinoColors.activeBlue,
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        emailid,
                        style: TextStyle(color: CupertinoColors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: CupertinoColors.secondarySystemBackground,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(CupertinoIcons.phone,
                          size: 30, color: CupertinoColors.activeBlue),
                      Text(
                        phonenum,
                        style: TextStyle(color: CupertinoColors.black),
                      ),
                      IconButton(
                        icon: Icon(CupertinoIcons.pencil_outline),
                        color: CupertinoColors.black,
                        onPressed: () {
                          showCupertinoDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                              content: CupertinoTextField(
                                placeholder: "Phone Number",
                                controller: _phoneeditController,
                              ),
                              actions: [
                                CupertinoDialogAction(
                                    child: Text("Update"),
                                    onPressed: () async {
                                      final CollectionReference users =
                                          fstore.collection(
                                              'tv_channel_users_details');
                                      await users.doc(_uid).update({
                                        'phone': _phoneeditController.text
                                      }).then((value) {
                                        print("updated successfuly");
                                        _nameeditController.clear();
                                      });
                                      get_ad_profile();

                                      Navigator.pop(context, false);
                                    }),
                                CupertinoDialogAction(
                                  child: Text(
                                    "Cancel",
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
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
