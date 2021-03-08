import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class featured_ad extends StatefulWidget {
  featured_ad({Key key}) : super(key: key);

  @override
  _featured_adState createState() => _featured_adState();
}

class _featured_adState extends State<featured_ad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
        leading: IconButton(
          icon: Icon(CupertinoIcons.chevron_back),
          color: CupertinoColors.activeBlue,
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [],
            )
          ],
        ),
      ),
    );
  }
}
