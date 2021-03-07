import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  TextEditingController _nameeditController = new TextEditingController();
  TextEditingController _emaileditController = new TextEditingController();
  TextEditingController _phoneeditController = new TextEditingController();
  TextEditingController _channelnameController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  TextEditingController _categoryController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _weeklyviewersController = new TextEditingController();

  FirebaseAuth fauth = FirebaseAuth.instance;
  FirebaseFirestore fstore = FirebaseFirestore.instance;

  final String _uid = FirebaseAuth.instance.currentUser.uid;
  String name = '',
      phonenum = '',
      emailid = '',
      channel_name = '',
      category = '',
      description = '',
      language = '',
      weekly_viewers = '',
      address = '';

  actionSheetMethod() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            title: Text(
              "Menu",
              style:
                  TextStyle(color: CupertinoColors.activeOrange, fontSize: 25),
            ),
            actions: [
              CupertinoActionSheetAction(
                child: Text(
                  "Logout",
                  style: TextStyle(color: CupertinoColors.activeBlue),
                ),
                onPressed: () {},
                isDefaultAction: true,
              ),
              CupertinoActionSheetAction(
                child: Text(
                  "Delete Account!",
                  style: TextStyle(color: CupertinoColors.activeBlue),
                ),
                onPressed: () {},
                isDefaultAction: true,
              ),
            ],
            cancelButton: Text(
              "Cancel",
              style: TextStyle(
                color: CupertinoColors.systemRed,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        });
  }

  Future<void> getchanneldata() async {
    QuerySnapshot queryDocumentSnapshot = await fstore
        .collection("tv_channel_details")
        .where("uid", isEqualTo: "$_uid")
        .get();
    setState(() {
      queryDocumentSnapshot.docs.forEach((doc) {
        channel_name = doc['Channel name'];
        description = doc['Description'];
        category = doc['Category'];
        language = doc['Language'];
        weekly_viewers = doc['Weekly Viewers'];
        address = doc['Address'];
        print(channel_name);
        print(address);
      });
    });
  }

  Future<void> getuserdata() async {
    DocumentSnapshot documentSnapshot =
        await fstore.collection("tv_channel_users_details").doc(_uid).get();
    this.setState(() {
      name = documentSnapshot.data()['name'];
      emailid = documentSnapshot.data()['email'];
      phonenum = documentSnapshot.data()['phone'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getchanneldata();
    this.getuserdata();
  }

  @override
  Widget build(BuildContext context) {
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
                        onPressed: () async {
                          await actionSheetMethod();
                        },
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
                                      getuserdata();

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
                                      getuserdata();

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
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Channel Details",
                      style: TextStyle(
                          color: CupertinoColors.activeOrange,
                          fontWeight: FontWeight.bold,
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
                        CupertinoIcons.doc_person_fill,
                        size: 30,
                        color: CupertinoColors.activeBlue,
                      ),
                      Text(
                        channel_name,
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
                                placeholder: "Channel Name",
                                controller: _phoneeditController,
                              ),
                              actions: [
                                CupertinoDialogAction(
                                    child: Text("Update"), onPressed: () {}),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        CupertinoIcons.doc_plaintext,
                        size: 30,
                        color: CupertinoColors.activeBlue,
                      ),
                      Text(
                        description,
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
                                placeholder: "Description",
                                controller: _phoneeditController,
                              ),
                              actions: [
                                CupertinoDialogAction(
                                    child: Text("Update"), onPressed: () {}),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        CupertinoIcons.circle_grid_hex,
                        size: 30,
                        color: CupertinoColors.activeBlue,
                      ),
                      Text(
                        category,
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
                                placeholder: "Category",
                                controller: _phoneeditController,
                              ),
                              actions: [
                                CupertinoDialogAction(
                                    child: Text("Update"), onPressed: () {}),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.translate_outlined,
                        size: 30,
                        color: CupertinoColors.activeBlue,
                      ),
                      Text(
                        language,
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
                                placeholder: "Language",
                                controller: _phoneeditController,
                              ),
                              actions: [
                                CupertinoDialogAction(
                                    child: Text("Update"), onPressed: () {}),
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
                  height: 80,
                  color: CupertinoColors.secondarySystemBackground,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        size: 30,
                        color: CupertinoColors.activeBlue,
                      ),
                      Container(
                        height: 50,
                        child: Text(
                          address,
                          style: TextStyle(color: CupertinoColors.black),
                        ),
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
                                placeholder: "Address",
                                controller: _phoneeditController,
                              ),
                              actions: [
                                CupertinoDialogAction(
                                    child: Text("Update"), onPressed: () {}),
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

  void myActionSheet(context) {}
}
