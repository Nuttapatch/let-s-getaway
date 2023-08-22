// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:lets_getaway/models/hotel_model.dart';
import 'package:lets_getaway/models/hotel_room_model.dart';

class detail_travel extends StatefulWidget {
  detail_travel({Key? key, required this.hotel}) : super(key: key);

  Hotel hotel;

  @override
  State<detail_travel> createState() => _detail_travelState();
}

class _detail_travelState extends State<detail_travel> {
  List<HotelRoom> listHotelRoom = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Color(0xff86BACB),
        appBar: AppBar(
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
            onTap: () => {Navigator.pop(context)},
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: getListImageHotel(),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                10,
                0,
                0,
              ),
              child: Row(
                children: [
                  Text(
                    widget.hotel.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 380,
              height: 170,
              padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Review",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "ดูรีวิวทังหมด",
                        style: TextStyle(
                          color: Color(0xff86BACB),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Color(0xffFFCC33),
                      ),
                      Icon(
                        Icons.star,
                        color: Color(0xffFFCC33),
                      ),
                      Icon(
                        Icons.star,
                        color: Color(0xffFFCC33),
                      ),
                      Icon(
                        Icons.star,
                        color: Color(0xffFFCC33),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "7.1",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "(1,180 รีวิว)",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 170,
                        height: 80,
                        padding: EdgeInsets.only(
                            top: 4, left: 16, right: 16, bottom: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.grey.shade300,
                        ),
                        child: Column(
                          children: [
                            Text("“พนักงานใจดีมาก”",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text("divine",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    )),
                                SizedBox(
                                  width: 4,
                                ),
                                Text("|",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    )),
                                SizedBox(
                                  width: 4,
                                ),
                                Text("Thailand",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    )),
                                SizedBox(
                                  width: 4,
                                ),
                                Image.asset(
                                  "assets/images/img_thailand.png",
                                  width: 15,
                                  height: 15,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        width: 170,
                        height: 80,
                        padding: EdgeInsets.only(
                            top: 4, left: 16, right: 16, bottom: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.grey.shade300,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Text(
                                  "“ห้องพักสวยและสะดวกสบาย วิวสวย สระว่ายน้ำยอดเยี่ยม”",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text("chalinee",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    )),
                                SizedBox(
                                  width: 4,
                                ),
                                Text("|",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    )),
                                SizedBox(
                                  width: 4,
                                ),
                                Text("Thailand",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    )),
                                SizedBox(
                                  width: 4,
                                ),
                                Image.asset(
                                  "assets/images/img_thailand.png",
                                  width: 15,
                                  height: 15,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 380,
              height: 200,
              padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("ตำแหน่งที่ตั้ง",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset("assets/images/img_image12_1.png"),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(widget.hotel.address,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/img_beach.png",
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("700 เมตร จากชายหาด",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                          ))
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
              child: Row(
                children: [
                  Text(
                    "ห้องพักทังหมด",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(
              width: 380,
              height: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/img_image13.png',
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                    child: Row(
                      children: [
                        Text("เพนต์เฮาส์สวีท (Penthouse Suites)",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.align_horizontal_center_sharp,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("28 ตารางเมตร",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/img_bed.png",
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("1 เตียงควีนไซส์ และ 1 ฟูก",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/img_people.png",
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("เข้าพักได้สูงสุด ผู้ใหญ่ 3 คน",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }

  getData() async {
    var collection = FirebaseFirestore.instance.collection('HotelRoom');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      if (data['HotelID'] == widget.hotel.id) {
        listHotelRoom.add(HotelRoom(
            data['AdultCount'],
            data['Bed'],
            data['HotelId'],
            data['RoomImg'],
            data['KidCount'],
            data['RoomName'],
            data['RoomPrice'],
            data['RoomSize']));
      }
    }

    setState(() {
      listHotelRoom;
    });
  }

  List<Widget> getListImageHotel() {
    List<Widget> list = [];
    for (var item in widget.hotel.images) {
      list.add(
        Container(
          constraints: BoxConstraints(maxHeight: 250, maxWidth: 300),
          decoration: new BoxDecoration(
              image: new DecorationImage(
            image: new AssetImage("assets/images/" + item),
            fit: BoxFit.fill,
          )),
        ),
      );
    }
    return list;
  }
}
