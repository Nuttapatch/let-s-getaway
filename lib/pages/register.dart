// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lets_getaway/pages/login.dart';
import 'package:lets_getaway/pages/start.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  final getUsername = TextEditingController();
  final getEmail = TextEditingController();
  final getPhoneNum = TextEditingController();
  final getPassword = TextEditingController();
  final getConPass = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String birthDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff4D7D8C),
        appBar: AppBar(
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
            onTap: () => {Navigator.pop(context)},
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/regis_bg.jpg"),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.dstATop),
            ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    Image(
                      image: AssetImage('assets/images/img_logoround1.png'),
                      width: 200,
                      height: 200,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 300,
                      height: 70,
                      padding: EdgeInsets.only(
                          top: 4, left: 10, right: 16, bottom: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Color(0xFF4D7D8C),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            border: InputBorder.none,
                            hintText: 'Username',
                            hintStyle: TextStyle(
                                fontSize: 18, color: Color(0xffDFDEDE)),
                            errorStyle: TextStyle(fontSize: 15)),
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        controller: getUsername,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "ต้องกรอก Username";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 300,
                      height: 70,
                      padding: EdgeInsets.only(
                          top: 4, left: 10, right: 16, bottom: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Color(0xFF4D7D8C),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                            border: InputBorder.none,
                            hintText: 'Email',
                            hintStyle: TextStyle(
                                fontSize: 18, color: Color(0xffDFDEDE)),
                            errorStyle: TextStyle(fontSize: 15)),
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        controller: getEmail,
                        validator: (value) {
                          if (value == "") {
                            return "ต้องกรอก Email";
                          } else if (!validateEmail(value!)) {
                            return "รูปแบบ email ไม่ถูกต้อง ตัวอย่างเช่น bbq@example.com";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 300,
                      height: 70,
                      padding: EdgeInsets.only(
                          top: 4, left: 10, right: 16, bottom: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Color(0xFF4D7D8C),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            border: InputBorder.none,
                            hintText: 'Phone Number',
                            hintStyle: TextStyle(
                                fontSize: 18, color: Color(0xffDFDEDE)),
                            errorStyle: TextStyle(fontSize: 15)),
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        controller: getPhoneNum,
                        validator: (value) {
                          if (value == "") {
                            return "ต้องกรอกเบอร์โทรศัพท์";
                          } else if (!validatePhoneNum(value!)) {
                            return "รูปแบบเบอร์โทรศัพท์ไม่ถูกต้อง ต้องขึ้นต้นด้วย 0 และมี 10 ตัวเลข";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                        width: 300,
                        height: 70,
                        padding: EdgeInsets.only(
                            top: 4, left: 10, right: 16, bottom: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Color(0xFF4D7D8C),
                        ),
                        child: DateTimePicker(
                          type: DateTimePickerType.date,
                          dateMask: 'd MMM, yyyy',
                          initialValue: DateTime.now().toString(),
                          firstDate: DateTime(1800),
                          lastDate: DateTime.now(),
                          icon: Icon(Icons.event),
                          dateLabelText: 'วันเกิด',
                          onChanged: (val) => birthDate = val,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 300,
                      height: 70,
                      padding: EdgeInsets.only(
                          top: 4, left: 10, right: 16, bottom: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Color(0xFF4D7D8C),
                      ),
                      child: TextFormField(
                          obscureText: _obscureText1,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                            border: InputBorder.none,
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                fontSize: 18, color: Color(0xffDFDEDE)),
                            errorStyle: TextStyle(fontSize: 15),
                            suffixIcon: IconButton(
                                color: Colors.white,
                                icon: Icon(_obscureText1
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _obscureText1 = !_obscureText1;
                                  });
                                }),
                          ),
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          controller: getPassword,
                          validator: (value) {
                            if (value == "") {
                              return "ต้องกรอก Password";
                            } else if (value!.length < 6) {
                              return "Password ต้องมีอย่างน้อย 6 ตัว";
                            } else if (value != getConPass.text) {
                              return "Password กับ Confirm Password ต้องตรงกัน";
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 300,
                      height: 70,
                      padding: EdgeInsets.only(
                          top: 4, left: 10, right: 16, bottom: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Color(0xFF4D7D8C),
                      ),
                      child: TextFormField(
                          obscureText: _obscureText2,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                            border: InputBorder.none,
                            hintText: 'Confirm Password',
                            hintStyle: TextStyle(
                                fontSize: 18, color: Color(0xffDFDEDE)),
                            errorStyle: TextStyle(fontSize: 15),
                            suffixIcon: IconButton(
                                color: Colors.white,
                                icon: Icon(_obscureText2
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _obscureText2 = !_obscureText2;
                                  });
                                }),
                          ),
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          controller: getConPass,
                          validator: (value) {
                            if (value == "") {
                              return "ต้องกรอก Confirm Password";
                            } else if (value!.length < 6) {
                              return "Confirm Password ต้องมีอย่างน้อย 6 ตัว";
                            } else if (value != getPassword.text) {
                              return "Password กับ Confirm Password ต้องตรงกัน";
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: () => {
                              if (formKey.currentState!.validate()) {regis()}
                            },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(100, 12, 100, 12),
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  regis() async {
    List friends = [];
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: getEmail.text, password: getPassword.text);
      User user = result.user!;
      user.updateDisplayName(getUsername.text);
      FirebaseFirestore.instance.collection('User').add({
        'Username': getUsername.text,
        'PhoneNum': getPhoneNum.text,
        'BirthDate': birthDate,
        'Image': '',
        'Friends': friends
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
      Fluttertoast.showToast(
          msg: "สร้างบัญชีเรียบร้อย", gravity: ToastGravity.BOTTOM);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, gravity: ToastGravity.BOTTOM);
    }
  }

  bool validateEmail(String input) {
    RegExp email = RegExp(r'[a-z0-9]+@[a-z]+\.[a-z]{2,3}');
    if (email.hasMatch(input)) {
      return true;
    }
    return false;
  }

  bool validatePassAndConPass() {
    if (getPassword.text == getConPass.text) {
      return true;
    }
    return false;
  }

  validatePhoneNum(String input) {
    RegExp email = RegExp(r'^0[0-9]{9}');
    if (email.hasMatch(input)) {
      return true;
    }
    return false;
  }
}
