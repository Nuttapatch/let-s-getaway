// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:lets_getaway/models/chat_show.dart';
import 'package:lets_getaway/models/user_profile_model.dart';
import 'package:lets_getaway/pages/chat.dart';
import 'package:lets_getaway/pages/sent_freind.dart';

import '../models/Request_model.dart';
import '../models/chat_model.dart';
import 'chat_1.dart';
import 'home.dart';
import 'profile.dart';
import 'your_plan.dart';

class request extends StatefulWidget {
  request({Key? key, required this.type}) : super(key: key);

  int type;

  @override
  State<request> createState() => _requestState();
}

class _requestState extends State<request> {
  int _selectedIndex = 4;
  List<Request> listRequest = [];
  var firebaseUser = FirebaseAuth.instance.currentUser;
  List<UserProfile> listallUser = [];
  UserProfile userProfile = UserProfile('', '', '', '', '', []);
  List<ChatShow> listChat = [];
  List<Chat> lastChatMsg = [];

  @override
  void initState() {
    getdata();
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
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Color(0xff4D7D8C),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "Let's Getaway ",
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: getFriends(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.type == 1
                          ? GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => request(
                                              type: 1,
                                            )));
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.person_add_rounded,
                                    color: Colors.green,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Request",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => request(
                                              type: 1,
                                            )));
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
                      widget.type == 2
                          ? GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => request(
                                              type: 2,
                                            )));
                              },
                              child: Row(
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
                            )
                          : GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => request(
                                              type: 2,
                                            )));
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.chat,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Chat",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                widget.type == 1
                    ? Column(
                        children: getlistRequest(),
                      )
                    : Column(
                        children: getListChat(),
                      )
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

  getdata() async {
    var collection = FirebaseFirestore.instance.collection('Request');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();

      if (data['UserRecieve'] == firebaseUser?.displayName) {
        listRequest.add(Request(queryDocumentSnapshot.id, data['Status'],
            data['UserRecieve'], data['UserSend']));
        break;
      }
    }

    var collection2 = FirebaseFirestore.instance.collection('User');
    var querySnapshot2 = await collection2.get();
    for (var queryDocumentSnapshot in querySnapshot2.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      if (data['Username'] == firebaseUser!.displayName) {
        userProfile = UserProfile(
            queryDocumentSnapshot.id,
            data['Username'],
            data['BirthDate'],
            data['PhoneNum'],
            data['Image'],
            data['Friends']);
      }
      listallUser.add(UserProfile(queryDocumentSnapshot.id, data['Username'],
          data['BirthDate'], data['PhoneNum'], data['Image'], data['Friends']));
    }

    var collection3 = FirebaseFirestore.instance.collection('Chat');
    var querySnapshot3 = await collection3.get();
    for (var queryDocumentSnapshot in querySnapshot3.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();

      if (data['user1'] == firebaseUser?.displayName ||
          data['user2'] == firebaseUser?.displayName) {
        if (data['user1'] == firebaseUser?.displayName) {
          listChat.add(
              ChatShow(queryDocumentSnapshot.id, data['user1'], data['user2']));
        } else if (data['user2'] == firebaseUser?.displayName) {
          listChat.add(
              ChatShow(queryDocumentSnapshot.id, data['user2'], data['user1']));
        }
        break;
      }
    }

    for (var item in listChat) {
      var collection4 = FirebaseFirestore.instance
          .collection('Chat')
          .doc(item.id)
          .collection('Message');
      var querySnapshot4 = await collection4.get();
      for (var queryDocumentSnapshot in querySnapshot4.docs) {
        Map<String, dynamic> data = queryDocumentSnapshot.data();
        lastChatMsg.add(Chat(queryDocumentSnapshot.id, data['msg'],
            data['date'], data['time'], data['userReceive'], data['userSend']));
        break;
      }
    }

    setState(() {
      userProfile;
      listRequest;
      listChat;
      lastChatMsg;
      listallUser;
    });
  }

  List<Widget> getlistRequest() {
    List<Widget> list = [];
    for (var item in listRequest) {
      String img = "";
      for (var item2 in listallUser) {
        if (item2.username == item.userSend) {
          img = item2.image;
        }
      }
      if (img == "") {
        list.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/images/user_profile.png",
                  ),
                  radius: 25,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  item.userSend,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.cancel_sharp),
                  color: Colors.white,
                  iconSize: 35,
                  onPressed: () {
                    deniedFriend(item.id);
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                IconButton(
                  onPressed: () {
                    acceptfriend(item.userSend, item.id);
                  },
                  iconSize: 35,
                  color: Colors.white,
                  icon: Icon(CupertinoIcons.check_mark_circled_solid),
                )
              ],
            ),
          ],
        ));
      } else {
        list.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/let-s-getaway.appspot.com/o/User%2F$img?alt=media&token=61953c21-6611-4cb5-bbdb-f393b492580b",
                  ),
                  radius: 25,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  item.userSend,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.cancel_sharp),
                  color: Colors.white,
                  iconSize: 35,
                  onPressed: () {
                    deniedFriend(item.id);
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                IconButton(
                  onPressed: () {
                    acceptfriend(item.userSend, item.id);
                  },
                  iconSize: 35,
                  color: Colors.white,
                  icon: Icon(CupertinoIcons.check_mark_circled_solid),
                )
              ],
            ),
          ],
        ));
      }
    }

    return list;
  }

  List<Widget> getListChat() {
    List<Widget> list = [];
    for (var i = 0; i < listChat.length; i++) {
      String img = "";
      String username = "";
      UserProfile userChat = UserProfile('', '', '', '', '', []);
      for (var item2 in listallUser) {
        if (item2.username == listChat[i].user2) {
          img = item2.image;
          username = item2.username;
          userChat = UserProfile(item2.id, item2.username, item2.birthDate,
              item2.phoneNum, item2.image, item2.friends);
        }
      }
      String msg = "";
      if (lastChatMsg[i].userSend == firebaseUser?.displayName) {
        msg = "You: " + lastChatMsg[i].sentence;
      } else {
        msg = lastChatMsg[i].sentence;
      }
      if (img == "") {
        list.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => chat(
                            user: userChat,
                            docID: listChat[i].id,
                          ))),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/images/user_profile.png",
                    ),
                    radius: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Text(
                        username,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        msg,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  lastChatMsg[i].date,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ));
      }
    }
    return list;
  }

  acceptfriend(String username, String id) {
    List users = userProfile.friends;
    users.add(username);
    FirebaseFirestore.instance
        .collection('User')
        .doc(userProfile.id)
        .update({'Friends': users});

    UserProfile user = UserProfile('', '', '', '', '', []);
    for (var item in listallUser) {
      if (item.username == username) {
        user = item;
      }
    }
    List users2 = user.friends;
    users2.add(userProfile.username);
    FirebaseFirestore.instance
        .collection('User')
        .doc(user.id)
        .update({'Friends': users2});

    FirebaseFirestore.instance.collection('Request').doc(id).delete();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => request(
                  type: 1,
                )));
  }

  deniedFriend(String id) {
    FirebaseFirestore.instance.collection('Request').doc(id).delete();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => request(
                  type: 1,
                )));
  }

  List<Widget> getFriends() {
    List<Widget> list = [];
    for (var item in userProfile.friends) {
      String img = "";
      UserProfile userChat = UserProfile('', '', '', '', '', []);
      var docID = '';
      for (var item2 in listChat) {
        if (item2.user2 == item) {
          docID = item2.id;
        }
      }
      for (var item2 in listallUser) {
        if (item2.username == item) {
          img = item2.image;
          userChat = UserProfile(item2.id, item2.username, item2.birthDate,
              item2.phoneNum, item2.image, item2.friends);
        }
      }
      if (img == '') {
        list.add(GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => chat(
                        user: userChat,
                        docID: docID,
                        //userSendToId: item,
                      ))),
          child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/user_profile.png"),
                    fit: BoxFit.fill,
                  ),
                  color: Color(0xff86BACB),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  SizedBox(
                    height: 120,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Row(
                      children: [
                        Text(
                          item,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0, 2),
                                blurRadius: 3.0,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ));
      } else {
        list.add(GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => chat(
                        user: userChat,
                        docID: docID,
                        //userSendToId: item,
                      ))),
          child: Container(
              width: 150,
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(
                  "https://firebasestorage.googleapis.com/v0/b/let-s-getaway.appspot.com/o/User%2F$img?alt=media&token=61953c21-6611-4cb5-bbdb-f393b492580b",
                ),
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
                          item,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0, 2),
                                blurRadius: 3.0,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ));
      }
      list.add(
        SizedBox(
          width: 10,
        ),
      );
    }
    return list;
  }
}
