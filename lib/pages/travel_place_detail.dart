// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/travel_place_model.dart';

class TravelPlaceDetailPage extends StatefulWidget {
  TravelPlaceDetailPage({Key? key, required this.detail}) : super(key: key);

  TravelPlace detail;

  @override
  State<TravelPlaceDetailPage> createState() => _TravelPlaceDetailPageState();
}

class _TravelPlaceDetailPageState extends State<TravelPlaceDetailPage> {
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
          child: Column(
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
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 15),
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
            height: 15,
          ),
          //ไฮไลท์
          UnconstrainedBox(
            child: Container(
              width: 380,
              padding:
                  EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Highlight",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            widget.detail.highlight,
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          //ตำแหน่งที่ตั้ง
          UnconstrainedBox(
            child: Container(
              width: 380,
              padding:
                  EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ตำแหน่งที่ตั้ง",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
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
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Icon(Icons.location_on_rounded),
                        SizedBox(
                          width: 5,
                        ),
                        Flexible(child: Text(widget.detail.address))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //ค่าเข้า
          UnconstrainedBox(
            child: Container(
              width: 380,
              padding:
                  EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ค่าเข้า",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: getEntrancePrice(),
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  List<Widget> getReview() {
    List<Widget> list = [];
    for (var i = 0; i < 5; i++) {
      list.add(
        Icon(
          Icons.star,
          color: Color(0xffFFCC33),
        ),
      );
    }

    list.add(
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          "7.1",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    );

    list.add(
      Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Text(
          "(1,180 รีวิว)",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    );
    return list;
  }

  List<Widget> getEntrancePrice() {
    List<Widget> list = [];
    for (var item in widget.detail.enterPrice) {
      list.add(Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Icon(
              Icons.person,
              color: Colors.black,
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                item,
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            )
          ],
        ),
      ));
    }
    return list;
  }

  List<Widget> slideImages() {
    List<Widget> list = [];
    for (var img in widget.detail.image) {
      list.add(ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          child: Image.network(
            "https://firebasestorage.googleapis.com/v0/b/let-s-getaway.appspot.com/o/Travel%2F$img?alt=media&token=61953c21-6611-4cb5-bbdb-f393b492580b",
            fit: BoxFit.fill,
          )));
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
}
