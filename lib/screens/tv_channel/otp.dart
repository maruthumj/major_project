import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class otp_screen extends StatefulWidget {
  final String phone;
  otp_screen(this.phone);

  @override
  _otp_screenState createState() => _otp_screenState();
}

class _otp_screenState extends State<otp_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
        title: Text(
          "OTP Verification",
          style: TextStyle(color: CupertinoColors.activeBlue),
        ),
        leading: IconButton(
          color: CupertinoColors.activeBlue,
          icon: Icon(CupertinoIcons.chevron_back),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}
