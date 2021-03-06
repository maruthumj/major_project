import 'dart:ui';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';
import 'package:major_project/screens/tv_channel/loginscreen.dart';
import 'package:major_project/screens/tv_channel/email_verification.dart';

class Signup extends StatefulWidget {
  Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  bool _validatename = false,
      _validateemail = false,
      _validatepassword = false,
      _validatecname = false,
      _validatecdesc = false,
      _validateweeklyviewers = false,
      _validatephone = false,
      _validateaddress = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _resetpasswordController = new TextEditingController();
  TextEditingController _weeklyviewers = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _channel_nameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _descController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _categoryController = new TextEditingController();
  TextEditingController _nameController2 = new TextEditingController();
  int selected = 0;
  int selected1 = 0;
  bool _lights = false;
  String val, lang_name, val1, category_name;
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  getUID() async {
    final User user = await auth.currentUser;
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
    "Punjabi",
    "Urdu",
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

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference channel_details =
        FirebaseFirestore.instance.collection("tv_channel_details");

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
                image: AssetImage('assets/images/ios_leaf.jpg'),
                fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Center(
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
                            controller: _nameController,
                            decoration: InputDecoration(
                                errorText: _validatename
                                    ? 'Value Can\'t Be Empty'
                                    : null,
                                labelText: "Name",
                                labelStyle:
                                    TextStyle(color: CupertinoColors.black)),
                            keyboardType: TextInputType.name,
                          ),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                                errorText: _validateemail
                                    ? 'Value Can\'t Be Empty'
                                    : null,
                                labelText: "Email",
                                labelStyle:
                                    TextStyle(color: CupertinoColors.black)),
                            keyboardType: TextInputType.emailAddress,
                            validator: emailValidator,
                          ),
                          TextFormField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                                errorText: _validatephone
                                    ? 'Value Can\'t Be Empty'
                                    : null,
                                labelText: 'Phone Number',
                                labelStyle:
                                    TextStyle(color: CupertinoColors.black)),
                            keyboardType: TextInputType.phone,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              errorText: _validatepassword
                                  ? 'Value Can\'t Be Empty'
                                  : null,
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
                                width: 250,
                                child: TextFormField(
                                    controller: _channel_nameController,
                                    textAlign: TextAlign.justify,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                      labelText: 'Channel Name',
                                      errorText: _validatecname
                                          ? 'Value Can\'t Be Empty'
                                          : null,
                                      labelStyle: TextStyle(
                                          color: CupertinoColors.activeOrange,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    keyboardType: TextInputType.name),
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
                                  errorText: _validatecdesc
                                      ? 'Value Can\'t Be Empty'
                                      : null,
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
                                  scrollController: FixedExtentScrollController(
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
                                          color: (selected ==
                                                  languages.indexOf(val)
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
                                          color: (selected1 ==
                                                  category.indexOf(val1)
                                              ? CupertinoColors.activeBlue
                                              : CupertinoColors.black),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              MergeSemantics(
                                child: ListTile(
                                  title: Text(
                                    'Supports Featured Ads?(Real Estate/Telecom/etc...)',
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
                              labelText: 'Weekly Viewers',
                              errorText: _validateweeklyviewers
                                  ? 'Value Can\'t Be Empty'
                                  : null,
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
                              errorText: _validateaddress
                                  ? 'Value Can\'t Be Empty'
                                  : null,
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
                            onPressed: () async {
                              setState(() {
                                _nameController.text.isEmpty
                                    ? _validatename = true
                                    : _validatename = false;
                                _emailController.text.isEmpty
                                    ? _validateemail = true
                                    : _validateemail = false;
                                _passwordController.text.isEmpty
                                    ? _validatepassword = true
                                    : _validatepassword = false;
                                _phoneController.text.isEmpty
                                    ? _validatephone = true
                                    : _validatephone = false;
                                _channel_nameController.text.isEmpty
                                    ? _validatecname = true
                                    : _validatecname = false;
                                _descController.text.isEmpty
                                    ? _validatecdesc = true
                                    : _validatecdesc = false;
                                _addressController.text.isEmpty
                                    ? _validateaddress = true
                                    : _validateaddress = false;
                                _weeklyviewers.text.isEmpty? _validateweeklyviewers=true: _validateweeklyviewers=false;
                              });

                              await auth.createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                              final User user = auth.currentUser;
                              final String uid = user.uid;
                              if (user != null) {
                                firestore
                                    .collection("tv_channel_details")
                                    .add({
                                      'Channel name':
                                          _channel_nameController.text,
                                      'Language': lang_name,
                                      'Category': category_name,
                                      'Description': _descController.text,
                                      'Featured ad': _lights,
                                      'Address': _addressController.text,
                                      'Weekly Viewers': _weeklyviewers.text,
                                      'uid': uid,
                                      'image url': '',
                                      'email': _emailController.text,
                                      'phone': _phoneController.text,
                                    })
                                    .then((value) => print("channel added"))
                                    .catchError((error) => print(
                                        "Failed to create channel: $error"));
                                firestore
                                    .collection("tv_channel_users_details")
                                    .doc(uid)
                                    .set({
                                      'email': _emailController.text,
                                      'name': _nameController.text,
                                      'phone': _phoneController.text,
                                    })
                                    .then((value) => print("user added"))
                                    .catchError((error) => print(
                                        "Failed to create user details: $error"));
                              }

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
                                          User user =
                                              FirebaseAuth.instance.currentUser;
                                          if (!user.emailVerified) {
                                            user.sendEmailVerification();
                                          }

                                          await Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Scaffold(
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
                                    fontSize: 15, color: CupertinoColors.black),
                              ),
                              CupertinoButton(
                                child: Text("Log In",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                                },
                              ),
                            ],
                          ),
                        ],
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
