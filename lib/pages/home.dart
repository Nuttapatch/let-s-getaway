// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_getaway/models/user_profile_model.dart';
import 'package:lets_getaway/pages/profile.dart';
import 'package:lets_getaway/pages/request.dart';
import 'package:lets_getaway/pages/search_homestay.dart';
import 'package:lets_getaway/pages/search_restaurant.dart';
import 'package:lets_getaway/pages/search_travelplace.dart';
import 'package:lets_getaway/pages/sent_freind.dart';
import 'package:lets_getaway/pages/your_plan.dart';

import 'start.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserProfile userProfile = UserProfile('', '', '', '', '', []);
  int _selectedIndex = 2;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    getUserProfile();
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => sent_freind()));
      }
      if (index == 1) {
        Navigator.push(
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
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            actions: [
              IconButton(
                  onPressed: () async => {
                        await FirebaseAuth.instance.signOut(),
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StartPage()))
                      },
                  icon: Icon(Icons.logout))
            ]),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/home_bg.png"),
                  fit: BoxFit.fill)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 70,
                ),
                checkImage(),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Hello!',
                  style: TextStyle(
                    fontSize: 20,
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
                  height: 10,
                ),
                Text(
                  firebaseUser?.displayName.toString() as String,
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
                  height: 10,
                ),
                Text(
                  firebaseUser?.email.toString() as String,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
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
                Expanded(
                    child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                    ),
                    Center(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => search_homestay()));
                            },
                            child: Container(
                              alignment: Alignment.topCenter,
                              height: 170,
                              width: 170,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffF3E6D5)),
                                    child: Image.asset(
                                        'assets/images/img_pngegg61.png'),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'ค้นหาที่พัก',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              search_restaurant()));
                                },
                                child: Container(
                                  alignment: Alignment.topCenter,
                                  height: 170,
                                  width: 170,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xffF1C7CB)),
                                        child: Image.asset(
                                            'assets/images/resturant_icon.png'),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'ค้นหาร้านอาหาร',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SearchTravelPlacePage()));
                                },
                                child: Container(
                                  alignment: Alignment.topCenter,
                                  height: 170,
                                  width: 170,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xffCBEAF3)),
                                        child: Image.asset(
                                            'assets/images/img_aroundtheglob.png'),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'ค้นหาสถานที่ท่องเที่ยว',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ))
              ],
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
        break;
      }
    }
    if (userProfile.username != '') {
      setState(() {});
    }
  }
}
