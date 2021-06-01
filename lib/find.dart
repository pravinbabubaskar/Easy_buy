import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class HotelPage extends StatefulWidget {

  @override
  _HotelPageState createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
  var data;
  double distance;


  _HotelPageState() {

  }

  //final dbRef = FirebaseFirestore.instance.reference.child("pets");


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("FOR SALE"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.teal[100],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data.docs.map((document) {
              return Container(
                child:Column(
                    children:<Widget> [
                      SizedBox(height : 10),
                      Image.network(
                        document['p_url'],
                        width: 250,
                        height:250,
                      ),
                      SizedBox(height : 30),
                      Row(
                          children:<Widget> [

                            Column(
                                children:<Widget> [
                                  Row(
                                    children:<Widget> [
                                      Text("  OWNER  :    ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                      Text(document['name'],style: TextStyle(fontSize: 15),),
                                      SizedBox(height : 25),
                                  ],),
                                  Row(
                                    children:<Widget> [
                                      Text("                 EMAIL   :    ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                  Text(document['Email'],style: TextStyle(fontSize: 15),),
                                      SizedBox(height : 25),
                                  ],),
                                    Row(
                                      children:<Widget> [
                                      Text("       DESCRIPTION   :   ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                  Text(document['description'],style: TextStyle(fontSize: 15),),
                                        SizedBox(height : 25),
                                  ],),
                                  Row(
                                    children:<Widget> [
                                      Text("      COST   :     ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                  Text(document['cost'],style: TextStyle(fontSize: 15),),
                                      SizedBox(height : 25),
                                  ],),
                                  Row(
                                    children:<Widget> [
                                      Text("        CONTACT   :   ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                  Text(document['Contact'],style: TextStyle(fontSize: 15),),
                                      SizedBox(height : 25),
                                      ],),
                                ],
                            ),
                            ],
                      ),
                    ],
                ),

                  );
            }).toList(),
          );
        },
      ),
    );
  }
}