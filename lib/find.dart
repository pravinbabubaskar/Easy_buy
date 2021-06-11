//import 'dart:html';

//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lost_gifts/details.dart';
import 'package:url_launcher/url_launcher.dart';
class findPage extends StatefulWidget {

  @override
  _findPageState createState() => _findPageState();
}

class _findPageState extends State<findPage> {
  //var data;
  //double distance;


  _HotelPageState() {

  }

  //final dbRef = FirebaseFirestore.instance.reference.child("pets");


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

   todetails(dynamic document)
  {
    setState(() {
      Navigator.push(context,
            MaterialPageRoute(
              builder:(context)=>details(document)
          )
          );

      });

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
                  child:Center(
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
                                  /*Row(
                                    children:<Widget> [
                                      Text("  OWNER  :    ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                      Text(document['name'],style: TextStyle(fontSize: 15),),

                                  ],),
                                  SizedBox(height : 15),
                                  Row(
                                    children:<Widget> [
                                      Text("                 EMAIL   :    ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                  Text(document['Email'],style: TextStyle(fontSize: 15),),

                                  ],),
                                  SizedBox(height : 15),*/

                                    Row(
                                      children:<Widget> [
                                      Text("       DESCRIPTION   :   ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                  Text(document['description'],style: TextStyle(fontSize: 15),),

                                  ],),
                                  SizedBox(height : 15),
                                  Row(
                                    children:<Widget> [
                                      Text("      COST   :     ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                  Text(document['cost'],style: TextStyle(fontSize: 15),),

                                  ],),
                                 // SizedBox(height : 15),
                                  /*Row(
                                    children:<Widget> [
                                      Text("        CONTACT   :   ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                  Text(document['Contact'],style: TextStyle(fontSize: 15),),

                                      ],),*/
                                  SizedBox(height : 25),
                                  /*Center(
                                    child:
                                    Container(
                                      height: 40,
                                      width: 350,
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.only(top: 10, bottom: 10,left: 60,right: 60),
                                            //color: Colors.teal,
                                            primary: Colors.grey[300], // background
                                            //onPrimary: Colors.black,
                                            shape: new RoundedRectangleBorder(
                                              borderRadius: new BorderRadius.circular(20.0),
                                            ) // foreground
                                        ),

                                        //onPressed:  todetails(document),//document['Contact']),
                                        child: Text(
                                          'details',
                                          style: TextStyle(fontSize: 18,color: Colors.teal,),
                                        ),
                                      ),
                                    ),
                                  ),*/
                                  Row(
                                    children:<Widget> [
                                      SizedBox(width : 35),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 60,right: 60),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.only(top: 10, bottom: 10,left: 60,right: 60),
                                            primary: Colors.teal.shade200, // background
                                            onPrimary: Colors.white,
                                            shape: new RoundedRectangleBorder(
                                              borderRadius: new BorderRadius.circular(20.0),
                                            ) // foreground
                                        ),
                                        child: Text(
                                          'Details',
                                          style: TextStyle(
                                              fontFamily: 'Sans',
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                builder: (context) => details(document)
                                                ),
                                              );
                                        }
                                    ),
                                  ),
                                 ]),
                                  SizedBox(height : 35),
                                ],
                            ),
                            ],
                      ),
                    ],
                ),
                  ),
                  );
            }).toList()?? [],
          );
        },
      ),
    );
  }
}