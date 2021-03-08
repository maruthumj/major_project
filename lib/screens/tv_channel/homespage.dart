import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:major_project/screens/tv_channel/multi_form.dart';

class homespage extends StatefulWidget {
  homespage({Key key}) : super(key: key);

  @override
  _homespageState createState() => _homespageState();
}

class _homespageState extends State<homespage> {
  List<multi_form> forms = [];
  int num = 0;
  DateTime _dateTime = DateTime.now();
  List dropdownlist = ["AM", "PM"];
  List dropdownlist2 = ["AM", "PM"];
  String valueChooser, valueChooser2;
  TextEditingController _noOfTimelineController = new TextEditingController();

  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
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
