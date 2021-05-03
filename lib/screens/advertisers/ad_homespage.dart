import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:major_project/screens/advertisers/ad_normal_ad.dart';
import 'package:major_project/screens/advertisers/ad_featured_ad.dart';
import 'package:major_project/screens/advertisers/ad_auction_ad.dart';

class homespage extends StatefulWidget {
  homespage({Key key}) : super(key: key);

  @override
  _homespageState createState() => _homespageState();
}

class _homespageState extends State<homespage> {
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
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Normal Ad",
              ),
              Tab(
                text: "Featured Ad",
              ),
              /*   Tab(
                text: "Auction Ad",
              ),*/
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ad_normal_ad(),
            ad_featured_ad(),
            // ad_auction_ad(),
          ],
        ),
      ),
    );
  }
}

/*class timeline extends StatefulWidget {
  timeline({Key key}) : super(key: key);

  @override
  _timelineState createState() => _timelineState();
}

class _timelineState extends State<timeline> {
  TextEditingController _startingtimeController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Form(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _startingtimeController,
                  decoration: InputDecoration(
                    labelText: 'Starting time',
                  ),
                  keyboardType: TextInputType.datetime,
                ),
                TextFormField(
                  controller: _startingtimeController,
                  decoration: InputDecoration(
                    labelText: 'Ending time',
                  ),
                  keyboardType: TextInputType.datetime,
                ),
              ],
            ),
          ),
          Form(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Price/Second',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/
