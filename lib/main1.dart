


//import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:geolocator/geolocator.dart';
//void main() => runApp(Myapp());
//
//class Myapp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: Home(),
//      debugShowCheckedModeBanner: false,
//    );
//  }
//}
//
//class Home extends StatefulWidget {
//  @override
//  _HomeState createState() => _HomeState();
//}
//
//class _HomeState extends State<Home> {
//
//
//  final Map<String, Marker> _markers = {};
//  void _getLocation() async {
//    var currentLocation = await Geolocator()
//        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
//
//    setState(() {
//      _markers.clear();
//      final marker = Marker(
//        markerId: MarkerId("curr_loc"),
//        position: LatLng(currentLocation.latitude, currentLocation.longitude),
//        infoWindow: InfoWindow(title: 'Your Location'),
//      );
//      _markers["Current Location"] = marker;
//      print(marker);
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("MAPPPZZZ"),
//      ),
//
//      body: Center(
//        child: Container(
//          height: MediaQuery.of(context).size.height,
//          width: MediaQuery.of(context).size.width,
//          child:GoogleMap(
//            mapType: MapType.hybrid,
//            initialCameraPosition: CameraPosition(
//              target: LatLng(40.688841, -74.044015),
//              zoom: 11,
//            ),
//            markers: _markers.values.toSet(),
//          ),
//        ),
//
//     ),
//      floatingActionButton: FloatingActionButton(
//      onPressed: _getLocation,
//      tooltip: 'Get Location',
//      child: Icon(Icons.flag),
//    ),
//    );
//  }
//
//}

//import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Geolocation Google Maps Demo',
//      home: MyMap(),
//    );
//  }
//}
//
//class MyMap extends StatefulWidget {
//  @override
//  State<MyMap> createState() => MyMapSampleState();
//}
//
//class MyMapSampleState extends State<MyMap> {
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      body: GoogleMap(
//        mapType: MapType.hybrid,
//        initialCameraPosition: CameraPosition(
//          target: LatLng(40.688841, -74.044015),
//          zoom: 11,
//        ),
//      ),
//    );
//  }
//}

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:geocoder/geocoder.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoogleMapController mycontroller;
  String _locationMessage = "";
  var lat, long, inputadd,addresses,first;

  List<Marker> allMarkers = [];



  final Map<String, Marker> _markers = {};
fire() async{

  final coordinates = new Coordinates(lat, long);
  addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  first = addresses.first;

  Firestore.instance.collection('marker1').add({
    'coord': GeoPoint(lat, long),
    'place': first.adminArea+"  ,"+first.subAdminArea+"  ,"+first.addressLine,
  });

  print("${first.featureName} : ${first.addressLine}");
  print({first.subAdminArea});
  print('  ${first.adminArea}, ${first.subAdminArea},${first.addressLine}, ');

}
  void _getCurrentLocation() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    print('tepped');
    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId("curr_loc"),
        position: LatLng(currentLocation.latitude, currentLocation.longitude),
        infoWindow: InfoWindow(title: 'Your Location'),
      );
      lat=currentLocation.latitude;
      long=currentLocation.longitude;
      _markers["Current Location"] = marker;
      print(marker);
      mycontroller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(

        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 15,)),);

      fire();
    });
  }

//  void _getCurrentLocation() async {
//
//    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//    print(position);
//
//    setState(() {
//      lat=position.latitude;
//      long=position.longitude;
//      _locationMessage = "${position.latitude}, ${position.longitude}";
//      CameraPosition(
//          target: LatLng(lat,long),zoom: 10
//      );
//
//    });
//
//  }

//marker//

//  Future<void> _onMapCreated(GoogleMapController controller) async {
//    final googleOffices = await locations.getGoogleOffices();
//    setState(() {
//      _markers.clear();
//      for (final office in googleOffices.offices) {
//        final marker = Marker(
//          markerId: MarkerId(office.name),
//          position: LatLng(office.lat, office.lng),
//          infoWindow: InfoWindow(
//            title: office.name,
//            snippet: office.address,
//          ),
//        );
//        _markers[office.name] = marker;
//      }
//    });
//  }


  addtolist() async {
    Firestore.instance.collection('loc').add({
      'loc': inputadd,
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Markers'),
      ),


    );
    }
  }
