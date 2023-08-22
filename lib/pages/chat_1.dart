import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:lets_getaway/pages/request.dart';
import 'package:lets_getaway/pages/sent_freind.dart';
import 'package:lets_getaway/pages/your_plan.dart';

import 'home.dart';
import 'profile.dart';

class chat_1 extends StatefulWidget {
  chat_1({Key? key}) : super(key: key);

  @override
  State<chat_1> createState() => _chat_1State();
}

class _chat_1State extends State<chat_1> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => sent_freind()));
      }
      if (index == 1) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => request(type: 1,)));
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
        backgroundColor: Color(0xff4D7D8C),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "Let's Gataway ",
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 4, left: 20, right: 20, bottom: 0),
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                ),
                Row(
                  children: [
                    Text(
                      "Friends",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                ImageSlideshow(
                  width: double.infinity,
                  initialPage: 0,
                  indicatorColor: Colors.orangeAccent,
                  indicatorBackgroundColor: Color(0xFFFFD9BF),
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                              width: 150,
                              height: 200,
                              decoration: new BoxDecoration(
                                  image: new DecorationImage(
                                image: new AssetImage(
                                    "assets/images/img_s216678523.png"),
                                fit: BoxFit.fill,
                              )),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 170,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Amm",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                              width: 150,
                              height: 200,
                              decoration: new BoxDecoration(
                                  image: new DecorationImage(
                                image: new AssetImage(
                                    "assets/images/img_s216678523.png"),
                                fit: BoxFit.fill,
                              )),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 170,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Amm",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                              width: 150,
                              height: 200,
                              decoration: new BoxDecoration(
                                  image: new DecorationImage(
                                image: new AssetImage(
                                    "assets/images/img_s216678523.png"),
                                fit: BoxFit.fill,
                              )),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 170,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Amm",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                  ],
                  autoPlayInterval: 5000,
                  isLoop: true,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => request(type: 1,)));
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.person_add_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Request",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.chat,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Chat",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                
              ],
            ),
          ),
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.auto_awesome_motion_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                label: "",
                backgroundColor: Color(0xff86BACB),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat_bubble,
                  color: Colors.white,
                  size: 30,
                ),
                label: "",
                backgroundColor: Color(0xff86BACB),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
                label: "",
                backgroundColor: Color(0xff86BACB),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                  size: 30,
                ),
                label: "",
                backgroundColor: Color(0xff86BACB),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 30,
                ),
                label: "",
                backgroundColor: Color(0xff86BACB),
              ),
            ],
            currentIndex: _selectedIndex,
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.black,
            onTap: _onItemTapped,
          ),
        ));
  }
}
