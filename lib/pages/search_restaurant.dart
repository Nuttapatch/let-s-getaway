import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cafe.dart';

class search_restaurant extends StatefulWidget {
  search_restaurant({Key? key}) : super(key: key);

  @override
  State<search_restaurant> createState() => _search_restaurantState();
}

class _search_restaurantState extends State<search_restaurant> {
  final formkey = GlobalKey<FormState>();
  var db = FirebaseFirestore.instance;
  List<String> listProvince = [];
  List<String> listtag = [];
  final _openDropDownProgKey = GlobalKey<DropdownSearchState<String>>();
  final _openDropDownProgKey2 = GlobalKey<DropdownSearchState<String>>();
  var selectRestype, selectProvince = "เลือกจังหวัด";
  List selectlike = [];
  List<DropdownMenuItem<String>> typeRestuarant = [];

  @override
  void initState() {
    Getdata();
    getRestuarantType();
    gettag();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      extendBodyBehindAppBar: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/img_image5.png"),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5), BlendMode.dstATop),
        )),
        child: SafeArea(
          child: Column(
            children: [
              Text(
                "ค้นหาร้านอาหาร",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              UnconstrainedBox(
                child: Container(
                  width: 380,
                  padding:
                      EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 25, 5, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "สถานที่",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Color(0xff86BACB),
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 350,
                          height: 65,
                          padding: EdgeInsets.only(
                              top: 4, left: 16, right: 16, bottom: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Colors.white,
                          ),
                          child: DropdownSearch(
                              key: _openDropDownProgKey,
                              dropdownSearchDecoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  hintText: "เลือกจังหวัด"),
                              mode: Mode.DIALOG,
                              showSearchBox: true,
                              items: listProvince,
                              selectedItem: selectProvince,
                              onChanged: (v) {
                                setState(() => selectProvince = v.toString());
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
                        Form(
                          key: formkey,
                          child: Container(
                            width: 320,
                            height: 80,
                            padding: EdgeInsets.only(
                                top: 4, left: 16, right: 16, bottom: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              border: Border.all(color: Colors.grey),
                              color: Colors.white,
                            ),
                            child: DropdownButtonFormField<String>(
                                hint: Text('เลือกประเภทร้านอาหาร'),
                                value: selectRestype,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectRestype = newValue!;
                                  });
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return "กรุณาเลือกประเภทร้านอาหาร";
                                  } else {
                                    return null;
                                  }
                                },
                                items: typeRestuarant),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "เลือกสิ่งที่ชอบ",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Color(0xff86BACB),
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        UnconstrainedBox(
                          child: Container(
                            width: 330,
                            padding: EdgeInsets.only(
                                top: 4, left: 16, right: 16, bottom: 4),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              color: Colors.white,
                            ),
                            child: DropdownSearch.multiSelection(
                                key: _openDropDownProgKey2,
                                dropdownSearchDecoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  hintText: "เลือกสิ่งที่ชอบ",
                                ),
                                mode: Mode.MENU,
                                showSearchBox: true,
                                items: listtag,
                                selectedItems: selectlike,
                                onChanged: (v) {
                                  setState(() => selectlike = v);
                                },
                                showClearButton: true,
                                validator: (v) {
                                  if (v == null) {
                                    return "กรุณาใส่สิ่งที่ชอบ";
                                  } else {
                                    return null;
                                  }
                                }),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_openDropDownProgKey
                                          .currentState?.getSelectedItem !=
                                      "เลือกจังหวัด" &&
                                  _openDropDownProgKey
                                          .currentState?.getSelectedItem !=
                                      "กรุณาเลือกจังหวัด") {
                                if (formkey.currentState!.validate()) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => cafe(
                                                province: selectProvince,
                                                type: selectRestype,
                                                listTag: selectlike,
                                              )));
                                }
                              } else {
                                _openDropDownProgKey.currentState
                                    ?.changeSelectedItem("กรุณาเลือกจังหวัด");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.fromLTRB(120, 15, 120, 15),
                                primary: Color(0xff86BACB),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                )),
                            child: Text('ค้นหา',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Getdata() async {
    var collection = db.collection('Restuarant');
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

  getRestuarantType() async {
    var collection = db.collection('RestuarantType');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      typeRestuarant.add(DropdownMenuItem(
          child: Text(data['TypeName']), value: data['TypeName']));
    }
    setState(() => typeRestuarant);
  }

  gettag() async {
    var collection = db.collection('TagReatuarant');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      listtag.add(data['TagName']);
    }

    setState(() => listtag);
  }
}
