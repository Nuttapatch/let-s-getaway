import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:lets_getaway/models/hotel_model.dart';

import 'detail_travel.dart';

class travel extends StatefulWidget {
  travel({Key? key, required this.province, required this.liked})
      : super(key: key);

  String province;
  List liked;

  @override
  State<travel> createState() => _travelState();
}

class _travelState extends State<travel> {
  List<Hotel> hotels = [];
  List<String> hotelIDs = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff86BACB),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "ค้นหาที่พัก",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onTap: () => {Navigator.pop(context)},
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 4, left: 20, right: 20, bottom: 0),
          child: Column(
            children: [
              Container(
                width: 380,
                height: 62,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                widget.province,
                                style: TextStyle(
                                  color: Color(0xff86BACB),
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "1 ห้อง ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                " 2 ผู้เข้าพัก",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Icon(
                        Icons.search_outlined,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                children: getListHotel(),
              )
            ],
          ),
        ),
      ),
    );
  }

  getData() async {
    List<String> listHotelIDs = [];
    var collection = FirebaseFirestore.instance.collection('TagHotel');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      if (widget.liked.contains(data['TagName'])) {
        listHotelIDs.add(queryDocumentSnapshot.id);
      }
    }

    collection = FirebaseFirestore.instance.collection('TagOfHotel');
    querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      if (listHotelIDs.contains(data['TagHotelID'])) {
        hotelIDs.add(data['HotelID']);
      }
    }

    var collection2 = FirebaseFirestore.instance.collection('Hotel');
    var querySnapshot2 = await collection2.get();
    for (var queryDocumentSnapshot in querySnapshot2.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      if (data['Province'] == widget.province ||
          data['Location'] == widget.province) {
        if (hotelIDs.contains(queryDocumentSnapshot.id)) {
          hotels.add(Hotel(
              queryDocumentSnapshot.id,
              data['Address'],
              data['Lattitude'],
              data['Longtitude'],
              data['Location'],
              data['Name'],
              data['Province'],
              data['Image']));
        }
      }
    }

    setState(() {
      hotels;
    });
  }

  List<Widget> getListHotel() {
    List<Widget> list = [];

    for (var item in hotels) {
      List<Widget> list2 = [];
      for (var item2 in item.images) {
        list2.add(
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              'assets/images/' + item2,
              fit: BoxFit.cover,
            ),
          ),
        );
      }
      list.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => detail_travel(
                          hotel: item,
                        )));
          },
          child: Container(
            width: 380,
            height: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageSlideshow(
                  width: double.infinity,
                  initialPage: 0,
                  indicatorColor: Colors.orangeAccent,
                  indicatorBackgroundColor: Color(0xFFFFD9BF),
                  children: list2,
                  autoPlayInterval: 5000,
                  isLoop: true,
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 0, left: 10, right: 0, bottom: 0),
                  child: Text(
                    item.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 0, left: 10, right: 0, bottom: 0),
                  child: Row(
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
                        Icons.location_on_rounded,
                        color: Colors.black,
                      ),
                      Text(
                        item.location + ' ' + item.province,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      list.add(
        SizedBox(
          height: 10,
        ),
      );
    }

    return list;
  }
}
