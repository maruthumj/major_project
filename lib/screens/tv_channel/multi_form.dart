import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:major_project/screens/tv_channel/data.dart';
import 'package:flutter/foundation.dart';

typedef OnDelete();

class multi_form extends StatefulWidget {
  final data Data;
  final state = _multi_formState();
  final OnDelete onDelete;
  multi_form({this.Data, this.onDelete});
  @override
  _multi_formState createState() => state;
  bool isValid() => state.validate();
}

class _multi_formState extends State<multi_form> {
  final form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Card(
        child: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                backgroundColor: CupertinoColors.extraLightBackgroundGray,
                title: Text(
                  "TimeLine",
                  style: TextStyle(color: CupertinoColors.activeBlue),
                ),
                centerTitle: true,
                leading: Icon(CupertinoIcons.clock_fill),
                actions: [
                  IconButton(
                    icon: Icon(CupertinoIcons.bin_xmark),
                    onPressed: () {},
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: widget.Data.startingtime,
                    onSaved: (val) => widget.Data.startingtime = val,
                    validator: (val) => val.length > 1 ? null : 'invalid time',
                    decoration: InputDecoration(labelText: 'Starting time'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  TextFormField(
                    initialValue: widget.Data.endtime,
                    onSaved: (val) => widget.Data.endtime = val,
                    validator: (val) => val.length > 1 ? null : 'invalid time',
                    decoration: InputDecoration(labelText: 'End time'),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    initialValue: widget.Data.price,
                    onSaved: (val) => widget.Data.startingtime = val,
                    validator: (val) => val.length > 1 ? null : 'invalid time',
                    decoration: InputDecoration(labelText: 'Starting time'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validate() {
    var valid = form.currentState.validate();
    if (valid) form.currentState.save();
    return valid;
  }
}

/*Card(
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AppBar(
                          backgroundColor:
                              CupertinoColors.extraLightBackgroundGray,
                          title: Text(
                            "TimeLine",
                            style: TextStyle(color: CupertinoColors.activeBlue),
                          ),
                          centerTitle: true,
                          leading: Icon(CupertinoIcons.clock_fill),
                          actions: [
                            IconButton(
                              icon: Icon(CupertinoIcons.bin_xmark),
                              onPressed: () {},
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextFormField(
                              initialValue: widget.Data.startingtime,
                              onSaved: (val) => widget.Data.startingtime = val,
                              validator: (val) =>
                                  val.length > 1 ? null : 'invalid time',
                              decoration:
                                  InputDecoration(labelText: 'Starting time'),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            TextFormField(
                              initialValue: widget.Data.endtime,
                              onSaved: (val) => widget.Data.endtime = val,
                              validator: (val) =>
                                  val.length > 1 ? null : 'invalid time',
                              decoration:
                                  InputDecoration(labelText: 'End time'),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                )*/
