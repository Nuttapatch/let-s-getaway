import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class SelectMap extends StatefulWidget {
  SelectMap({Key? key}) : super(key: key);

  @override
  State<SelectMap> createState() => _SelectMapState();
}

class _SelectMapState extends State<SelectMap> {
  late final ArgumentCallback<LatLng> onTap;
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _theSelectLocation = CameraPosition(
    target: LatLng(13.8707137, 100.5484985),
    zoom: 16,
  );
  Set<Marker> _markers = {};
  late LocationData currentLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff86BACB),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          color: Colors.white,
          onPressed: () => {Navigator.pop(context, '')},
        ),
      ),
      body: Container(
        child: GoogleMap(
          markers: _markers,
          initialCameraPosition: _theSelectLocation,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          myLocationEnabled: true,
          onTap: _handleTap,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {
          if (_markers.isNotEmpty)
            {
              Navigator.pop(
                  context,
                  _markers.elementAt(0).position.latitude.toString() +
                      ', ' +
                      _markers.elementAt(0).position.longitude.toString())
            }
          else
            {Navigator.pop(context, '')}
        },
        label: Text('Confirm'),
      ),
    );
  }

  _handleTap(LatLng point) {
    _markers = {};
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: InfoWindow(
          title: 'Your location',
        ),
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      ));
    });
  }
}
