// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, iterable_contains_unrelated_type

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lets_getaway/models/user_profile_model.dart';

import '../models/plan_model.dart';
import 'expense.dart';

class AddBillPage extends StatefulWidget {
  AddBillPage({Key? key, required this.allUser, required this.plan})
      : super(key: key);

  List<UserProfile> allUser;
  Plan plan;

  @override
  State<AddBillPage> createState() => _AddBillPageState();
}

class _AddBillPageState extends State<AddBillPage> {
  final nameController = TextEditingController();
  final nameBillController = TextEditingController();
  final amountController = TextEditingController();
  final bankNameController = TextEditingController();
  final bankNumController = TextEditingController();
  var selectBank;

  List<DropdownMenuItem<String>> bankList = [
    DropdownMenuItem(child: Text("ธนาคารกสิกรไทย"), value: "ธนาคารกสิกรไทย"),
    DropdownMenuItem(child: Text("ธนาคารกรุงไทย"), value: "ธนาคารกรุงไทย"),
    DropdownMenuItem(child: Text("ธนาคารกรุงเทพ"), value: "ธนาคารกรุงเทพ"),
    DropdownMenuItem(
        child: Text("ธนาคารไทยพาณิชย์"), value: "ธนาคารไทยพาณิชย์"),
  ];

  Map<String, TextEditingController> listPeople = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff86BACB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          color: Colors.white,
          onPressed: () => {Navigator.pop(context)},
        ),
        title: Text(
          "เพิ่มบิลค่าใช้จ่าย",
          style: TextStyle(
            fontSize: 30,
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
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              height: 70,
              width: 330,
              child: TextFormField(
                controller: nameBillController,
                decoration: InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.pen),
                  hintText: 'ชื่อบิล',
                  hintStyle:
                      TextStyle(color: Colors.grey.shade400, fontSize: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(width: 0.5, color: Color(0xffBFBEBE)),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            Divider(color: Colors.black),
            SizedBox(
              height: 10,
            ),
            Text(
              'ยอดของแต่ละคน',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
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
                  hintStyle:
                      TextStyle(color: Colors.grey.shade400, fontSize: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(width: 0.5, color: Color(0xffBFBEBE)),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            Column(
              children: showPeople(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Divider(color: Colors.black),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'บัญชีธนาคาร',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 300,
              padding: EdgeInsets.only(left: 10),
              child: DropdownButtonFormField<String>(
                  hint: Text('เลือกบัญชีธนาคาร'),
                  value: selectBank,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectBank = newValue!;
                    });
                  },
                  validator: (value) {},
                  items: bankList),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 0.5, style: BorderStyle.solid),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: 300,
                child: TextFormField(
                  controller: bankNameController,
                  decoration: InputDecoration(
                    hintText: 'ชื่อบัญชี',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Container(
                width: 300,
                child: TextFormField(
                  controller: bankNumController,
                  decoration: InputDecoration(
                    hintText: 'เลขบัญชีธนาคาร',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                )),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                addBill();
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.fromLTRB(130, 10, 130, 10),
                  primary: Color(0xff4D7D8C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  )),
              child: Text('สร้าง',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25)),
            ),
          ],
        ),
      )),
    );
  }

  addBill() {
    Map<String, double> peep = {};
    listPeople.forEach((key, value) {
      peep.addAll({key: double.parse(value.text)});
    });
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('BillPlan').add({
      'BillName': nameBillController.text,
      'Bank': selectBank.toString(),
      'BankName': bankNameController.text,
      'BankAccount': bankNumController.text,
      'BillStatus': 0,
      'User_Create': firebaseUser?.displayName,
      'Users': peep,
      'DateCreate': DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
      'PlanID': widget.plan.id
    });

    listPeople.forEach((key, value) {
      FirebaseFirestore.instance.collection('PayBill').add({
        'TranferSlip': '',
        'PayType': '',
        'Date': '',
        'Status': 0,
        'Username': key,
        'PlanID': widget.plan.id,
        'Amount': double.parse(value.text)
      });
    });
    Fluttertoast.showToast(msg: "สร้างบิลสำเร็จ", gravity: ToastGravity.BOTTOM);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ExpensePage(
                  allUser: widget.allUser,
                  plan: widget.plan,
                )));
  }

  addPeople() {
    bool isFound = false, isSame = false;
    for (var item in widget.allUser) {
      if (nameController.text == item.username) {
        isFound = true;
        listPeople.forEach((key, value) {
          if (nameController.text == key) {
            isFound = false;
            isSame = true;
          }
        });
      }

      if (isFound) {
        listPeople.addAll({nameController.text: TextEditingController()});
        setState(() {});
        Fluttertoast.showToast(
            msg: "เพิ่มสำเร็จ", gravity: ToastGravity.BOTTOM);
      } else {
        if (isSame) {
          Fluttertoast.showToast(
              msg: "ผู้ใช้ถูกเพิ่มไปแล้ว", gravity: ToastGravity.BOTTOM);
        } else {
          Fluttertoast.showToast(
              msg: "ไม่พบ username ผู้ใช้", gravity: ToastGravity.BOTTOM);
        }
      }
    }
  }

  List<Widget> showPeople() {
    List<Widget> list = [];

    listPeople.forEach((key, value) {
      String img = "";
      for (var item in widget.allUser) {
        if (item.username == key) {
          img = item.image;
        }
      }
      if (img != "") {
        list.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                          "https://firebasestorage.googleapis.com/v0/b/let-s-getaway.appspot.com/o/User%2F$img?alt=media&token=61953c21-6611-4cb5-bbdb-f393b492580b",
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  key,
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            Container(
                width: 80,
                child: TextFormField(
                  controller: value,
                  decoration: InputDecoration(
                    hintText: 'จำนวนเงิน',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ))
          ],
        ));
      } else {
        list.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 40,
                  height: 40,
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
                  key,
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            Container(
                width: 80,
                child: TextFormField(
                  controller: value,
                  decoration: InputDecoration(
                    hintText: 'จำนวนเงิน',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ))
          ],
        ));
      }
    });
    return list;
  }
}
