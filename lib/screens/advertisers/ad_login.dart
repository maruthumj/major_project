import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ad_Login extends StatelessWidget {
  const Ad_Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Advertisers Login',
          textAlign: TextAlign.center,
          style: TextStyle(color: CupertinoColors.activeBlue),
        ),
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.chevron_back,
            color: CupertinoColors.activeBlue,
          ),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
      ),
      body: SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
