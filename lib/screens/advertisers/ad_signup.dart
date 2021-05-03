import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:major_project/screens/advertisers/ad_login.dart';

class ad_Signup extends StatefulWidget {
  ad_Signup({Key key}) : super(key: key);

  @override
  _ad_SignupState createState() => _ad_SignupState();
}

class _ad_SignupState extends State<ad_Signup> {
  final GlobalKey<FormState> _formkey = GlobalKey();

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmpasswordController =
      new TextEditingController();
  TextEditingController _companyController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool _validatename = false,
      _validatepassword = false,
      _validatephone = false,
      _validateemail = false,
      _validateconfirmpassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Advertisers SignUp",
          style: TextStyle(color: CupertinoColors.activeBlue),
        ),
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          icon: Icon(
            CupertinoIcons.chevron_back,
            color: CupertinoColors.activeBlue,
          ),
        ),
      ),
      body: SafeArea(
        // scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/ios_sea.jpg'),
                    fit: BoxFit.cover),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Container(
                  height: 550,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                              errorText: _validatename
                                  ? 'Value Can\'t Be Empty'
                                  : null,
                              labelText: "Name"),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              errorText: _validateemail
                                  ? 'Value Can\'t Be Empty'
                                  : null,
                              labelText: "Email"),
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
                              errorText: _validatephone
                                  ? 'Value Can\'t Be Empty'
                                  : null,
                              labelText: "Phone Number"),
                          keyboardType: TextInputType.phone,
                          obscureText: false,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                              errorText: _validatepassword
                                  ? 'Value Can\'t Be Empty'
                                  : null,
                              labelText: "Password"),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                        ),
                        TextFormField(
                          controller: _confirmpasswordController,
                          decoration: InputDecoration(
                              errorText: _validateconfirmpassword
                                  ? 'Value Can\'t Be Empty'
                                  : null,
                              labelText: "Confirm Password"),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                        ),
                        SizedBox(height: 20),
                        CupertinoButton(
                          color: CupertinoColors.activeBlue,
                          child: Text(
                            "Create Account",
                          ),
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
                              _confirmpasswordController.text.isEmpty
                                  ? _validatename = true
                                  : _validatename = false;
                            });
                            FirebaseAuth fauth = FirebaseAuth.instance;
                            fauth.createUserWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text);
                            CollectionReference advertisers_details =
                                FirebaseFirestore.instance
                                    .collection("advertisers_details");
                            User fuser = fauth.currentUser;
                            final uid = fuser.uid;

                            await advertisers_details.doc(uid).set({
                              'uid': uid,
                              'Name': _nameController.text,
                              'Email': _emailController.text,
                              'Phone': _phoneController.text,
                            }).then((value) {
                              print("channel added");
                            }).catchError((error) {
                              return "Failed to create Channel: $error";
                            });

                            _nameController.clear();
                            _emailController.clear();
                            _phoneController.clear();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ad_LoginScreen()));
                          },
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          child: Text(
                            "Already Have an Account?",
                            style: TextStyle(
                                fontSize: 15,
                                color: CupertinoColors.activeBlue,
                                decoration: TextDecoration.underline),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ad_LoginScreen()));
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
    );
  }
}
