// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields, dead_code

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';
import 'package:lets_getaway/pages/plan.dart';
import 'package:lets_getaway/pages/select_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lets_getaway/pages/your_plan.dart';

class CreatePlanPage extends StatefulWidget {
  CreatePlanPage({Key? key}) : super(key: key);

  @override
  State<CreatePlanPage> createState() => _CreatePlanPageState();
}

class _CreatePlanPageState extends State<CreatePlanPage> {
  final planNameController = TextEditingController();
  final startPointController = TextEditingController();
  final desPointController = TextEditingController();

  String dateGo = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String dateBack = DateFormat('yyyy-MM-dd').format(DateTime.now());

  final formkey = GlobalKey<FormState>();

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
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(
                'สร้างแพลนของคุณ',
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
              SizedBox(
                height: 20,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 30),
                            Text(
                              'ชื่อแพลน',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff86BACB),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 80,
                          width: 360,
                          child: TextFormField(
                            controller: planNameController,
                            decoration: InputDecoration(
                              hintText: 'Plan Name',
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
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "กรุณากรอกชื่อแพลน";
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                                  initialValue: DateTime.now().toString(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                  icon: Icon(Icons.event),
                                  dateLabelText: 'วันที่ไป',
                                  onChanged: (val) => dateGo = val,
                                )),
                            SizedBox(
                              width: 10,
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
                                initialValue: DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day + 1)
                                    .toString(),
                                firstDate: DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day + 1),
                                lastDate: DateTime(2100),
                                icon: Icon(Icons.event),
                                dateLabelText: 'วันที่กลับ',
                                onChanged: (val) => dateBack = val,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 40),
                            Text(
                              'จุดเริ่มต้น',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff86BACB),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 80,
                          width: 350,
                          child: TextFormField(
                            controller: startPointController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () => {GetCoordMap(context, 1)},
                                  icon: Icon(Icons.map)),
                              hintText: 'Starting point',
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
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "กรุณาเลือกจุดเริ่มต้น";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 40),
                            Text(
                              'จุดปลายทาง',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff86BACB),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 80,
                          width: 350,
                          child: TextFormField(
                            controller: desPointController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () => {GetCoordMap(context, 2)},
                                  icon: Icon(Icons.map)),
                              hintText: 'Destination point',
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
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "กรุณาเลือกจุดปลายทาง";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        ElevatedButton(
                          onPressed: () => {
                            if (formkey.currentState!.validate()) {createPlan()}
                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(110, 15, 110, 15),
                              primary: Color(0xff4D7D8C),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              )),
                          child: Text('Create Plan',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23)),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void GetCoordMap(BuildContext context, int type) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectMap()),
    );

    if (type == 1) {
      setState(() {
        startPointController.text = result;
      });
    } else {
      setState(() {
        desPointController.text = result;
      });
    }
  }

  createPlan() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    List coordListGo = startPointController.text.split(', ');
    List coordListBack = desPointController.text.split(', ');
    List<String> listUsers = [firebaseUser?.displayName as String];
    FirebaseFirestore.instance.collection('Plan').add({
      'PlanName': planNameController.text,
      'DateGo': dateGo,
      'DateBack': dateBack,
      'PlaceGoLat': coordListGo[0],
      'PlaceGoLong': coordListGo[1],
      'PlaceBackLat': coordListBack[0],
      'PlaceBackLong': coordListBack[1],
      'PlanStatus': 1,
      'User_Create': firebaseUser?.displayName,
      'Users': listUsers
    });
    Fluttertoast.showToast(
        msg: "สร้างแพลนสำเร็จ", gravity: ToastGravity.BOTTOM);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => YourPlanPage()));
  }
}
