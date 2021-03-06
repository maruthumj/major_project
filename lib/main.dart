import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:major_project/screens/tv_channel/loginscreen.dart';
import 'package:major_project/screens/advertisers/ad_login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MainScreen());
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Online Marketplace for TV Ads',
          textAlign: TextAlign.center,
          style: TextStyle(color: CupertinoColors.activeBlue),
        ),
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
      ),
      body: Container(
        //constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/wind_mill.jpg'),
              fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Center(

                child: Container(
                  height: 180,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CupertinoButton(
                          color: CupertinoColors.activeBlue,
                          child: Text("Advertiser's Login"),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ad_LoginScreen()));
                          },
                        ),
                        SizedBox(height: 30),
                        CupertinoButton(
                          color: CupertinoColors.activeBlue,
                          child: Text("Tv Channel Login"),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                          },
                        ),
                      ],
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
