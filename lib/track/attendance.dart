import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Att extends StatefulWidget {
  @override
  _AttState createState() => _AttState();
}

class _AttState extends State<Att> {
  List<bool> input=List<bool>();
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      for(int i=0;i<61;i++){
        input.add(false);
      }
    });

  }

  void itemchange(bool val,int index){
    setState(() {
      input[index]=val;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Attendance'),
              trailing: Icon(Icons.pageview),
              onTap: () {
                Navigator.pushNamed(context, '/attendance');
              },
            ),
            ListTile(
              title: Text('Student Details'),
              trailing: Icon(Icons.details),
              onTap: () {
                Navigator.pushNamed(context, '/studdetails');
              },
            ),
            ListTile(
              title: Text('Absentees List'),
              trailing: Icon(Icons.pageview),
              onTap: () {
                Navigator.pushNamed(context, '/absent');
              },
            ),
          ],
        ),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            future:
                DefaultAssetBundle.of(context).loadString('assets/num.json'),
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
                          onTap: () {},
                          child: Column(
                            children: <Widget>[

                                    CheckboxListTile(

                                      value:input[index],
                                      controlAffinity: ListTileControlAffinity.leading,
                                      title:Text(mydata[index]["STUDENST NAME"]
                                          .toString()),
                                      subtitle: Text(mydata[index]['ROLL NO'].toString(),style: TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),),
                                      onChanged: (value) {
                                        Firestore.instance
                                            .collection('Attendance')
                                            .add({
                                          'Reg No':mydata[index]['ROLL NO'].toString(),
                                          'att':1,

                                        });

                                          itemchange(value,index);
                                        },
                                    )

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
