import 'package:flutter/material.dart';
import 'SimpleRound.dart';
import 'package:flutter_icons/flutter_icons.dart';
class Studetailspage extends StatefulWidget {


  var regno,name,address,phone,ten,twel,dob,aadhar,gender,city,email;

  Studetailspage({Key key,this.regno,this.name,this.gender,this.email,this.phone,this.dob,this.address,this.city,this.ten,this.twel}) : super(key: key);



  @override
  _StudetailspageState createState() => _StudetailspageState();
}

class _StudetailspageState extends State<Studetailspage> {

  var regno,name,address,phone,ten,twel,dob,aadhar,gender,city,email;
 @override
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Details Page'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 30,right: 20),
        child: Column(
         children: <Widget>[
           Padding(padding: EdgeInsets.only(top: 50,left: 20)),
           Row(
             children: <Widget>[
               Text(widget.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800)),
               Text('   Details:-',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800)),
             ],

           ),
           SizedBox(height: 50,),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               Text('Register No:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
               SizedBox(width: 20),
               Expanded(
                 flex: 1,
                 child: Center(
                   child: Text(widget.regno,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                 ),
               ),
             ],
           ),
           SizedBox(height: 20),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               Text('Name:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
               SizedBox(width: 15,),
               Expanded(
                 flex: 1,
                 child: Center(
                   child: Text(widget.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                 ),

               ),
             ],
           ),
           SizedBox(height: 20),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               Text('Email:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
               Expanded(
                 flex: 1,
                 child: Center(
                   child: Text(widget.email,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                 ),
               ),
               FlatButton.icon(onPressed: (){}, icon: Icon(Icons.mail,color: Colors.green,), label: Text('Mail'))
             ],
           ),
           SizedBox(height: 20),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               Text('Contact:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
               Expanded(
                 flex: 1,
                 child: Center(
                   child: Text(widget.phone,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                 ),
               ),
               FlatButton.icon(onPressed: (){}, icon: Icon(Icons.phone,color: Colors.blue,), label: Text('call'))
             ],
           ),
           SizedBox(height: 20),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[

               Text('Address:   ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
               Expanded(
                 flex: 1,
                   child: Center(
                     child: Text(widget.address,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                   ),

                   ),
             ],
           ),
           SizedBox(height: 20),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               Text('12th Percenrage:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
               Expanded(
                 flex: 1,
                 child: Center(
                   child: Text(widget.twel,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                 ),

               ),
             ],
           ),
           SizedBox(height: 20),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               Text('10th details:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

               Expanded(
                 flex: 1,
                 child: Center(
                   child: Text(widget.ten,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                 ),

               ),
             ],
           ),


         ],
        ),
      ),


   );


  }
}

