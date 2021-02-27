import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:major_project/screens/tv_channel/data.dart';
import 'package:major_project/screens/tv_channel/multi_form.dart';

typedef OnDelete();

class homespage extends StatefulWidget {
  final data Data;
  final state = _homespageState();
  final OnDelete onDelete;
  homespage({this.Data, this.onDelete});
  @override
  _homespageState createState() => state;
}

class _homespageState extends State<homespage> {
  List<multi_form> forms = [];
  DateTime _dateTime = DateTime.now();
  List dropdownlist = ["AM", "PM"];
  List dropdownlist2 = ["AM", "PM"];
  String valueChooser, valueChooser2;
  final form = GlobalKey<FormState>();
  List<data> datas = [];
  @override
  Widget build(BuildContext context) {
    forms.clear();
    for (int i = 0; i <= datas.length; i++) {
      forms.add(multi_form(
        Data: datas[i],
        onDelete: () => onDelete(i),
      ));
    }
    return Scaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
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
                        style: TextStyle(color: CupertinoColors.activeOrange),
                      ),
                    )
                  ],
                ),
                datas.length <= 0
                    ? Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: IconButton(
                                icon: Icon(CupertinoIcons.add_circled_solid),
                                onPressed: onAddForm,
                              ),
                            )
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: datas.length,
                        itemBuilder: (_, i) => multi_form(
                          Data: datas[i],
                          onDelete: () => onDelete(i),
                        ),
                      )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onDelete(int index) {
    setState(() {
      datas.removeAt(index);
    });
  }

  void onAddForm() {
    setState(() {
      datas.add(data());
    });
  }

  void onSave() {
    setState(() {
      forms.forEach((form) => form.isValid());
    });
  }
}
