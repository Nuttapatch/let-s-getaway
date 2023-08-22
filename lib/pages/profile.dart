// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_getaway/models/user_profile_model.dart';

import 'home.dart';
import 'request.dart';
import 'sent_freind.dart';
import 'your_plan.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  int _selectedIndex = 4;
  UserProfile profile = UserProfile('', '', '', '', '', []);
  var firebaseUser = FirebaseAuth.instance.currentUser;
  final ImagePicker _picker = ImagePicker();
  File? image;

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

  // Future pickImage() async {
  //   try {
  //     final image = await _picker.pickImage(source: ImageSource.gallery);
  //     if (image == null) return;
  //     final imageTemp = File(image.path);
  //     setState(() => this.image = imageTemp);
  //     Navigator.of(context).pop();
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff4D7D8C),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 40,
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
                    height: 550,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/user_profile.png'),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // pickImage();
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(125, 145, 0, 0),
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff4D7D8C)),
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 70,
                          width: 280,
                          child: TextFormField(
                            controller: usernameController,
                            decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.person, color: Colors.white),
                              hintText: 'Username',
                              hintStyle:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              errorStyle: TextStyle(fontSize: 18),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide.none,
                              ),
                              enabled: false,
                              filled: true,
                              fillColor: Color(0xFF9DB7C0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 70,
                          width: 280,
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.email, color: Colors.white),
                              hintText: 'Email',
                              hintStyle:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              errorStyle: TextStyle(fontSize: 18),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color(0xFF9DB7C0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 70,
                          width: 280,
                          child: TextFormField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.phone, color: Colors.white),
                              hintText: 'Phone',
                              hintStyle:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              errorStyle: TextStyle(fontSize: 18),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color(0xFF9DB7C0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: () => {saveChange()},
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(94, 15, 94, 15),
                              primary: Color(0xff4D7D8C),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              )),
                          child: Text('SAVE',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23)),
                        ),
                      ],
                    ),
                  )
                ],
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

  getData() async {
    var collection = FirebaseFirestore.instance.collection('User');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      if (data['Username'] == firebaseUser?.displayName) {
        profile = UserProfile(
            queryDocumentSnapshot.id,
            data['Username'],
            data['BirthDate'],
            data['PhoneNum'],
            data['Image'],
            data['Friends']);
      }
    }
    setState(() => {
          profile,
          usernameController.text = profile.username,
          emailController.text = firebaseUser!.email as String,
          phoneController.text = profile.phoneNum
        });
  }

  saveChange() {
    if (emailController.text != firebaseUser!.email) {
      firebaseUser?.updateEmail(emailController.text);
    }

    if (phoneController.text != profile.phoneNum) {
      FirebaseFirestore.instance
          .collection('User')
          .doc(profile.id)
          .update({'PhoneNum': phoneController.text});
    }
    Fluttertoast.showToast(msg: "อัพเดทข้อมูลสำเร็จ");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ProfilePage()));
  }
}
