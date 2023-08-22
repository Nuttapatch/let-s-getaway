// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lets_getaway/models/Restuarant.dart';
import 'package:lets_getaway/models/rate_restuarant_model.dart';

class detail_cafe extends StatefulWidget {
  detail_cafe({Key? key, required this.detail, required this.rateResList})
      : super(key: key);

  Restuarant detail;
  List<RateRestuarant> rateResList;

  @override
  State<detail_cafe> createState() => _detail_cafeState();
}

class _detail_cafeState extends State<detail_cafe> {
  List<RateRestuarant> listResRate = [];
  int rate = 0;
  final Completer<GoogleMapController> _controller = Completer();
  late final CameraPosition _theSelectLocation;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    setUpData();
    super.initState();
  }

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
            ImageSlideshow(
              width: double.infinity,
              initialPage: 0,
              indicatorColor: Colors.orangeAccent,
              indicatorBackgroundColor: Color(0xFFFFD9BF),
              children: slideImages(),
              autoPlayInterval: 5000,
              isLoop: true,
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
                  Flexible(
                    child: Text(
                      widget.detail.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            getReview(),
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
                  SizedBox(
                    width: 380,
                    height: 100,
                    child: GoogleMap(
                      markers: _markers,
                      initialCameraPosition: _theSelectLocation,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      myLocationEnabled: true,
                    ),
                  ),
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
                      Flexible(
                        child: Text(widget.detail.address,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            UnconstrainedBox(
              child: Container(
                width: 380,
                padding:
                    EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("ติดต่อ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: getContact(),
                    )
                  ],
                ),
              ),
            ),
          ]),
        ));
  }

  Widget getReview() {
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Review",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Row(
                children: getRate(),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "(" + listResRate.length.toString() + "รีวิว )",
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
            children: getReviewDetail(),
          )
        ],
      ),
    );
  }

  List<Widget> slideImages() {
    List<Widget> list = [];
    for (var img in widget.detail.image) {
      list.add(ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          child: Image.network(
            "https://firebasestorage.googleapis.com/v0/b/let-s-getaway.appspot.com/o/Restuarant%2F$img?alt=media&token=61953c21-6611-4cb5-bbdb-f393b492580b",
            fit: BoxFit.fill,
          )));
    }
    return list;
  }

  List<Widget> getRate() {
    for (var item in widget.rateResList) {
      if (item.restuarantID == widget.detail.id) {
        listResRate.add(item);
      }
    }

    setState(() {
      listResRate;
    });
    List<Widget> list = [];
    rate = 0;
    for (var item in listResRate) {
      rate += double.parse(item.rating).round();
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

  List<Widget> getReviewDetail() {
    List<Widget> list = [];
    for (var item in listResRate) {
      list.add(
        Container(
          width: 170,
          height: 80,
          padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.grey.shade300,
          ),
          child: Column(
            children: [
              Flexible(
                child: Text(item.rateText,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Flexible(
                child: Row(
                  children: [
                    Text(item.nameRate,
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
                    Text(item.countryRate,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      );

      list.add(
        SizedBox(
          width: 8,
        ),
      );
    }
    return list;
  }

  setUpData() {
    _theSelectLocation = CameraPosition(
      target: LatLng(double.parse(widget.detail.latitude),
          double.parse(widget.detail.longtitude)),
      zoom: 16,
    );
    _markers.add(Marker(
      markerId: MarkerId(widget.detail.latitude + widget.detail.longtitude),
      position: LatLng(double.parse(widget.detail.latitude),
          double.parse(widget.detail.longtitude)),
      infoWindow: InfoWindow(
        title: 'location',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
    ));
  }

  List<Widget> getContact() {
    List<Widget> list = [];
    if (widget.detail.phoneNum != "") {
      list.add(
        Row(
          children: [
            Image.asset(
              "assets/images/img_ringervolume.png",
              width: 30,
              height: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Text(widget.detail.phoneNum,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ))
          ],
        ),
      );

      list.add(
        SizedBox(
          height: 10,
        ),
      );
    }

    if (widget.detail.facebook != "") {
      list.add(
        Row(
          children: [
            Image.asset(
              "assets/images/img_facebook.png",
              width: 30,
              height: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(widget.detail.facebook,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  )),
            )
          ],
        ),
      );

      list.add(
        SizedBox(
          height: 10,
        ),
      );
    }

    if (widget.detail.instragram != "") {
      list.add(
        Row(
          children: [
            Image.asset(
              "assets/images/instragram.png",
              width: 30,
              height: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(widget.detail.instragram,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  )),
            )
          ],
        ),
      );

      list.add(
        SizedBox(
          height: 10,
        ),
      );
    }

    if (widget.detail.line != "") {
      list.add(
        Row(
          children: [
            Image.asset(
              "assets/images/line.png",
              width: 30,
              height: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(widget.detail.line,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  )),
            )
          ],
        ),
      );
    }

    return list;
  }
}
