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
  var lat, long, inputadd, addresses, first;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  List<Marker> allMarkers = [];

  final Map<String, Marker> _markers = {};

  fire() async {
    final coordinates = new Coordinates(lat, long);
    addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    first = addresses.first;

    Firestore.instance.collection('marker').add({
      'coord': GeoPoint(lat, long),
      'place': first.adminArea +
          "  ," +
          first.subAdminArea +
          "  ," +
          first.addressLine,
    });

    // print("${first.featureName} : ${first.addressLine}");
    //print({first.subAdminArea});
    //print('  ${first.adminArea}, ${first.subAdminArea},${first.addressLine}, ');
  }

  populate(){
    Firestore.instance.collection('marker').getDocuments().then((docs){
      if(docs.documents.isNotEmpty){
        for(int i=0;i<docs.documents.length;++i)
        {
          if(i==0) {
            print(docs.documents[i].documentID);
          }initMarker(docs.documents[i].data,docs.documents[i].documentID);
//            final marker = Marker(
//              markerId: MarkerId("curr_loc"),
//              position: LatLng(docs.documents[i].data,docs.documents[i].data),
//              infoWindow: InfoWindow(title: 'Your Location'),
//            );

        }
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    _getCurrentLocation();
    populate();
    super.initState();
  }
  int initMarker(request,requestId){
    var markerIdval=requestId;
    final MarkerId markerId=MarkerId(markerIdval);
    final Marker marker=Marker(
      markerId: markerId,

      position: LatLng(request['coord'].latitude,request['coord'].longitude),
      infoWindow: InfoWindow(title: "Fetched Marker",snippet: request['place']),


    );
    setState(() {
      markers[markerId]=marker;
      print(markerId);
    });
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
      lat = currentLocation.latitude;
      long = currentLocation.longitude;
      _markers["Current Location"] = marker;
      print(marker);
      mycontroller.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: 15,
        )),
      );

      fire();
    });
  }


  addtolist() async {
    Firestore.instance.collection('loc').add({
      'loc': inputadd,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("locations"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 90.0,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              compassEnabled: true,
              mapType: MapType.hybrid,
              onMapCreated: (controller) {
                mycontroller = controller;
              },
              initialCameraPosition: CameraPosition(
//target: LatLng(40.688841, -74.04401),
                target: LatLng(11.0102, 76.9504),
                zoom: 15,
              ),
              markers: Set<Marker>.of(markers.values),
            ),
          ),
          Flexible(
            child: TextField(
              onChanged: (String loc) {
                setState(() {
                  inputadd = loc;
                });
              },
            ),
//
          ),
//    SimpleDialogOption(
//    child: Text("Add it"),
//    onPressed: addtolist,
//    )
        ],
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _getCurrentLocation,
//        tooltip: 'Get Location',
//        child: Icon(Icons.flag),
//      ),
    );
  }
}
