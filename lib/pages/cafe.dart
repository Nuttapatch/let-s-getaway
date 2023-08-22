// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:lets_getaway/models/Restuarant.dart';
import 'package:lets_getaway/models/rate_restuarant_model.dart';
import 'package:lets_getaway/models/restuarant_type.dart';
import 'package:lets_getaway/models/tag_of_restuarant.dart';
import 'package:lets_getaway/models/tag_restuarant_model.dart';

import 'detaill_cafe.dart';

class cafe extends StatefulWidget {
  cafe(
      {Key? key,
      required this.province,
      required this.type,
      required this.listTag})
      : super(key: key);
  String province, type;
  List listTag;

  @override
  State<cafe> createState() => _cafeState();
}

class _cafeState extends State<cafe> {
  String tagText = "";
  var db = FirebaseFirestore.instance;
  String typeId = "";
  List listGetTagId = [];
  List<Restuarant> ListRestuarant = [];
  List<RateRestuarant> listRateRestuanrants = [];
  int rate = 0;

  getTagText() {
    for (var item in widget.listTag) {
      tagText += item + ', ';
    }

    setState(() {
      tagText;
    });
  }

  @override
  void initState() {
    getTagText();
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xff86BACB),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "ค้นหาร้านอาหาร",
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
              SizedBox(
                height: 120,
              ),
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
                                tagText,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.search_outlined,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                children: getResShow(),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getResShow() {
    List<Widget> list = [];
    for (var item in ListRestuarant) {
      list.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => detail_cafe(
                        detail: item, rateResList: listRateRestuanrants)));
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
                  children: slideImages(),
                  autoPlayInterval: 5000,
                  isLoop: true,
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 0, left: 10, right: 0, bottom: 0),
                  child: Flexible(
                    child: Text(
                      item.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                      ),
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
                      Row(
                        children: getRate(item.id),
                      ),
                      Icon(
                        Icons.location_on_rounded,
                        color: Colors.black,
                      ),
                      Text(
                        item.location,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 0, left: 10, right: 0, bottom: 0),
                  child: Text(
                    item.closeTime != ""
                        ? "เวลาเปิด " + item.openTime + " - " + item.closeTime
                        : "เวลาเปิด " + item.openTime,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    list.add(
      SizedBox(
        height: 15,
      ),
    );
    return list;
  }

  List<Widget> slideImages() {
    List<Widget> list = [];
    for (var item in ListRestuarant) {
      for (var img in item.image) {
        list.add(ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            child: Image.network(
              "https://firebasestorage.googleapis.com/v0/b/let-s-getaway.appspot.com/o/Restuarant%2F$img?alt=media&token=61953c21-6611-4cb5-bbdb-f393b492580b",
              fit: BoxFit.fill,
            )));
      }
    }
    return list;
  }

  List<Widget> getRate(String id) {
    List<Widget> list = [];
    rate = 0;
    for (var item in listRateRestuanrants) {
      if (item.restuarantID == id) {
        rate += double.parse(item.rating).round();
      }
    }

    for (var i = 0; i < rate; i++) {
      list.add(
        Icon(
          Icons.star,
          color: Color(0xffFFCC33),
        ),
      );
    }
    return list;
  }

  getdata() async {
    List<RestuarantType> listType = [];
    var collection = db.collection('RestuarantType');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      listType.add(RestuarantType(queryDocumentSnapshot.id, data['TypeName']));
    }

    for (var item in listType) {
      if (item.typeName == widget.type) {
        typeId = item.id;
      }
    }

    List<TagRestuarant> listTagRes = [];
    var collection3 = db.collection('TagReatuarant');
    var querySnapshot3 = await collection3.get();
    for (var queryDocumentSnapshot in querySnapshot3.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      listTagRes.add(TagRestuarant(queryDocumentSnapshot.id, data['TagName']));
    }
    for (var item in listTagRes) {
      if (widget.listTag.contains(item.tagName)) {
        listGetTagId.add(item.id);
      }
    }

    var collection2 = db.collection('Restuarant');
    var querySnapshot2 = await collection2.get();
    for (var queryDocumentSnapshot in querySnapshot2.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      bool isFoundTag = false;
      List tags = data['Tags'];
      for (var item in listGetTagId) {
        if (tags.contains(item)) {
          isFoundTag = true;
          break;
        }
      }
      if (widget.province == data['Province'] &&
          typeId == data['RestuarantTypeID'] &&
          isFoundTag) {
        ListRestuarant.add(Restuarant(
            queryDocumentSnapshot.id,
            data['Address '],
            data['Name'],
            data['OpenTime'],
            data['CloseTime'],
            data['Lattitude'],
            data['Longtitude'],
            data['Location'],
            data['Province'],
            data['RestuarantTypeID'],
            data['image'],
            data['Facebook'],
            data['Instragram'],
            data['Line'],
            data['PhoneNum'],
            data['Tags']));
      }
    }
    var collection5 = db.collection('RateRestaurant');
    var querySnapshot5 = await collection5.get();
    for (var queryDocumentSnapshot in querySnapshot5.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      listRateRestuanrants.add(RateRestuarant(
          queryDocumentSnapshot.id,
          data['CountryRate'],
          data['NameRate'],
          data['RateText'],
          data['Rating'],
          data['RestaurantID']));
    }

    setState(() {
      listRateRestuanrants;
      ListRestuarant;
      typeId;
      listGetTagId;
    });
  }
}
