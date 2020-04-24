import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'location.dart';
import 'signin/signin.dart';
import 'signin/signup.dart';
import 'track/attendance.dart';
import 'track/drawer.dart';
import 'track/studentdetails.dart';
import 'track/studetailspage.dart';
import 'track/absent.dart';
import 'payment.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: drawer(),
    debugShowCheckedModeBanner: false,
    routes: <String, WidgetBuilder>{
      '/main': (BuildContext context) => Home(),
      '/signin':(BuildContext context)=>Signin(),
      '/signup':(BuildContext context)=>SignupPage(),
      '/draw':(BuildContext context)=>drawer(),
      '/attendance':(BuildContext context)=>Att(),
      '/stddetails':(BuildContext context)=>StudDetails(),
      '/studpage':(BuildContext context)=>Studetailspage(),
      '/absent':(BuildContext context)=>Abstent(),



    }
    );
  }
}

