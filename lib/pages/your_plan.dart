// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:lets_getaway/models/plan_model.dart';
import 'package:lets_getaway/models/user_profile_model.dart';
import 'package:lets_getaway/pages/create_plan.dart';
import 'package:lets_getaway/pages/plan.dart';
import 'package:lets_getaway/pages/profile.dart';

import 'home.dart';
import 'request.dart';
import 'sent_freind.dart';

class YourPlanPage extends StatefulWidget {
  YourPlanPage({Key? key}) : super(key: key);

  @override
  State<YourPlanPage> createState() => _YourPlanPageState();
}

class _YourPlanPageState extends State<YourPlanPage> {
  int _selectedIndex = 3;
  List<Plan> listActivePlan = [];
  List<Plan> listEndPlan = [];
  var db = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  UserProfile userProfile =
      UserProfile('', 'username', 'birthDate', 'phoneNum', '', []);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => sent_freind()));
      }
      if (index == 1) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => request(
                      type: 1,
                    )));
      }
      if (index == 2) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
      if (index == 3) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => YourPlanPage()));
      }
      if (index == 4) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ProfilePage()));
      }
    });
  }

  @override
  void initState() {
    getUserProfile();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff86BACB),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            'แพลนทั้งหมด',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  checkImage(),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    firebaseUser!.displayName.toString(),
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.7,
                  decoration: BoxDecoration(
                      color: Color(0xffF5F5F5),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Text('แพลนที่ดำเนินการอยู่',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: getCurrentPlan(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Text('แพลนที่จบไปแล้ว',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: getEndPlan(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreatePlanPage()))
                        },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(110, 15, 110, 15),
                            primary: Color(0xff4D7D8C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            )),
                        child: Text('ADD PLAN',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 23)),
                      ),
                    ],
                  ))
            ],
          ),
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Color(0xff86BACB),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.auto_awesome_motion_outlined,
                    size: 30,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble, size: 30),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search, size: 30),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today, size: 30),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 30),
                label: '',
              ),
            ],
            currentIndex: _selectedIndex,
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.black,
            onTap: _onItemTapped,
          ),
        ));
  }

  List<Widget> getCurrentPlan() {
    List<Widget> list = [];
    for (var item in listActivePlan) {
      list.add(
        GestureDetector(
          onTap: () => {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => PlanPage(
                          plan: item,
                        )))
          },
          child: Container(
            width: 250,
            height: 130,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.planName,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.grey.shade400,
                      size: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      item.dateGo + ' to ' + item.dateBack,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade400,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: () => {confirmAlert(item.id)},
                  child: Container(
                      height: 35,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Text(
                        'จบแพลน',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                ),
              ],
            ),
          ),
        ),
      );

      list.add(
        SizedBox(
          width: 15,
        ),
      );
    }
    return list;
  }

  List<Widget> getEndPlan() {
    List<Widget> list = [];
    for (var item in listEndPlan) {
      list.add(
        Container(
          width: 250,
          height: 130,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.planName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: Colors.grey.shade400,
                    size: 18,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    item.dateGo + ' to ' + item.dateBack,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade400,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );

      list.add(
        SizedBox(
          width: 15,
        ),
      );
    }
    return list;
  }

  getData() async {
    var collection = db.collection('Plan');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      List<dynamic> users = data['Users'];
      if (data['User_Create'] == firebaseUser?.displayName ||
          users.contains(firebaseUser?.displayName)) {
        if (data['PlanStatus'] == 1 &&
            !listActivePlan.contains(Plan(
                queryDocumentSnapshot.id,
                data['DateBack'],
                data['DateGo'],
                data['PlaceBackLat'],
                data['PlaceBackLong'],
                data['PlaceGoLat'],
                data['PlaceGoLong'],
                data['PlanName'],
                data['PlanStatus'],
                data['User_Create'],
                data['Users']))) {
          //plan Activate
          listActivePlan.add(Plan(
              queryDocumentSnapshot.id,
              data['DateBack'],
              data['DateGo'],
              data['PlaceBackLat'],
              data['PlaceBackLong'],
              data['PlaceGoLat'],
              data['PlaceGoLong'],
              data['PlanName'],
              data['PlanStatus'],
              data['User_Create'],
              data['Users']));
        } else if (!listEndPlan.contains(Plan(
            queryDocumentSnapshot.id,
            data['DateBack'],
            data['DateGo'],
            data['PlaceBackLat'],
            data['PlaceBackLong'],
            data['PlaceGoLat'],
            data['PlaceGoLong'],
            data['PlanName'],
            data['PlanStatus'],
            data['User_Create'],
            data['Users']))) {
          listEndPlan.add(Plan(
              queryDocumentSnapshot.id,
              data['DateBack'],
              data['DateGo'],
              data['PlaceBackLat'],
              data['PlaceBackLong'],
              data['PlaceGoLat'],
              data['PlaceGoLong'],
              data['PlanName'],
              data['PlanStatus'],
              data['User_Create'],
              data['Users']));
        }
      }
    }
    setState(() => {listActivePlan, listEndPlan});
  }

  getUserProfile() async {
    var collection = FirebaseFirestore.instance.collection('User');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      if (data['Username'] == firebaseUser?.displayName) {
        userProfile = UserProfile(
            queryDocumentSnapshot.id,
            data['Username'],
            data['BirthDate'],
            data['PhoneNum'],
            data['Image'],
            data['Friends']);
      }
    }
    setState(() => userProfile);
  }

  Widget checkImage() {
    String img = userProfile.image;
    if (img == '') {
      return Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage('assets/images/user_profile.png'),
              fit: BoxFit.cover),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 5,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage(
            "https://firebasestorage.googleapis.com/v0/b/let-s-getaway.appspot.com/o/Travel%2F$img?alt=media&token=61953c21-6611-4cb5-bbdb-f393b492580b",
          )),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 5,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
      );
    }
  }

  endPlan(String id) {
    FirebaseFirestore.instance
        .collection('Plan')
        .doc(id)
        .update({'PlanStatus': 0});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => YourPlanPage()));
  }

  confirmAlert(String id) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'จบแพลน',
              style: TextStyle(fontSize: 30),
            ),
            content: SingleChildScrollView(
              child:
                  ListBody(children: <Widget>[Text("ยืนยันการจบแพลนหรือไม่?")]),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.green, fontSize: 25),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  endPlan(id);
                },
              ),
              TextButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red, fontSize: 25),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
