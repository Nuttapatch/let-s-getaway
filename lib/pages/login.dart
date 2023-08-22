// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lets_getaway/pages/start.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

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
          onTap: () => {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => StartPage()))
          },
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
            image: AssetImage("assets/images/waterfall.jpg"),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.dstATop),
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/images/img_logoround1.png'),
                      width: 200,
                      height: 200,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 100,
                      width: 300,
                      child: TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person, color: Colors.white),
                          labelText: 'Email',
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 20),
                          errorStyle: TextStyle(fontSize: 18),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Color(0xFF4D7D8C),
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "ต้องกรอก Email";
                          } else if (!validateEmail(value)) {
                            return "รูปแบบ email ไม่ถูกต้อง ตัวอย่างเช่น bbq@example.com";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 100,
                      width: 300,
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              color: Colors.white,
                              icon: Icon(_obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              }),
                          prefixIcon: Icon(Icons.lock, color: Colors.white),
                          labelText: 'Password',
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 20),
                          errorStyle: TextStyle(fontSize: 18),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Color(0xFF4D7D8C),
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "กรุณากรอก password";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () => {
                        if (formkey.currentState!.validate()) {signIn()}
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(110, 15, 110, 15),
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          )),
                      child: Text('Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 23)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool validateEmail(String input) {
    RegExp email = RegExp(r'[a-z0-9]+@[a-z]+\.[a-z]{2,3}');
    if (email.hasMatch(input)) {
      return true;
    }
    return false;
  }

  signIn() async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      )
          .then((user) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        Fluttertoast.showToast(
            msg: "เข้าสู่ระบบเรียบร้อย", gravity: ToastGravity.BOTTOM);
        return user;
      });
    } on FirebaseAuthException catch (error) {
      print(error);
      if (error.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: "email หรือ รหัสผ่านไม่ถูกต้อง", gravity: ToastGravity.BOTTOM);
      } else if (error.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: "email หรือ รหัสผ่านไม่ถูกต้อง", gravity: ToastGravity.BOTTOM);
      }
    }
  }
}
