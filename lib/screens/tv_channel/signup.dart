import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:major_project/screens/tv_channel/loginscreen.dart';
import 'package:major_project/screens/tv_channel/email_verification.dart';

void main() async {
  runApp(Signup());
}

class Signup extends StatefulWidget {
  Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formkey = GlobalKey();

  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _weeklyviewers = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _channel_nameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _descController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _categoryController = new TextEditingController();
  int selected = 0;
  int selected1 = 0;
  bool _lights = false;
  String val, lang_name, val1, category_name;
  final _auth = FirebaseAuth.instance;
  Firestore firestore = Firestore.instance;

  getUID() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    return uid;
  }

  bool showProgress = false;

  List<String> languages = [
    "Tamil",
    "Telugu",
    "Malayalam",
    "Kannada",
    "Gujarati",
    "Hindi",
    "Bangla",
    "Kashmiri",
    "Marathi",
    "Gujarati",
    "Punjabi",
    "Urdu",
    "Kashmiri",
    "Assame",
    "English",
    "Other"
  ];
  List<String> category = [
    "Knowledge and Lifestyle",
    "music",
    "news",
    "Entertainement",
    "Movies",
    "Comedy",
    "Spiritual",
    "Sports",
    "kids",
    "Others"
  ];

  List<DropdownMenuItem> getmenuItem1() {
    List<DropdownMenuItem> list1 = [];
    for (String value1 in category) {
      list1.add(DropdownMenuItem(
        child: Text(
          value1,
          style: TextStyle(color: CupertinoColors.activeBlue),
        ),
        value: value1,
      ));
    }
  }

  /* List<DropdownMenuItem> getmenuItem() {
    List<DropdownMenuItem> list = [];
    for (String value in languages) {
      list.add(DropdownMenuItem(
        child: Text(
          value,
          style: TextStyle(color: CupertinoColors.activeBlue),
        ),
        value: value,
      ));
    }
  }*/

  @override
  Widget build(BuildContext context) {
    CollectionReference channel_details =
        Firestore.instance.collection("tv_channel_details");
    Future<void> addChannel() {
      return channel_details
          .document()
          .setData({
            'Channel name': _channel_nameController.text,
            'Language': lang_name,
            'Category': category_name,
            'Description': _descController.text,
            'Featured ad': _lights,
            'Address': _addressController.text,
            'Weekly Viewers': _weeklyviewers.text,
          })
          .then((value) => print("channel added"))
          .catchError((error) => print("Failed to create channel: $error"));
    }

    Future<void> addUser() {
      if (_emailController != null && _phoneController != null) {
        CollectionReference user_details =
            Firestore.instance.collection("tv_account_details");
        return user_details.document(getUID()).setData({
          'email': _emailController.text,
          'phone': _phoneController.text,
        }).then((value) {
          Fluttertoast.showToast(
              msg: "User Created Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: CupertinoColors.extraLightBackgroundGray,
              textColor: CupertinoColors.systemRed,
              fontSize: 16.0);
          print("User Added");
        }).catchError((error) {
          print("Failed to add user: $error");
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Account",
          style: TextStyle(
            color: CupertinoColors.activeBlue,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.chevron_back,
          ),
          color: CupertinoColors.activeBlue,
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/ios_sea.jpg'),
                fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Center(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      height: 1500,
                      width: 500,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400.withOpacity(0.5),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            Text(
                              "Account Details",
                              style: TextStyle(
                                color: CupertinoColors.activeBlue,
                                decorationColor: Colors.blue,
                                fontSize: 18,
                                decorationThickness: 4,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                  labelText: "Email",
                                  labelStyle:
                                      TextStyle(color: CupertinoColors.black)),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value.isEmpty || !value.contains('@')) {
                                  return 'Invalid Email';
                                }
                                return null;
                              },
                              onSaved: (value) {},
                            ),
                            TextFormField(
                              controller: _phoneController,
                              decoration: InputDecoration(
                                  labelText: 'Phone Number',
                                  labelStyle:
                                      TextStyle(color: CupertinoColors.black)),
                              keyboardType: TextInputType.phone,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'password',
                                labelStyle:
                                    TextStyle(color: CupertinoColors.black),
                              ),
                              obscureText: true,
                              controller: _passwordController,
                              validator: (value2) {
                                if (value2.isEmpty ||
                                    value2 != _passwordController.text) {
                                  return 'Invalid Password';
                                }
                                return null;
                              },
                              onSaved: (value2) {},
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                labelStyle:
                                    TextStyle(color: CupertinoColors.black),
                              ),
                              obscureText: true,
                              controller: _passwordController,
                              validator: (value) {
                                if (value.isEmpty ||
                                    value != _passwordController.text) {
                                  return 'Invalid Password';
                                }
                                return null;
                              },
                              onSaved: (value) {},
                            ),
                            SizedBox(height: 50),
                            Text(
                              "Channel Details",
                              style: TextStyle(
                                  fontSize: 20,
                                  decorationColor: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  color: CupertinoColors.activeBlue,
                                  decorationThickness: 4,
                                  decoration: TextDecoration.underline),
                              textAlign: TextAlign.center,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
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
                                Container(
                                  width: 250,
                                  child: TextFormField(
                                      controller: _channel_nameController,
                                      textAlign: TextAlign.justify,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        labelText: 'Channel Name',
                                        labelStyle: TextStyle(
                                            color: CupertinoColors.activeOrange,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      keyboardType: TextInputType.name),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "     Logo",
                                  style: TextStyle(
                                    color: CupertinoColors.activeOrange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                TextFormField(
                                  textAlign: TextAlign.start,
                                  minLines: 1,
                                  maxLines: 5,
                                  controller: _descController,
                                  decoration: InputDecoration(
                                    labelText: 'Description',
                                    labelStyle: TextStyle(
                                        color: CupertinoColors.activeOrange,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Language",
                                      style: TextStyle(
                                        color: CupertinoColors.activeOrange,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 150,
                                  child: CupertinoPicker(
                                    scrollController:
                                        FixedExtentScrollController(
                                            initialItem: 1),
                                    itemExtent: 50,
                                    onSelectedItemChanged: (value) {
                                      lang_name = languages[value];
                                      print(lang_name);
                                      setState(() {
                                        selected = value;
                                      });
                                    },
                                    children: [
                                      for (val in languages)
                                        Text(
                                          val,
                                          style: TextStyle(
                                            color: (selected == 0 ||
                                                    selected == 1 ||
                                                    selected == 2 ||
                                                    selected == 3 ||
                                                    selected == 4 ||
                                                    selected == 5 ||
                                                    selected == 6 ||
                                                    selected == 7 ||
                                                    selected == 8 ||
                                                    selected == 9 ||
                                                    selected == 10 ||
                                                    selected == 11 ||
                                                    selected == 12 ||
                                                    selected == 13
                                                ? CupertinoColors.activeBlue
                                                : CupertinoColors.black),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Category",
                                      style: TextStyle(
                                          color: CupertinoColors.activeOrange,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 150,
                                  child: CupertinoPicker(
                                    itemExtent: 50,
                                    onSelectedItemChanged: (value1) {
                                      category_name = category[value1];
                                      print(category_name);
                                      setState(() {
                                        selected1 = value1;
                                      });
                                    },
                                    children: [
                                      for (val1 in category)
                                        Text(
                                          val1,
                                          style: TextStyle(
                                            color: (CupertinoColors.activeBlue),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                MergeSemantics(
                                  child: ListTile(
                                    title: Text(
                                      'Supports Featured Ads?(Real Estate/Telecom)',
                                      style: TextStyle(
                                          color: CupertinoColors.activeOrange,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
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
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                              controller: _weeklyviewers,
                              textAlign: TextAlign.justify,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Weekly Viewers (optional)',
                                labelStyle: TextStyle(
                                    color: CupertinoColors.activeOrange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                              controller: _addressController,
                              textAlign: TextAlign.justify,
                              keyboardType: TextInputType.streetAddress,
                              decoration: InputDecoration(
                                labelText: 'Address',
                                labelStyle: TextStyle(
                                    color: CupertinoColors.activeOrange,
                                    fontSize: 20),
                              ),
                            ),
                            SizedBox(height: 30),
                            CupertinoButton(
                              color: CupertinoColors.activeBlue,
                              child: Text("Create Account"),
                              onPressed: () {
                                showCupertinoDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) =>
                                      CupertinoAlertDialog(
                                    title: Text(
                                        'you need to verify your Email to create a new Account.'),
                                    content: Text("Do you accept?"),
                                    actions: [
                                      CupertinoDialogAction(
                                          child: Text(
                                            'Yes',
                                            style: TextStyle(
                                                color:
                                                    CupertinoColors.activeBlue),
                                          ),
                                          onPressed: () async {
                                            auth.createUserWithEmailAndPassword(
                                                email: _emailController.text,
                                                password:
                                                    _passwordController.text);
                                            addChannel();
                                            addUser();
                                            try {
                                              FirebaseUser user =
                                                  await auth.currentUser();

                                              await user
                                                  .sendEmailVerification();
                                            } catch (e) {
                                              print(
                                                  "An error occured while trying to send email verification");
                                              print(e.message);
                                            }
                                            await Navigator.of(context).push(
                                                new MaterialPageRoute(
                                                    builder: (context) =>
                                                        new Scaffold(
                                                            body:
                                                                LoginScreen())));
                                          }),
                                      CupertinoDialogAction(
                                        child: Text(
                                          'No',
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  "Already Have an Account?",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: CupertinoColors.black),
                                ),
                                CupertinoButton(
                                  child: Text("Log In",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
