import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class normal_ad extends StatefulWidget {
  normal_ad({Key key}) : super(key: key);

  @override
  _normal_adState createState() => _normal_adState();
}

class _normal_adState extends State<normal_ad> {
  int num = 0;

  DateTime _dateTime = DateTime.now();
  List dropdownlist = ["AM", "PM"];
  List dropdownlist2 = ["AM", "PM"];
  String valueChooser, valueChooser2;
  TextEditingController _noOfTimelineController = new TextEditingController();
  TextEditingController _startingtimeController = new TextEditingController();
  TextEditingController _endtimeController = new TextEditingController();
  int noOfTimeline = 0;
  final form = GlobalKey<FormState>();
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
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "TimeLine Date",
                      style: TextStyle(
                          color: CupertinoColors.activeOrange, fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 350,
                      child: CupertinoDatePicker(
                        backgroundColor: CupertinoColors.white,
                        initialDateTime: _dateTime,
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (dateTime) {
                          print(dateTime);
                          setState(() {
                            _dateTime = dateTime;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        "Timeline",
                        style: TextStyle(
                            color: CupertinoColors.activeOrange,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      child: CupertinoTextField(
                        controller: _noOfTimelineController,
                        placeholder: "number of Timelines",
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(CupertinoIcons.add_circled_solid),
                        onPressed: () {
                          noOfTimeline =
                              int.parse(_noOfTimelineController.text);
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: SingleChildScrollView(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: [
                        for (int i = 0; i < noOfTimeline; i++)
                          Card(
                            elevation: 5,
                            child: ListTile(
                              leading: CupertinoTextField(
                                placeholder: "starting time",
                                controller: _startingtimeController,
                                keyboardType: TextInputType.datetime,
                              ),
                              title: CupertinoTextField(
                                controller: _endtimeController,
                                placeholder: "Ending time",
                                keyboardType: TextInputType.datetime,
                              ),
                              trailing: IconButton(
                                icon: Icon(CupertinoIcons.add_circled_solid),
                                onPressed: () {},
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
