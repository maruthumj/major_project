import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui';
import 'dart:io';
import 'package:major_project/screens/tv_channel/loginscreen.dart';

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  TextEditingController _nameeditController = new TextEditingController();

  TextEditingController _phoneeditController = new TextEditingController();
  TextEditingController _languageController = new TextEditingController();
  TextEditingController _channelnameController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  TextEditingController _categoryController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _weeklyviewersController = new TextEditingController();
  bool _lights;
  String imageLink;
  File _image;

  FirebaseAuth fauth = FirebaseAuth.instance;
  FirebaseFirestore fstore = FirebaseFirestore.instance;

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  String _uid = FirebaseAuth.instance.currentUser.uid;
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
            actions: [
              MergeSemantics(
                child: ListTile(
                  title: Text(
                    'Featured ads',
                    style: TextStyle(
                      color: CupertinoColors.activeBlue,
                    ),
                  ),
                  trailing: CupertinoSwitch(
                    value: _lights,
                    onChanged: (bool value) {
                      setState(() {
                        _lights = value;
                      });
                    },
                  ),
                  onTap: () {
                    setState(() {
                      _lights = !_lights;

                      fstore
                          .collection("tv_channel_details")
                          .where("uid", isEqualTo: "$_uid")
                          .get()
                          .then((QuerySnapshot querySnapshot) {
                        querySnapshot.docs.forEach((doc) {
                          doc.reference.update({"Featured ad": _lights});
                        });
                      });
                      Navigator.pop(context, false);
                    });
                  },
                ),
              ),
              CupertinoActionSheetAction(
                child: Text(
                  "Logout",
                  style: TextStyle(color: CupertinoColors.activeBlue),
                ),
                onPressed: () {
                  _signOut();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Scaffold(body: LoginScreen())));
                },
                isDefaultAction: true,
              ),
              CupertinoActionSheetAction(
                child: Text(
                  "Delete Account!",
                  style: TextStyle(color: CupertinoColors.activeBlue),
                ),
                onPressed: () {
                  User fuser = fauth.currentUser;
                  fuser.delete();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Scaffold(body: LoginScreen())));
                },
                isDefaultAction: true,
              ),
              CupertinoActionSheetAction(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: CupertinoColors.systemRed),
                ),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              )
            ],
          );
        });
  }

  Future<void> setImageurl() async {
    QuerySnapshot queryDocumentSnapshot = await fstore
        .collection("tv_channel_details")
        .where("uid", isEqualTo: "$_uid")
        .get();
    setState(() {
      queryDocumentSnapshot.docs.forEach((doc) {
        doc.reference.update({"image url": imageLink});
      });
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
        imageLink = doc['image url'];
        language = doc['Language'];
        weekly_viewers = doc['Weekly Viewers'];
        address = doc['Address'];
        _lights = doc['Featured ads'];
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
    User fuser = fauth.currentUser;
    //
    this.getchanneldata();
    this.getuserdata();
    //} else {
    //Navigator.of(context).push(MaterialPageRoute(
    //  builder: (context) => Scaffold(body: LoginScreen())));
    //}
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
                        onPressed: () {
                          showCupertinoDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                              content: Stack(
                                overflow: Overflow.visible,
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Column(
                                    children: [
                                      Container(
                                        child: CupertinoButton(
                                          child: Text("Logout"),
                                          onPressed: () {
                                            _signOut();
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Scaffold(
                                                            body:
                                                                LoginScreen())));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              actions: [
                                CupertinoDialogAction(
                                  child: Text("create"),
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (imageLink == null)
                      Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                                'assets/images/person_badge_plus.png'),
                          ),
                        ),
                      ),
                    if (imageLink != null)
                      Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(imageLink),
                          ),
                        ),
                      ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        CupertinoIcons.cloud_upload_fill,
                        color: CupertinoColors.activeBlue,
                      ),
                      onPressed: () async {
                        _image = await ImagePicker.pickImage(
                            source: ImageSource.gallery);
                        FirebaseStorage fs = FirebaseStorage.instance;
                        Reference rootReference = fs.ref();
                        Reference pictureFolderRef =
                            rootReference.child("logo").child(channel_name);
                        pictureFolderRef
                            .putFile(_image)
                            .then((storageTask) async {
                          String link = await storageTask.ref.getDownloadURL();
                          print("uploaded");
                          setState(() {
                            imageLink = link;
                            setImageurl();
                          });
                          print(imageLink);
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
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
                                controller: _channelnameController,
                              ),
                              actions: [
                                CupertinoDialogAction(
                                    child: Text("Update"),
                                    onPressed: () async {
                                      await fstore
                                          .collection("tv_channel_details")
                                          .where("uid", isEqualTo: "$_uid")
                                          .get()
                                          .then((QuerySnapshot querySnapshot) {
                                        querySnapshot.docs.forEach((doc) {
                                          doc.reference.update({
                                            "Channel name":
                                                _channelnameController.text
                                          });
                                        });
                                      });
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
                                controller: _descriptionController,
                              ),
                              actions: [
                                CupertinoDialogAction(
                                    child: Text("Update"),
                                    onPressed: () async {
                                      await fstore
                                          .collection("tv_channel_details")
                                          .where("uid", isEqualTo: "$_uid")
                                          .get()
                                          .then((QuerySnapshot querySnapshot) {
                                        querySnapshot.docs.forEach((doc) {
                                          doc.reference.update({
                                            "Description":
                                                _descriptionController.text
                                          });
                                        });
                                      });
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
                                controller: _categoryController,
                              ),
                              actions: [
                                CupertinoDialogAction(
                                    child: Text("Update"),
                                    onPressed: () async {
                                      await fstore
                                          .collection("tv_channel_details")
                                          .where("uid", isEqualTo: "$_uid")
                                          .get()
                                          .then((QuerySnapshot querySnapshot) {
                                        querySnapshot.docs.forEach((doc) {
                                          doc.reference.update({
                                            "Category":
                                                _channelnameController.text
                                          });
                                        });
                                      });
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
                                controller: _languageController,
                              ),
                              actions: [
                                CupertinoDialogAction(
                                    child: Text("Update"),
                                    onPressed: () async {
                                      await fstore
                                          .collection("tv_channel_details")
                                          .where("uid", isEqualTo: "$_uid")
                                          .get()
                                          .then((QuerySnapshot querySnapshot) {
                                        querySnapshot.docs.forEach((doc) {
                                          doc.reference.update({
                                            "Language": _languageController.text
                                          });
                                        });
                                      });
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
                                controller: _addressController,
                              ),
                              actions: [
                                CupertinoDialogAction(
                                    child: Text("Update"),
                                    onPressed: () async {
                                      await fstore
                                          .collection("tv_channel_details")
                                          .where("uid", isEqualTo: "$_uid")
                                          .get()
                                          .then((QuerySnapshot querySnapshot) {
                                        querySnapshot.docs.forEach((doc) {
                                          doc.reference.update({
                                            "Category": _categoryController.text
                                          });
                                        });
                                      });
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        CupertinoIcons.person_3_fill,
                        size: 30,
                        color: CupertinoColors.activeBlue,
                      ),
                      Text(
                        weekly_viewers,
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
                                placeholder: "Weekly Viewers",
                                controller: _weeklyviewersController,
                              ),
                              actions: [
                                CupertinoDialogAction(
                                    child: Text("Update"),
                                    onPressed: () async {
                                      await fstore
                                          .collection("tv_channel_details")
                                          .where("uid", isEqualTo: "$_uid")
                                          .get()
                                          .then((QuerySnapshot querySnapshot) {
                                        querySnapshot.docs.forEach((doc) {
                                          doc.reference.update({
                                            "Weekly Viewers":
                                                _weeklyviewersController.text
                                          });
                                        });
                                      });
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
