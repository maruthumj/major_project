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
  int _value = 1;

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

                    child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: [
                        for (int i = 1; i <= noOfTimeline; i++)
         
                           Container(
                            width: 250,
                            child: ListTile(
                              leading:Text("Timeline $i"),
                              trailing: IconButton(icon:Icon(CupertinoIcons.add,color: CupertinoColors.activeBlue,),
                                onPressed: (){
                                  showCupertinoDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) =>
                                        CupertinoAlertDialog(

                                          content: Stack(
                                            overflow: Overflow.visible,
                                            alignment: Alignment.center,
                                            children: <Widget>[
                                              SingleChildScrollView(
                                                child: Container(
                                                  height:700,
                                                  width: double.infinity,
                                                  child:Column(

                                                    children: [

                                                       Container(
                                                        width:50,
                                                        height: 30,
                                                        child: DropdownButton(
                                                            value: _value,
                                                            items: [
                                                              DropdownMenuItem(
                                                                child: Text("First Item"),
                                                                value: 1,
                                                              ),
                                                              DropdownMenuItem(
                                                                child: Text("Second Item"),
                                                                value: 2,
                                                              ),

                                                            ],
                                                            onChanged: (value) {
                                                              setState(() {
                                                                _value = value;
                                                              });
                                                            }),
                                                      ),

                                                  ],
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),                                          actions: [
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



                                }, ),),

                          ),

                      ],
                    ),
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
