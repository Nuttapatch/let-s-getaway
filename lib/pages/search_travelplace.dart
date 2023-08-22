// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lets_getaway/pages/show_travel_places.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchTravelPlacePage extends StatefulWidget {
  SearchTravelPlacePage({Key? key}) : super(key: key);

  @override
  State<SearchTravelPlacePage> createState() => _SearchTravelPlacePageState();
}

class _SearchTravelPlacePageState extends State<SearchTravelPlacePage> {
  final placeController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final _openDropDownProgKey = GlobalKey<DropdownSearchState<String>>();
  var db = FirebaseFirestore.instance;

  Color provinceColor = Colors.black;

  List<String> listProvince = [];
  List<DropdownMenuItem<String>> typeTravelPlace = [];
  var selectTravelPlace, selectProvince = "จังหวัด";

  @override
  void initState() {
    getListProvince();
    getTypeTravelPlace();
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
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/japan.jpg"),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.dstATop),
          )),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70,
                      ),
                      Text(
                        'ค้นหาสถานที่ท่องเที่ยว',
                        style: TextStyle(
                          fontSize: 33,
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
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 290,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 20),
                                Text(
                                  'สถานที่',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff86BACB),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              height: 80,
                              width: 350,
                              child: DropdownSearch(
                                  key: _openDropDownProgKey,
                                  dropdownSearchDecoration: InputDecoration(
                                      border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                                  mode: Mode.DIALOG,
                                  showSearchBox: true,
                                  items: listProvince,
                                  selectedItem: selectProvince,
                                  onChanged: (v) {
                                    setState(
                                        () => selectProvince = v.toString());
                                  },
                                  validator: (v) {
                                    if (v == null) {
                                      return "กรุณาใส่จังหวัด";
                                    } else {
                                      return null;
                                    }
                                  }),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 310,
                              padding: EdgeInsets.only(left: 10),
                              child: DropdownButtonFormField<String>(
                                  hint: Text('เลือกประเภทสถานที่ท่องเที่ยว'),
                                  value: selectTravelPlace,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectTravelPlace = newValue!;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      return "กรุณาเลือกประเภทสถานที่ท่องเที่ยว";
                                    } else {
                                      return null;
                                    }
                                  },
                                  items: typeTravelPlace),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 0.5, style: BorderStyle.solid),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () => {
                                if (_openDropDownProgKey
                                            .currentState?.getSelectedItem !=
                                        "จังหวัด" &&
                                    _openDropDownProgKey
                                            .currentState?.getSelectedItem !=
                                        "กรุณาเลือกจังหวัด")
                                  {
                                    if (formkey.currentState!.validate())
                                      {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ShowTravelPlaces(
                                                      province: selectProvince,
                                                      type: selectTravelPlace,
                                                    )))
                                      }
                                  }
                                else
                                  {
                                    _openDropDownProgKey.currentState
                                        ?.changeSelectedItem(
                                            "กรุณาเลือกจังหวัด"),
                                    _openDropDownProgKey.currentState
                                        ?.setState(() {
                                      provinceColor = Colors.red;
                                    })
                                  }
                              },
                              style: ElevatedButton.styleFrom(
                                  padding:
                                      EdgeInsets.fromLTRB(122, 10, 122, 10),
                                  primary: Color(0xff86BACB),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  )),
                              child: Text('ค้นหา',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  getListProvince() async {
    var collection = db.collection('TravelPlace');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      if (listProvince.isEmpty) {
        listProvince.add(data['Province']);
      } else {
        if (!listProvince.contains(data['Province'])) {
          listProvince.add(data['Province']);
        }
      }
    }
    setState(() => listProvince);
  }

  getTypeTravelPlace() async {
    var collection = db.collection('TravelplaceType');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      typeTravelPlace.add(DropdownMenuItem(
          child: Text(data['TypeName']), value: data['TypeName']));
    }
    setState(() => typeTravelPlace);
  }
}
