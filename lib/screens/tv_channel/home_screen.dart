import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: Icon(CupertinoIcons.chevron_back),
        middle: Text(
          'online marketplace for TV Ads',
          style: TextStyle(color: CupertinoColors.activeBlue),
        ),
        trailing: Icon(CupertinoIcons.book_solid),
      ),
      child: Text(
        'Hello world',
      ),
    );
  }
}
