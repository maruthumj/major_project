import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:major_project/screens/advertisers/dashboard_featured_ad_approved.dart';
import 'package:major_project/screens/advertisers/dashboard_featured_ad_declined.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'dart:io';

class dashboard_featured_ad extends StatefulWidget {
  dashboard_featured_ad({Key key}) : super(key: key);

  @override
  _dashboard_featured_adState createState() => _dashboard_featured_adState();
}

class _dashboard_featured_adState extends State<dashboard_featured_ad> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
            ),
            Container(
              child: CupertinoButton(
                color: CupertinoColors.activeBlue,
                child: Text("Approved"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => dashboard_featured_ad_approved()));
                },
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              child: CupertinoButton(
                color: CupertinoColors.activeBlue,
                child: Text("Declined"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => dashboard_featured_ad_declined()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
