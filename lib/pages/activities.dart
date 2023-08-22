// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:lets_getaway/models/activity_model.dart';

import '../models/plan_model.dart';

class ActivitiesPage extends StatefulWidget {
  ActivitiesPage({Key? key, required this.plan}) : super(key: key);

  Plan plan;

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String dateShow = DateFormat.yMMMd().format(DateTime.now());
  late String timeStart, timeEnd;
  Color colorChoose = Colors.red;
  String dateAdd = '';
  List<Activity> listActivities = [];

  final nameController = TextEditingController();

  @override
  void initState() {
    getData();
    date = DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.plan.dateGo));
    dateShow = DateFormat.yMMMd().format(DateTime.parse(widget.plan.dateGo));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff86BACB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          color: Colors.white,
          onPressed: () => {Navigator.pop(context)},
        ),
        title: Text(
          "กิจกรรมที่จะทำ",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(0, 2),
                blurRadius: 3.0,
                color: Colors.grey,
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(dateShow,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
                Container(
                    width: 40,
                    height: 40,
                    padding: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xff4D7D8C)),
                    child: DateTimePicker(
                      type: DateTimePickerType.date,
                      dateMask: 'd MMM, yyyy',
                      initialValue: widget.plan.dateGo,
                      firstDate: DateTime.parse(widget.plan.dateGo),
                      lastDate: DateTime.parse(widget.plan.dateBack),
                      icon: Icon(
                        Icons.event,
                        size: 30,
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          date = value;
                          dateShow =
                              DateFormat.yMMMd().format(DateTime.parse(value));
                        });
                      },
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    addActivities();
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(90, 12, 90, 12),
                      primary: Color(0xff86BACB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      )),
                  child: Text('เพิ่มกิจกรรม',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: getActivities(),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }

  List<Widget> getActivities() {
    List listTime = [];
    for (var item in listActivities) {
      List splitTime = item.timeStart.split(':');
      if (listTime.isEmpty) {
        if (item.date == date) {
          listTime.add(splitTime[0]);
        }
      } else {
        if (!listTime.contains(splitTime[0])) {
          if (item.date == date) {
            listTime.add(splitTime[0]);
          }
        }
      }
    }
    listTime.sort();

    List<Widget> list = [];
    for (var item in listTime) {
      list.add(Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 25,
          ),
          Text(item + '.00 น.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
        ],
      ));

      list.add(SizedBox(
        height: 10,
      ));

      for (var item2 in listActivities) {
        List splitTime = item2.timeStart.split(':');
        if (item2.date == date) {
          if (splitTime[0] == item) {
            list.add(Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UnconstrainedBox(
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Color(int.parse(item2.colorCode)),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: Center(
                        child: Column(
                      children: [
                        Text(item2.activityName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        Text(item2.timeStart + ' - ' + item2.timeEnd,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ))
                      ],
                    )),
                  ),
                ),
              ],
            ));
          }
        }
      }
    }
    return list;
  }

  void addActivities() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'เพิ่มกิจกรรม',
              style: TextStyle(fontSize: 30),
            ),
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: ListBody(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 70,
                      width: 330,
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          suffixIcon: Icon(CupertinoIcons.pen),
                          hintText: 'ชื่อกิจกรรม',
                          hintStyle: TextStyle(
                              color: Colors.grey.shade400, fontSize: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 0.5, color: Color(0xffBFBEBE)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                        width: 170,
                        height: 80,
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.5, color: Color(0xffBFBEBE)),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: DateTimePicker(
                          type: DateTimePickerType.time,
                          icon: Icon(Icons.timer),
                          timeLabelText: 'เวลาเริ่มต้น',
                          onChanged: (value) {
                            setState(() {
                              timeStart = value;
                            });
                          },
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: 170,
                        height: 80,
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.5, color: Color(0xffBFBEBE)),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: DateTimePicker(
                          type: DateTimePickerType.time,
                          icon: Icon(Icons.timer),
                          timeLabelText: 'เวลาสิ้นสุด',
                          onChanged: (value) {
                            setState(() {
                              timeEnd = value;
                            });
                          },
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: 170,
                        height: 80,
                        padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.5, color: Color(0xffBFBEBE)),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: DateTimePicker(
                          type: DateTimePickerType.date,
                          dateMask: 'd MMM, yyyy',
                          initialValue: widget.plan.dateGo,
                          firstDate: DateTime.parse(widget.plan.dateGo),
                          lastDate: DateTime.parse(widget.plan.dateBack),
                          icon: Icon(Icons.event),
                          dateLabelText: 'วันที่ทำกิจกรรม',
                          onChanged: (val) => dateAdd = val,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'เลือกสีกิจกรรม',
                          style:
                              TextStyle(color: Color(0xff86BACB), fontSize: 16),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      content: BlockPicker(
                                    pickerColor: colorChoose,
                                    onColorChanged: (value) {
                                      setState(() {
                                        colorChoose = value;
                                      });
                                      Navigator.pop(context);
                                    },
                                  ));
                                });
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: colorChoose,
                                borderRadius: BorderRadius.circular(50)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            }),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.green, fontSize: 20),
                ),
                onPressed: () {
                  addActivitiesToDB();
                  Navigator.of(context).pop(true);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ActivitiesPage(plan: widget.plan)));
                },
              ),
              TextButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            ],
          );
        });
  }

  addActivitiesToDB() {
    FirebaseFirestore.instance.collection('ActivityPlan').add({
      'PlanID': widget.plan.id,
      'Date': dateAdd,
      'ActivityName': nameController.text,
      'TimeStart': timeStart,
      'TimeEnd': timeEnd,
      'ColorCode': colorChoose.value.toString()
    });
  }

  getData() async {
    var collection = FirebaseFirestore.instance.collection('ActivityPlan');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      listActivities.add(Activity(
          queryDocumentSnapshot.id,
          data['PlanID'],
          data['ActivityName'],
          data['ColorCode'],
          data['Date'],
          data['TimeEnd'],
          data['TimeStart']));
    }
    setState(() => {listActivities});
  }
}
