import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui';

class Signup extends StatefulWidget {
  Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _channel_nameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _descController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _categoryController = new TextEditingController();
  int selected = 0;
  int selected1 = 0;
  bool _lights = false;
  final _auth = FirebaseAuth.instance;

  bool showProgress = false;

  @override
  Widget build(BuildContext context) {
    CollectionReference users_details =
        Firestore.instance.collection("tv_channel_details");

    Future<void> addUser() {
      return users_details.add({});
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
                      height: 1300,
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
                              decoration: InputDecoration(
                                  labelText: 'Phone Number',
                                  labelStyle:
                                      TextStyle(color: CupertinoColors.black)),
                              obscureText: true,
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
                              validator: (value) {
                                if (value.isEmpty ||
                                    value != _passwordController.text) {
                                  return 'Invalid Password';
                                }
                                return null;
                              },
                              onSaved: (value) {},
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
                                      obscureText: true,
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
                                    onSelectedItemChanged: (int i) {
                                      print(i);
                                      setState(() {
                                        selected = i;
                                      });
                                    },
                                    children: [
                                      Text(
                                        "Tamil",
                                        style: TextStyle(
                                            color: selected == 0
                                                ? CupertinoColors.activeBlue
                                                : CupertinoColors.black),
                                      ),
                                      Text(
                                        "Telugu",
                                        style: TextStyle(
                                            color: selected == 1
                                                ? CupertinoColors.activeBlue
                                                : CupertinoColors.black),
                                      ),
                                      Text(
                                        "Malayalam",
                                        style: TextStyle(
                                            color: selected == 2
                                                ? CupertinoColors.activeBlue
                                                : CupertinoColors.black),
                                      ),
                                      Text(
                                        "Kannada",
                                        style: TextStyle(
                                            color: selected == 3
                                                ? CupertinoColors.activeBlue
                                                : CupertinoColors.black),
                                      ),
                                      Text(
                                        "Bangla",
                                        style: TextStyle(
                                            color: selected == 4
                                                ? CupertinoColors.activeBlue
                                                : CupertinoColors.black),
                                      ),
                                      Text(
                                        "Gujarati",
                                        style: TextStyle(
                                            color: selected == 5
                                                ? CupertinoColors.activeBlue
                                                : CupertinoColors.black),
                                      ),
                                      Text(
                                        "Hindi",
                                        style: TextStyle(
                                            color: selected == 6
                                                ? CupertinoColors.activeBlue
                                                : CupertinoColors.black),
                                      ),
                                      Text(
                                        "Kashmiri",
                                        style: TextStyle(
                                            color: selected == 7
                                                ? CupertinoColors.activeBlue
                                                : CupertinoColors.black),
                                      ),
                                      Text(
                                        "Marathi",
                                        style: TextStyle(
                                            color: selected == 8
                                                ? CupertinoColors.activeBlue
                                                : CupertinoColors.black),
                                      ),
                                      Text(
                                        "Punjabi",
                                        style: TextStyle(
                                            color: selected == 9
                                                ? CupertinoColors.activeBlue
                                                : CupertinoColors.black),
                                      ),
                                      Text(
                                        "Urdu",
                                        style: TextStyle(
                                            color: selected == 10
                                                ? CupertinoColors.activeBlue
                                                : CupertinoColors.black),
                                      ),
                                      Text(
                                        "English",
                                        style: TextStyle(
                                            color: selected == 11
                                                ? CupertinoColors.activeBlue
                                                : CupertinoColors.black),
                                      ),
                                      Text(
                                        "Other",
                                        style: TextStyle(
                                            color: selected == 12
                                                ? CupertinoColors.activeBlue
                                                : CupertinoColors.black),
                                      ),

/*                                 
ssamese, Bangla, Bodo, Dogri, Gujarati, Hindi, Kashmiri, Kannada, Konkani, Maithili, Malayalam, Manipuri, Marathi, Nepali, Oriya, Punjabi, Tamil, Telugu, Santali, Sindhi, and Urdu
*/
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
                                    onSelectedItemChanged: (int i) {
                                      print(i);
                                      setState(() {
                                        selected1 = i;
                                      });
                                    },
                                    children: [
                                      Text(
                                        "Knowledge and Lifestyle",
                                        style: TextStyle(
                                            color: selected1 == 0
                                                ? CupertinoColors.activeBlue
                                                : CupertinoColors.black),
                                      ),
                                      Text(
                                        "Music",
                                        style: TextStyle(
                                            color: selected1 == 1
                                                ? CupertinoColors.activeBlue
                                                : CupertinoColors.black),
                                      ),
                                      Text(
                                        "News",
                                        style: TextStyle(
                                            color: selected1 == 2
                                                ? CupertinoColors.activeBlue
                                                : CupertinoColors.black),
                                      ),
                                      Text(
                                        "Entertainment",
                                        style: TextStyle(
                                            color: selected1 == 3
                                                ? CupertinoColors.activeBlue
                                                : CupertinoColors.black),
                                      ),
                                      Text(
                                        "Movies",
                                        style: TextStyle(
                                            color: selected1 == 4
                                                ? CupertinoColors.activeBlue
                                                : CupertinoColors.black),
                                      ),
                                      Text(
                                        "Comedy",
                                        style: TextStyle(
                                            color: selected1 == 5
                                                ? CupertinoColors.activeBlue
                                                : CupertinoColors.black),
                                      ),
                                      Text(
                                        "Spiritual",
                                        style: TextStyle(
                                            color: selected1 == 6
                                                ? CupertinoColors.activeBlue
                                                : CupertinoColors.black),
                                      ),
                                      Text(
                                        "Sports",
                                        style: TextStyle(
                                            color: selected1 == 7
                                                ? CupertinoColors.activeBlue
                                                : CupertinoColors.black),
                                      ),
                                      Text(
                                        "Kids",
                                        style: TextStyle(
                                            color: selected1 == 8
                                                ? CupertinoColors.activeBlue
                                                : CupertinoColors.black),
                                      ),
                                      Text(
                                        "Others",
                                        style: TextStyle(
                                            color: selected1 == 9
                                                ? CupertinoColors.activeBlue
                                                : CupertinoColors.black),
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
                                        'you need to verify your Email and Phone to create a new Account.'),
                                    content: Text("Do you accept?"),
                                    actions: [
                                      CupertinoDialogAction(
                                        child: Text(
                                          'Yes',
                                          style: TextStyle(
                                              color:
                                                  CupertinoColors.activeBlue),
                                        ),
                                        onPressed: () {},
                                      ),
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

/*

 SizedBox(height: 30),
                          CupertinoButton(
                            child: Text(
                              "SignUp",
                            ),
                            color: CupertinoColors.activeBlue,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Signup()));
                            },
                          ),
                          Row(
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
                                      builder: (context) => Signup()));
                                },
                              ),
                            ],
                          ),

*/
