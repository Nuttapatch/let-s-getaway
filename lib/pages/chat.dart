// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lets_getaway/models/chat_model.dart';
import 'package:lets_getaway/models/user_profile_model.dart';
import 'package:lets_getaway/pages/request.dart';

class chat extends StatefulWidget {
  chat({Key? key, required this.user, required this.docID}) : super(key: key);

  UserProfile user;
  var docID;
  //String userSendToId;

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  List<Chat> listChat = [];
  var firebaseUser = FirebaseAuth.instance.currentUser;
  final textController = TextEditingController();

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff4D7D8C),
      appBar: AppBar(
        backgroundColor: Color(0xff86BACB),
        iconTheme: IconThemeData(color: Colors.black),
        title: Row(
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
              widget.user.username,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ],
        ),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onTap: () => {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => request(
                          type: 2,
                        )))
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Column(
              children: getListChat(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 900,
            height: 100,
            decoration: BoxDecoration(
              color: Color(0xff86BACB),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 300,
                    height: 60,
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      controller: textController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type Here ',
                          hintStyle:
                              TextStyle(fontSize: 20, color: Colors.grey),
                          errorStyle: TextStyle(fontSize: 15)),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.send_rounded,
                      size: 40,
                    ),
                    color: Colors.white,
                    onPressed: () => sendChat(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  getdata() async {
    var collection4 = FirebaseFirestore.instance
        .collection('Chat')
        .doc(widget.docID)
        .collection('Message');
    var querySnapshot4 = await collection4.get();
    for (var queryDocumentSnapshot in querySnapshot4.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      listChat.add(Chat(queryDocumentSnapshot.id, data['msg'], data['date'],
          data['time'], data['userReceive'], data['userSend']));
    }

    setState(() {
      listChat;
    });
  }

  List<Widget> getListChat() {
    List<Widget> list = [];
    List<String> dates = [];
    for (var item in listChat) {
      if (dates != [] && !dates.contains(item.date)) {
        dates.add(item.date);
      }
    }
    for (var item2 in dates) {
      list.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment(0, 0),
                margin: EdgeInsets.only(right: 20),
                height: 50,
                child: Text(
                  item2,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      );

      for (var item in listChat) {
        if (item.date == item2) {
          if (item.userSend == firebaseUser?.displayName) {
            list.add(
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    item.time,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20, top: 10),
                    padding: EdgeInsets.only(right: 20, left: 20, top: 15),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      color: Color(0xff86BACB),
                    ),
                    child: Text(
                      item.sentence,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ],
              ),
            );
          } else {
            list.add(
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  Container(
                    margin: EdgeInsets.only(right: 10, top: 10),
                    padding: EdgeInsets.only(right: 20, left: 20, top: 15),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      color: Color(0xff86BACB),
                    ),
                    child: Text(
                      item.sentence,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  Text(
                    item.time,
                  ),
                ],
              ),
            );
          }
        }
      }
    }
    return list;
  }

  sendChat() {
    String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String time = DateFormat('HH:m').format(DateTime.now());
    FirebaseFirestore.instance
        .collection('Chat')
        .doc(widget.docID)
        .collection('Message')
        .add({
      'date': date,
      'msg': textController.text,
      'time': time,
      'userReceive': widget.user.username,
      'userSend': firebaseUser?.displayName
    });

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => chat(
                  user: widget.user,
                  docID: widget.docID,
                )));
  }
}
