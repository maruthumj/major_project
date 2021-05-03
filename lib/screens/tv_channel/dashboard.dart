import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:major_project/screens/tv_channel/dashboard_normal_ad.dart';
import 'package:major_project/screens/tv_channel/dashboard_featured_ad.dart';
import 'package:major_project/screens/tv_channel/dashboard_auction_ad.dart';

class dashboard extends StatefulWidget {
  dashboard({Key key}) : super(key: key);

  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  int num = 0;
  DateTime _dateTime = DateTime.now();
  List dropdownlist = ["AM", "PM"];
  List dropdownlist2 = ["AM", "PM"];
  String valueChooser, valueChooser2;
  TextEditingController _noOfTimelineController = new TextEditingController();

  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
        appBar: AppBar(
          backgroundColor: CupertinoColors.systemRed,
          automaticallyImplyLeading: false,
          leading: SizedBox(
            width: 100,
          ),
          title: Text("               Dashboard"),
          bottom: TabBar(
            indicatorColor: CupertinoColors.extraLightBackgroundGray,
            tabs: [
              Tab(
                text: "Normal Ad",
              ),
              Tab(
                text: "Featured Ad",
              ),
              /* Tab(
                text: "Auction Ad",
              ),*/
            ],
          ),
        ),
        body: TabBarView(
          children: [
            dashboard_normal_ad(),
            dashboard_featured_ad(),
            //  dashboard_auction_ad(),
          ],
        ),
      ),
    );
  }
}
