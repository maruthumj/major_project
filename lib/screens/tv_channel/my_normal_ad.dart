import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class my_normal_ad extends StatefulWidget {
  my_normal_ad({Key key}) : super(key: key);

  @override
  _my_normal_adState createState() => _my_normal_adState();
}

class _my_normal_adState extends State<my_normal_ad> {
  FirebaseAuth fauth = FirebaseAuth.instance;
  FirebaseFirestore fstore = FirebaseFirestore.instance;
  String channel_name = '';
  String starting_time = '',
      ending_time = '',
      break_starting_time = '',
      break_ending_time = '',
      price_per_second = '',
      adlength = '',
      adslots = '',
      date = '';

  int _myDoc;
  @override
  void initState() {
    super.initState();
  }

  Future<void> getchannelname() async {}

  Future<void> countDocuments() async {}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Stack(
      children: [
        Column(
          children: [],
        )
      ],
    ));
  }
}
