import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class auction_ad extends StatefulWidget {
  @override
  _auction_adState createState() => _auction_adState();
}

class _auction_adState extends State<auction_ad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      appBar: AppBar(
        backgroundColor: CupertinoColors.lightBackgroundGray,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.chevron_back,
            color: CupertinoColors.activeBlue,
          ),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        title: Text("         Auction Ad",
          style: TextStyle(color: CupertinoColors.activeBlue),),
      ),
    );
  }
}
