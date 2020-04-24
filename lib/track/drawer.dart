import 'package:flutter/material.dart';

class drawer extends StatefulWidget {
  @override
  _drawerState createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SKCT Student Tracker'),

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
              trailing: Icon(Icons.verified_user),
              onTap: () {
                Navigator.pushNamed(context, 'absent');
              },

            ),
      ListTile(
        title: Text('Track Absentees'),
        trailing: Icon(Icons.input),
        onTap: () {
          Navigator.pushNamed(context, 'absent');
        },),
          ],
        ),
      ),
    );
  }
}
