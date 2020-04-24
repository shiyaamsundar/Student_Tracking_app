import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class Abstent extends StatefulWidget {
  @override
  _AbstentState createState() => _AbstentState();
}

class _AbstentState extends State<Abstent> {
  getdata() async {
    Firestore.instance.collection('Attendance').getDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Absentees List'),
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
            ListTile(
              title: Text('Absentees List'),
              trailing: Icon(Icons.details),
              onTap: () {
                Navigator.pushNamed(context, 'absent');
              },
            ),
          ],
        ),
      ),
      body:ListPage(),
//      Column(
//        children: <Widget>[
//
//          //FlatButton.icon(onPressed: (){}, icon: Icon(Icons.search), label: Text('Track Students'))
//        ],
//      )
    );
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future getpost() async {
    var firestore = Firestore.instance;

    QuerySnapshot an = await firestore.collection('Attendance').getDocuments();
    print(an.documents[0]['Reg No']);
    return an.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getpost(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text("Loading........."),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, index) {
                  return InkWell(
                    child: Card(
                      child: Container(
                        margin: EdgeInsets.all(18),
                        child:InkWell(
                          onTap: (){

                          },
                          child: Column(
                            children: <Widget>[
                              Center(child: Text(snapshot.data[index].data['Reg No'])),
                            ],
                          ),
                        )

                      ),
                    ),
                  );
                });
          }
        },
      ),

    );
  }
}
