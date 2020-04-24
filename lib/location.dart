import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:geocoder/geocoder.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoogleMapController mycontroller;
  String _locationMessage = "";
  var lat, long, inputadd, addresses, first, leen;
  PageController _pageController;
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


  populate() {
    Firestore.instance.collection('marker').getDocuments().then((docs) {
      if (docs.documents.isNotEmpty) {
        for (int i = 0; i < docs.documents.length; ++i) {
          initMarker(docs.documents[i].data, docs.documents[i].documentID);
          //mapmaeker(docs.documents[i]);

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

  mapmaeker(index) {
    return AnimatedBuilder(animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double val = 1;
        if (_pageController.position.haveDimensions) {
          val = _pageController.page-index;
          val = (1 - (val.abs() * 0.31 + 0.06).clamp(0.0, 1.0));
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(val),
            width: Curves.easeInOut.transform(val),
            child:  widget,
          ),
        );
      },
      child: InkWell(
        onTap: (){},
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 10,vertical: 20
                ),
                height: 125,
                width: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow:[
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(0.0, 4.0),
                          blurRadius: 10.0
                      )
                    ]
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 90,
                        width:90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10),

                          ),

                        ),

                      ),
                      SizedBox(width: 5,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  int initMarker(request, requestId) {
    var markerIdval = requestId;
    final MarkerId markerId = MarkerId(markerIdval);
    final Marker marker = Marker(
      markerId: markerId,

      position: LatLng(request['coord'].latitude, request['coord'].longitude),
      infoWindow: InfoWindow(
        title: request['name'], snippet: request['regno'],),


    );
    setState(() {
      markers[markerId] = marker;
      leen = totalLikes();
      print(markerId);
    });
  }


  Future totalLikes() async {
    var respectsQuery = Firestore.instance
        .collection('markers');
    var querySnapshot = await respectsQuery.getDocuments();
    var totalEquals = querySnapshot.documents.length;
    return totalEquals;
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
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height - 90.0,
            width: MediaQuery
                .of(context)
                .size
                .width,
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
//          Positioned(
//            child: Container(
//              child: PageView.builder(controller: _pageController,
//                itemCount: leen,
//                itemBuilder: (BuildContext context) {
//                  return populate();
//                },),
//            ),
//
//          ),

//          Flexible(
//            child: TextField(
//              onChanged: (String loc) {
//                setState(() {
//                  inputadd = loc;
//                });
//              },
//            ),
////
//          ),
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
