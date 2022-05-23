import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String mapkey = "AIzaSyBuk_qn-EYEE0hdymDNnGyQGAQeA9ojjnw";

class mapsClient extends StatefulWidget {
  const mapsClient({Key? key}) : super(key: key);

  @override
  _mapsClientState createState() => _mapsClientState();
}

class _mapsClientState extends State<mapsClient> {
  double lati = 0;
  double long = 0.0;
  String name = "";
  String job = "";
  Set<Marker> mkrs = {};
  Set<Polyline> plns = {};
  List<LatLng> ll = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gt();
  }

  void gt() async {
    CollectionReference _guide =
        await FirebaseFirestore.instance.collection('client');
    QuerySnapshot query = await _guide.get();
    query.docs.forEach((document) {
      lati = document['lat'];
      long = document['long'];
      name = document['name'];
      job = document['job'];
      if (job == 'Guide') {
        name = name + '(Guide)';
      }
      print(name);
      Position? position;
      position?.latitude = 0.0;
      position?.longitude = 0.0;
      ll.add(LatLng(lati, long));
      Marker m = Marker(
          markerId: MarkerId('$name'),
          infoWindow: InfoWindow(title: '$name'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          position: LatLng(lati, long));
      Polyline p = Polyline(
        polylineId: PolylineId(position.toString()),
        visible: true,
        points: ll,
      );
      setState(() {
        lati = 0;
        long = 0;
        mkrs.add(m);
        plns.add(p);
      });
    });
  }

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? newgooglecontroller;
  Position? currentPosition;
  var geoLocator = Geolocator();

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latlng = LatLng(position.latitude, position.longitude);
    CameraPosition cameraposition =
        new CameraPosition(target: latlng, zoom: 14);
    newgooglecontroller
        ?.animateCamera(CameraUpdate.newCameraPosition(cameraposition));
  }

  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.terrain,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            myLocationEnabled: true,
            markers: mkrs,
            onMapCreated: (GoogleMapController controller) {
              Completer<GoogleMapController> _controller = Completer();
              GoogleMapController? newgooglecontroller;
              locatePosition();
            },
            polylines: plns,
          ),
        ],
      ),
    );
  }
}
