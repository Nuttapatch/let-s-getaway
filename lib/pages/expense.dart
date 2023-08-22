// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_getaway/models/user_profile_model.dart';
import 'package:lets_getaway/pages/add_bill.dart';

import '../models/bill_model.dart';
import '../models/pay_bill_model.dart';
import '../models/plan_model.dart';

class ExpensePage extends StatefulWidget {
  ExpensePage({Key? key, required this.allUser, required this.plan})
      : super(key: key);

  List<UserProfile> allUser;
  Plan plan;

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  final ImagePicker _picker = ImagePicker();
  File? image;
  List<Bill> listBill = [];
  List<PayBillModel> listPayBill = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future pickImage() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

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
          "บิลค่าใช้จ่าย",
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
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddBillPage(
                            allUser: widget.allUser,
                            plan: widget.plan,
                          )));
            },
            child: Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xff4D7D8C)),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              ),
            ),
          )
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: showExpenseList(),
          ),
        ),
      ),
    );
  }

  List<Widget> showExpenseList() {
    List<Widget> expenseList = [];

    for (var item in listBill) {
      expenseList.add(
        UnconstrainedBox(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            padding: EdgeInsets.all(25.0),
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.billName,
                      style: TextStyle(fontSize: 18, color: Color(0xff4D7D8C)),
                    ),
                    Text(
                      item.date,
                      style: TextStyle(fontSize: 14, color: Color(0xff86BACB)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: showPeep(),
                ),
                GestureDetector(
                  onTap: () {
                    showBillDetail(item);
                  },
                  child: Text(
                    'ดูว่าใครจ่ายไปแล้ว',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff86BACB),
                        decoration: TextDecoration.underline),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    payBill();
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                      primary: Color(0xff5F5F5F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      )),
                  child: Text('จ่ายเงิน',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return expenseList;
  }

  List<Widget> showPeep() {
    List<Widget> list = [];
    for (var item in listBill) {
      item.users.forEach((key, value) {
        list.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                key,
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
              Text(
                value.toString(),
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ],
          ),
        );

        list.add(
          SizedBox(
            height: 10,
          ),
        );
      });
    }
    return list;
  }

  void showBillDetail(Bill item) {
    double total = 0;
    item.users.forEach((key, value) {
      total += value;
    });
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Column(
                children: [
                  Text(
                    item.billName,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4D7D8C)),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        total.toString(),
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff4D7D8C)),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '฿',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff4D7D8C)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                ],
              ),
              content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(
                    child: ListBody(
                  children: [
                    Divider(color: Colors.black),
                    Text(
                      'รอยืนยัน',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      children: getListPayStatus(item, 2),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(color: Colors.black),
                    Text(
                      'ยังไม่ได้จ่าย',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: getListPayStatus(item, 0),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(color: Colors.black),
                    Text(
                      'จ่ายแล้ว',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: getListPayStatus(item, 1),
                    )
                  ],
                ));
              }));
        });
  }

  List<Widget> getListPayStatus(Bill item, int type) {
    List<Widget> list = [];
    if (type == 2) {
      for (var item in listPayBill) {
        if (item.status == 2) {
          list.add(
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      item.username,
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'ยืนยัน',
                        style: TextStyle(fontSize: 15, color: Colors.green),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'ปฏิเสธ',
                        style: TextStyle(fontSize: 15, color: Colors.green),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }
      }
    }

    if (type == 0) {
      for (var item in listPayBill) {
        if (item.status == 0) {
          list.add(
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      item.username,
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ],
                ),
                Text(
                  item.amount.toString(),
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
          );
        }
      }
    }

    if (type == 1) {
      for (var item in listPayBill) {
        if (item.status == 1) {
          list.add(
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      item.username,
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ],
                ),
                Text(
                  item.amount.toString(),
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
          );
        }
      }
    }

    return list;
  }

  void payBill() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(
                'จ่ายเงิน',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'assets/images/KBank_logo.png',
                            width: 50,
                            height: 50,
                          ),
                          Text(
                            'วรางคณา ผาสุขดี',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'ธนาคารกสิกรไทย',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '0568145771',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  Icons.copy,
                                  size: 20,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              image != null
                                  ? Image.file(
                                      image!,
                                      width: 60,
                                      height: 70,
                                    )
                                  : Container(),
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () => pickImage(),
                                style: ElevatedButton.styleFrom(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    primary: Color(0xff86BACB),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    )),
                                child: Text('อัพโหลดสลิป',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            onPressed: () {},
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
                      )
                    ],
                  ),
                );
              }));
        });
  }

  getData() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    var collection = FirebaseFirestore.instance.collection('BillPlan');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      if (data['PlanID'] == widget.plan.id) {
        listBill.add(Bill(
            queryDocumentSnapshot.id,
            data['Bank'],
            data['BankAccount'],
            data['BankName'],
            data['BillName'],
            data['BillStatus'],
            data['User_Create'],
            Map<String, dynamic>.from(data['Users']),
            data['DateCreate'],
            data['PlanID']));
      }
    }

    var collection2 = FirebaseFirestore.instance.collection('PayBill');
    var querySnapshot2 = await collection2.get();
    for (var queryDocumentSnapshot in querySnapshot2.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      if (data['PlanID'] == widget.plan.id) {
        listPayBill.add(PayBillModel(
            queryDocumentSnapshot.id,
            data['PlanID'],
            data['Date'],
            data['PayType'],
            data['Status'],
            data['TranferSlip'],
            data['Username'],
            data['Amount'].toDouble()));
      }
    }
    setState(() => listBill);
  }
}
