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
  String text = "no value Entered";
  String title;
  List dropdownlist = ["AM", "PM"];
  List dropdownlist2 = ["AM", "PM"];
  String valueChooser, valueChooser2;
  TextEditingController _noOfTimelineController = new TextEditingController();
  TextEditingController _startingtimeController = new TextEditingController();
  TextEditingController _endtimeController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();
  int noOfTimeline = 0;
  final form = GlobalKey<FormState>();
  int _value = 1;

  void _setText() {
    setState(() {
      text = title;
    });
  }

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
                            print(_dateTime);
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
                          setState(() {
                            noOfTimeline =
                                int.parse(_noOfTimelineController.text);
                          });
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                SingleChildScrollView(
                  child: Container(
                    height: 200,
                    child: ListView.builder(
                      itemCount: noOfTimeline,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 10,
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 100,
                                        child: TextField(
                                            decoration: InputDecoration(
                                                labelText: "Starting time"),
                                            keyboardType:
                                                TextInputType.datetime,
                                            onChanged: (value) {
                                              title = value + "$index";
                                            }),
                                      ),
                                      Container(
                                        child: RaisedButton(
                                          child: Text("press me"),
                                          onPressed: () {
                                            _setText();
                                          },
                                        ),
                                      ),
                                      Text(text),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    /* child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: [
                        for (int i = 1; i <= noOfTimeline; i++)
                          Container(
                            width: 250,
                            child: ListTile(
                              leading: Text("Timeline $i"),
                              trailing: IconButton(
                                icon: Icon(
                                  CupertinoIcons.add,
                                  color: CupertinoColors.activeBlue,
                                ),
                                onPressed: () {
                                  showCupertinoDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) =>
                                        CupertinoAlertDialog(
                                      content: Stack(
                                        overflow: Overflow.visible,
                                        alignment: Alignment.center,
                                        children: <Widget>[
                                          Column(
                                            children: [
                                              CupertinoTextField(
                                                controller:
                                                    _startingtimeController,
                                                placeholder: "Starting Time",
                                                keyboardType:
                                                    TextInputType.datetime,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              CupertinoTextField(
                                                controller: _endtimeController,
                                                placeholder: "Ending time",
                                                keyboardType:
                                                    TextInputType.datetime,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              CupertinoTextField(
                                                controller: _priceController,
                                                placeholder: "Price/Second",
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              CupertinoTextField(
                                                controller: _priceController,
                                                placeholder: "no of Ad Slots ",
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        CupertinoDialogAction(
                                          child: Text("create"),
                                          onPressed: () {
                                            Navigator.pop(context, false);
                                          },
                                        ),
                                        CupertinoDialogAction(
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                                color:
                                                    CupertinoColors.systemRed),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context, false);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                      ],
                    ),*/
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
