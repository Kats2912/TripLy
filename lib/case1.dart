import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class case1 extends StatefulWidget {
  const case1({Key? key}) : super(key: key);

  @override
  State<case1> createState() => _case1State();
}

class _case1State extends State<case1> {

double lati=0;
double long=0;
String name="";
Set<Marker> mkrs={};
@override

  void initState() {
    // TODO: implement initState
    super.initState();
   gt();

  }
void gt() async{

  CollectionReference _guide =
  await FirebaseFirestore.instance.collection('client');
  QuerySnapshot query = await _guide.get();
  query.docs.forEach((document) {
    lati = document['lat'];
    long = document['long'];
    name=document['name'];
    print(name);
 Marker m= Marker(
     markerId: MarkerId('$name'),
     infoWindow: InfoWindow(title: '$name'),
     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
     position: LatLng(lati, long)
 );
    setState(() {
lati=0;
long=0;
mkrs.add(m);
    });
  });

}
Completer<GoogleMapController> _controller = Completer();
GoogleMapController? newgooglecontroller;
Position? currentPosition;
var geoLocator = Geolocator();

void locatePosition() async {
  Position position = await Geolocator.getCurrentPosition(
      );
  currentPosition = position;
  LatLng latlng = LatLng(position.latitude, position.longitude);
  CameraPosition cameraposition =
  new CameraPosition(target: latlng, zoom: 14);
  newgooglecontroller
      ?.animateCamera(CameraUpdate.newCameraPosition(cameraposition));
  print(position.latitude);
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
              mapType: MapType.hybrid,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              myLocationEnabled: true,
              markers: mkrs,
              onMapCreated: (GoogleMapController controller) {
                Completer<GoogleMapController> _controller = Completer();
                GoogleMapController? newgooglecontroller;
                locatePosition();
              }),
        ],
      ),
    );
  }
}
