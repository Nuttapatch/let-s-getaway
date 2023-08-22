// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lets_getaway/models/user_profile_model.dart';
import 'package:lets_getaway/pages/activities.dart';
import 'package:lets_getaway/pages/expense.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/plan_model.dart';
import 'home.dart';
import 'profile.dart';
import 'request.dart';
import 'sent_freind.dart';
import 'your_plan.dart';

class PlanPage extends StatefulWidget {
  PlanPage({Key? key, required this.plan}) : super(key: key);

  Plan plan;

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  final nameController = TextEditingController();
  List<UserProfile> usersProfile = [], allUsers = [];

  int _selectedIndex = 3;

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
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff86BACB),
        extendBodyBehindAppBar: true,
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/plan_bg.png"),
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.dstATop))),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'แพลนของคุณ',
                      style: TextStyle(
                        fontSize: 35,
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
                      width: 320,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: showPeople(),
                          ),
                          SizedBox(
                            height: 10,
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
                                widget.plan.dateGo +
                                    ' to ' +
                                    widget.plan.dateBack,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade400,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.plan.planName,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () => {
                        _openOnGoogleMapApp(
                            double.parse(widget.plan.placeGoLat),
                            double.parse(widget.plan.placeGoLong),
                            double.parse(widget.plan.placeBackLat),
                            double.parse(widget.plan.placeBackLong))
                      },
                      child: Container(
                        width: 320,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 320,
                              height: 130,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/img_rectangle21.png'),
                                fit: BoxFit.fill,
                              )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'แผนที่',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ActivitiesPage(
                                          plan: widget.plan,
                                        )))
                          },
                          child: Container(
                            width: 160,
                            height: 110,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/img_watersportski.png',
                                  height: 60,
                                  width: 60,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child: Text(
                                    'กิจกรรมที่จะทำ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ExpensePage(
                                          allUser: usersProfile,
                                          plan: widget.plan,
                                        )))
                          },
                          child: Container(
                            width: 160,
                            height: 110,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/img_money.png',
                                  height: 60,
                                  width: 60,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child: Text(
                                    'หารค่าใช้จ่าย',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
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

  Widget showAddPeople() {
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
                suffixIcon: IconButton(
                    onPressed: () {
                      addPeople();
                    },
                    icon: Icon(Icons.add)),
                hintText: 'เพิ่ม username ของผู้ใช้',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(width: 0.5, color: Color(0xffBFBEBE)),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          Column(
            children: showListPeopleAdd(),
          )
        ],
      ),
    );
  }

  List<Widget> showListPeopleAdd() {
    List<Widget> list = [];
    for (var item in widget.plan.usersInPlan) {
      int index = 0;
      for (var item2 in usersProfile) {
        if (item2.username == item) {
          index = usersProfile.indexOf(item2);
          break;
        }
      }
      String img = usersProfile.elementAt(index).image;
      if (img == '') {
        list.add(Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage('assets/images/user_profile.png'),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              usersProfile.elementAt(index).username,
              style: TextStyle(fontSize: 15),
            )
          ],
        ));
      } else {
        list.add(Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/let-s-getaway.appspot.com/o/Travel%2F$img?alt=media&token=61953c21-6611-4cb5-bbdb-f393b492580b",
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              usersProfile.elementAt(index).username,
              style: TextStyle(fontSize: 15),
            )
          ],
        ));
      }
    }

    return list;
  }

  addPeople() {
    bool isFound = false;
    bool isSame = false;
    for (var item in allUsers) {
      if (nameController.text == item.username) {
        isFound = true;
        for (var item2 in usersProfile) {
          if (item2.username == nameController.text) {
            isFound = false;
            isSame = true;
            break;
          }
        }
      }
    }

    if (isFound) {
      widget.plan.usersInPlan.add(nameController.text);
      FirebaseFirestore.instance
          .collection('Plan')
          .doc(widget.plan.id)
          .update({'Users': widget.plan.usersInPlan});
      Fluttertoast.showToast(msg: "เพิ่มสำเร็จ", gravity: ToastGravity.BOTTOM);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => PlanPage(
                    plan: widget.plan,
                  )));
    } else {
      if (isSame) {
        Fluttertoast.showToast(
            msg: "ผู้ใช้อยู่ในแพลนแล้ว", gravity: ToastGravity.BOTTOM);
      } else {
        Fluttertoast.showToast(
            msg: "ไม่พบ username ผู้ใช้", gravity: ToastGravity.BOTTOM);
      }
    }
  }

  List<Widget> showPeople() {
    List<Widget> list = [];
    double mar = 0;
    if (usersProfile.isNotEmpty) {
      for (var item in widget.plan.usersInPlan) {
        int index = 0;
        for (var item2 in usersProfile) {
          if (item2.username == item) {
            index = usersProfile.indexOf(item2);
          }
        }
        String img = usersProfile.elementAt(index).image;
        if (img == '') {
          list.add(Container(
            margin: EdgeInsets.fromLTRB(mar, 0, 0, 0),
            width: 60,
            height: 60,
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
          ));
        } else {
          list.add(Container(
            margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(
                "https://firebasestorage.googleapis.com/v0/b/let-s-getaway.appspot.com/o/User%2F$img?alt=media&token=61953c21-6611-4cb5-bbdb-f393b492580b",
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
          ));
        }
        mar += 10;
      }

      mar += 10;

      list.add(GestureDetector(
          onTap: () async {
            return await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'ผู้คนในแพลน',
                      style: TextStyle(fontSize: 30),
                    ),
                    content: showAddPeople(),
                    actions: <Widget>[
                      TextButton(
                        child: Text(
                          'Confirm',
                          style: TextStyle(color: Colors.green, fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false);
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
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(mar, 0, 0, 0),
            width: 60,
            height: 60,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Color(0xff86BACB)),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 40,
            ),
          )));
    } else {
      list.add(Container(
        width: 60,
        height: 60,
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
      ));
    }
    return list;
  }

  getUsers() async {
    var collection = FirebaseFirestore.instance.collection('User');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      allUsers.add(UserProfile(queryDocumentSnapshot.id, data['Username'],
          data['BirthDate'], data['PhoneNum'], data['Image'], data['Friends']));
      if (widget.plan.usersInPlan.contains(data['Username'])) {
        usersProfile.add(UserProfile(
            queryDocumentSnapshot.id,
            data['Username'],
            data['BirthDate'],
            data['PhoneNum'],
            data['Image'],
            data['Friends']));
      }
    }
    setState(() => {usersProfile, allUsers});
  }

  _openOnGoogleMapApp(
      double latGo, double longGo, double latBack, double longBack) async {
    String googleUrl =
        'https://www.google.com/maps/dir/?api=1&origin=$latGo,$longGo&destination=$latBack,$longBack';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    }
  }
}
