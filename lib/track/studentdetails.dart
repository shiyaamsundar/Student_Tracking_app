import 'package:flutter/material.dart';
import 'dart:convert';
import 'studetailspage.dart';
import 'package:gmapmarker/signin/FlipLoader.dart';
class StudDetails extends StatefulWidget {
  @override
  _StudDetailsState createState() => _StudDetailsState();
}

class _StudDetailsState extends State<StudDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Of Students'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Attendance'),
              trailing: Icon(Icons.pageview),
              onTap: () {
                Navigator.pushNamed(context, 'attendance');
              },
            ),
            ListTile(
              title: Text('Student Details'),
              trailing: Icon(Icons.details),
              onTap: () {
                Navigator.pushNamed(context, 'studdetails');
              },
            ),
          ],
        ),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            future:
                DefaultAssetBundle.of(context).loadString('assets/data.json'),
            builder: (context, snapshot) {
              var mydata = jsonDecode(snapshot.data.toString());
              return ListView.builder(
                  itemCount: mydata == null ? 0 : mydata.length,
                  itemBuilder: (BuildContext context, index) {
                    return InkWell(
                      child: Card(
                          child: Container(
                        margin: EdgeInsets.all(18),
                        child: InkWell(
                          onTap: () {


                            var rout=MaterialPageRoute(builder: (BuildContext conext)=>
                                Studetailspage(regno:mydata[index]["field2"] ,name:mydata[index]["field3"] ,
                                  gender:mydata[index]["field4"] ,email:mydata[index]["field11"] ,phone:mydata[index]["field10"] ,dob:mydata[index]["field5"] ,address:mydata[index]["field6"] ,
                                  city:mydata[index]["field8"] ,ten:mydata[index]["field16"] ,twel:mydata[index]["field19"] ,));
////                                Studetailspage({Key key,this.regno,this.name,this.gender,this.email,this.phone,this.dob,this.address,this.city,this.ten,this.twel}) : super(key: key);
                                print(mydata[index]["field3"]);
                            Navigator.push(context,rout);
                            //Navigator.of(context).pushNamed('/studpage');


                          },
                          child: Column(
                            children: <Widget>[
                              Text(mydata[index]['field2'].toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                              SizedBox(
                                height: 4,
                              ),
                              Text(mydata[index]["field3"].toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
                              SizedBox(height: 7),

//                            Text(mydata[index]['description'].toString()),
                            ],
                          ),
                        ),
                      )),
                    );
                  });
            },
          ),
        ),
      ),
    );
  }
}
