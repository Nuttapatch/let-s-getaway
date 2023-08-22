// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:lets_getaway/models/travel_place_model.dart';
import 'package:lets_getaway/models/travelplace_type_model.dart';
import 'package:lets_getaway/pages/travel_place_detail.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ShowTravelPlaces extends StatefulWidget {
  ShowTravelPlaces({Key? key, required this.province, required this.type})
      : super(key: key);

  String province, type;

  @override
  State<ShowTravelPlaces> createState() => _ShowTravelPlacesState();
}

class _ShowTravelPlacesState extends State<ShowTravelPlaces> {
  List<TravelPlace> listTravelPlace = [];
  List<String> listTravelID = [];
  String typeId = "";
  var db = FirebaseFirestore.instance;
  var url = "";

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
            "ค้นหาสถานที่ท่องเที่ยว",
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
            child: Column(children: [
              GestureDetector(
                onTap: (() => {Navigator.pop(context)}),
                child: Container(
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
                        Text(
                          widget.province + ", " + widget.type,
                          style: TextStyle(
                            color: Color(0xff86BACB),
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Icon(
                          Icons.search_outlined,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                children: getTravelPlaceList(),
              ),
            ]),
          ),
        ));
  }

  List<Widget> getTravelPlaceList() {
    List<Widget> list = [];
    for (var item in listTravelPlace) {
      list.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TravelPlaceDetailPage(detail: item)));
          },
          child: UnconstrainedBox(
            child: Container(
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ImageSlideshow(
                      width: double.infinity,
                      initialPage: 0,
                      indicatorColor: Colors.orangeAccent,
                      indicatorBackgroundColor: Color(0xFFFFD9BF),
                      children: slideImages(),
                      autoPlayInterval: 5000,
                      isLoop: true,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 0, left: 15, right: 0, bottom: 10),
                          child: Text(
                            item.name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            color: Colors.black,
                          ),
                          Text(
                            item.location,
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          Text(
                            item.closeTime != ""
                                ? "เวลาเปิด " +
                                    item.openTime +
                                    " - " +
                                    item.closeTime
                                : "เวลาเปิด " + item.openTime,
                            style: TextStyle(
                              color: Colors.black,
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
          ),
        ),
      );

      list.add(SizedBox(
        height: 10,
      ));
    }
    return list;
  }

  List<Widget> slideImages() {
    List<Widget> list = [];
    for (var item in listTravelPlace) {
      for (var img in item.image) {
        list.add(ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            child: Image.network(
              "https://firebasestorage.googleapis.com/v0/b/let-s-getaway.appspot.com/o/Travel%2F$img?alt=media&token=61953c21-6611-4cb5-bbdb-f393b492580b",
              fit: BoxFit.fill,
            )));
      }
    }
    return list;
  }

  getData() async {
    List<TravelPlaceType> listType = [];
    var collection = db.collection('TravelplaceType');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      listType.add(TravelPlaceType(queryDocumentSnapshot.id, data['TypeName']));
    }

    for (var item in listType) {
      if (item.typeName == widget.type) {
        typeId = item.id;
      }
    }

    var collection2 = db.collection('TravelPlace');
    var querySnapshot2 = await collection2.get();
    for (var queryDocumentSnapshot in querySnapshot2.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      if (widget.province == data['Province'] &&
          typeId == data['TravelPlaceTypeID']) {
        listTravelPlace.add(TravelPlace(
            queryDocumentSnapshot.id,
            data['Name'],
            data['OpenTime'],
            data['CloseTime'],
            data['Highlight'],
            data['Lattitude'],
            data['Longtitude'],
            data['Location'],
            data['Province'],
            data['TravelPlaceTypeID'],
            data['images'],
            data['Address '],
            data['EnterPrice']));
        if (listTravelID.isEmpty) {
          listTravelID.add(queryDocumentSnapshot.id);
        } else {
          if (!listTravelID.contains(queryDocumentSnapshot.id)) {
            listTravelID.add(queryDocumentSnapshot.id);
          }
        }
      }
    }
    setState(() {
      listTravelPlace;
      listTravelID;
      typeId;
    });
  }
}
