import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:major_project/screens/tv_channel/signup.dart';
import 'package:major_project/screens/tv_channel/home_screen.dart';
import 'package:major_project/main.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _resetpasswordController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  bool _validateemail = false, _validatepassword = false;
  @override
  Widget build(BuildContext context) {
    FirebaseAuth fauth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tv Channel Login",
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
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MyApp()));
          },
        ),
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
      ),
      body: SafeArea(
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
              child: Container(
                height: 340,
                width: 340,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formkey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Email",
                            errorText:
                                _validateemail ? 'Value Can\'t Be Empty' : null,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Invalid Email';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'password',
                            errorText: _validatepassword
                                ? 'Value Can\'t Be Empty'
                                : null,
                          ),
                          obscureText: true,
                          controller: _passwordController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Invalid Password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        CupertinoButton(
                          child: Text(
                            "Login",
                          ),
                          color: CupertinoColors.activeBlue,
                          onPressed: () async {
                            setState(() {
                              _emailController.text.isEmpty
                                  ? _validateemail = true
                                  : _validateemail = false;
                              _passwordController.text.isEmpty
                                  ? _validatepassword = true
                                  : _validatepassword = false;
                            });
                            var _user = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _passwordController.text);

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                          },
                        ),
                        Row(
                          children: [
                            SizedBox(height: 10),
                            Text(
                              "Don't Have an Account?",
                              style: TextStyle(
                                  fontSize: 15, color: CupertinoColors.black),
                            ),
                            CupertinoButton(
                              child: Text("Sign Up",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CupertinoButton(
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                              onPressed: () {
                                showCupertinoDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) =>
                                      CupertinoAlertDialog(
                                    content: CupertinoTextField(
                                      placeholder: "Email",
                                      controller: _resetpasswordController,
                                    ),
                                    actions: [
                                      CupertinoDialogAction(
                                        child: Text("Reset Password"),
                                        onPressed: () {
                                          fauth.sendPasswordResetEmail(
                                              email: _resetpasswordController
                                                  .text);
                                          _resetpasswordController.clear();
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
                            )
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
    );
  }
}

/*
context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) =>
                                        CupertinoAlertDialog(
                                      title: TextFormField(
                                        controller: _resetpasswordController,
                                        decoration:
                                            InputDecoration(labelText: "Email"),
                                      ),
                                      content: Text(
                                          "Password reset link will be sent to your mail"),
                                      actions: [
                                        CupertinoDialogAction(
                                          child: Text(
                                            "Reset Password",
                                            style: TextStyle(
                                                color:
                                                    CupertinoColors.activeBlue),
                                          ),
                                          onPressed: () {},
                                        ),
                                      ],
*/
