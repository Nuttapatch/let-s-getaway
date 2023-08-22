import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lets_getaway/models/Request_model.dart';
import 'package:lets_getaway/models/feed_model.dart';
import 'package:lets_getaway/models/user_profile_model.dart';
import 'package:lets_getaway/pages/request.dart';
import 'chat_1.dart';
import 'home.dart';
import 'profile.dart';
import 'your_plan.dart';

class sent_freind extends StatefulWidget {
  sent_freind({
    Key? key,
  }) : super(key: key);

  @override
  State<sent_freind> createState() => _sent_freindState();
}

class _sent_freindState extends State<sent_freind> {
  final textController = TextEditingController();
  var firebaseUser = FirebaseAuth.instance.currentUser;
  List<Feed> listFeed = [];
  List<UserProfile> listallUser = [];
  List<Request> listRequest = [];
  int _selectedIndex = 0;
  UserProfile userProfile = UserProfile('', '', '', '', '', []);

  @override
  void initState() {
    getData();
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
        padding: EdgeInsets.only(top: 120, left: 20, right: 20, bottom: 0),
        child: Column(children: getfeed()),
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {postFeed()},
        label: Text(
          '+',
          style: TextStyle(fontSize: 25),
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
      ),
    );
  }

  postFeed() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(
                'Post',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: textController,
                      maxLines: 5,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          hintText: 'ใส่ข้อความ',
                          hintStyle:
                              TextStyle(fontSize: 20, color: Colors.grey),
                          errorStyle: TextStyle(fontSize: 15)),
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        addpost();
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(90, 10, 90, 10),
                          primary: Color(0xff86BACB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          )),
                      child: Text('ยืนยัน',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    )
                  ],
                ));
              }));
        });
  }

  addpost() {
    FirebaseFirestore.instance.collection('Feed').add({
      'Username': userProfile.username,
      'BirthDate': userProfile.birthDate,
      'Text': textController.text
    });
    Fluttertoast.showToast(msg: "โพสต์สำเร็จ", gravity: ToastGravity.BOTTOM);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => sent_freind()));
  }

  getData() async {
    var collection = FirebaseFirestore.instance.collection('User');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      listallUser.add(UserProfile(queryDocumentSnapshot.id, data['Username'],
          data['BirthDate'], data['PhoneNum'], data['Image'], data['Friends']));
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
    var collection2 = FirebaseFirestore.instance.collection('Feed');
    var querySnapshot2 = await collection2.get();
    for (var queryDocumentSnapshot in querySnapshot2.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      listFeed.add(Feed(queryDocumentSnapshot.id, data['BirthDate'],
          data['Text'], data['Username']));
    }

    var collection3 = FirebaseFirestore.instance.collection('Request');
    var querySnapshot3 = await collection3.get();
    for (var queryDocumentSnapshot in querySnapshot3.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      listRequest.add(Request(queryDocumentSnapshot.id, data['Status'],
          data['UserRecieve'], data['UserSend']));
    }
    setState(() {
      listFeed;
    });
  }

  List<Widget> getfeed() {
    List<Widget> feed = [];
    for (var item in listFeed) {
      String textSend = 'Sent Freind request';
      String img = "";
      List listage = item.birthdate.split("-");
      int age = 0;
      if (DateTime.now().month - int.parse(listage[1]) < 0) {
        age = DateTime.now().year - int.parse(listage[0]);
        age -= 1;
      } else {
        age = DateTime.now().year - int.parse(listage[0]);
      }
      for (var item2 in listallUser) {
        if (item2.username == item.username) {
          img = item2.image;
        }
      }

      for (var item3 in listRequest) {
        if (item3.userRecieve == item.username &&
            userProfile.username == item3.userSend) {
          textSend = "Request has been sent";
        }
      }

      if (img == "") {
        feed.add(
          Container(
            width: 380,
            height: 250,
            decoration: new BoxDecoration(
                image: new DecorationImage(
              image: new AssetImage("assets/images/user_profile.png"),
              fit: BoxFit.fill,
            )),
            child: Column(
              children: [
                SizedBox(
                  height: 142,
                ),
                Container(
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              item.username,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              age.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                item.text,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ElevatedButton(
                            onPressed: () => {sendRequest(item.username)},
                            style: ElevatedButton.styleFrom(
                                // padding: EdgeInsets.fromLTRB(120, 15, 120, 15),
                                primary: Color(0xff86BACB),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                )),
                            child: Text(textSend,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        feed.add(
          Container(
            width: 380,
            height: 250,
            decoration: new BoxDecoration(
                image: new DecorationImage(
              image: NetworkImage(
                "https://firebasestorage.googleapis.com/v0/b/let-s-getaway.appspot.com/o/User%2F$img?alt=media&token=61953c21-6611-4cb5-bbdb-f393b492580b",
              ),
              fit: BoxFit.fill,
            )),
            child: Column(
              children: [
                SizedBox(
                  height: 142,
                ),
                Container(
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              item.username,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              age.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              item.text,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ElevatedButton(
                            onPressed: () => {},
                            style: ElevatedButton.styleFrom(
                                // padding: EdgeInsets.fromLTRB(120, 15, 120, 15),
                                primary: Color(0xff86BACB),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                )),
                            child: Text('Sent Freind requrst',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
    return feed;
  }

  sendRequest(String userRecieve) {
    if (!userProfile.friends.contains(userRecieve)) {
      FirebaseFirestore.instance.collection('Request').add({
        'UserSend': firebaseUser!.displayName,
        'UserRecieve': userRecieve,
        'Status': 0
      });
      Fluttertoast.showToast(
          msg: "ส่งคำขอสำเร็จ", gravity: ToastGravity.BOTTOM);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => sent_freind()));
    } else {
      Fluttertoast.showToast(
          msg: "คุณเป็นเพื่อนกันแล้ว", gravity: ToastGravity.BOTTOM);
    }
  }
}
