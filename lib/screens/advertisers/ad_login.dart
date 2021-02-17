//import 'dart:ui';

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:major_project/screens/tv_channel/signup.dart';

class ad_LoginScreen extends StatefulWidget {
  ad_LoginScreen({Key key}) : super(key: key);

  @override
  _ad_LoginScreenState createState() => _ad_LoginScreenState();
}

class _ad_LoginScreenState extends State<ad_LoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  TextEditingController _passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Advertisers Login",
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
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    CupertinoColors.activeBlue,
                    CupertinoColors.activeGreen,
                  ],
                ),
              ),
            ),
            Center(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  height: 320,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: _formkey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(labelText: "Email"),
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
                            decoration: InputDecoration(labelText: 'password'),
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
                          SizedBox(height: 30),
                          CupertinoButton(
                            child: Text(
                              "Login",
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
                              SizedBox(height: 3),
                              Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: CupertinoColors.activeBlue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
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
