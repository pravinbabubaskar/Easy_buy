import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class details extends StatefulWidget {
  dynamic document;
  details(this.document);
  @override
  _detailPageState createState() => _detailPageState();
}

class _detailPageState extends State<details> {
  Future<void> _launched;
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DETAILS"),
        centerTitle: true,
        backgroundColor: Colors.teal[100],
      ),
      body: Container(
        child:Center(
        child:Column(
          children:<Widget> [
            SizedBox(height : 15),
            Image.network(
              widget.document['p_url'],
              width: 250,
              height:250,
            ),
            SizedBox(height : 15),
            Row(
              children:<Widget> [

                    SizedBox(width:20),
                                     Text("OWNER          :     ",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold, color: Colors.teal,),textAlign: TextAlign.left),
                                      Text(widget.document['name'],style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),

                                  ],),

                                  SizedBox(height : 15),
                                  Row(
                                    children:<Widget> [
                                      SizedBox(width:20),
                                      Text("EMAIL            :   ",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold, color: Colors.teal),textAlign: TextAlign.left),
                                  Text(widget.document['Email'],style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),

                                  ],),
                                  SizedBox(height : 15),

            Row(
              children:<Widget> [
                SizedBox(width:20),
                Text("DESCRIPTION : ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold, color: Colors.teal),textAlign: TextAlign.left),
                Text(widget.document['description'],style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),

              ],),
            SizedBox(height : 15),
            Row(
              children:<Widget> [
                SizedBox(width:20),
                Text("COST             :    ",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold, color: Colors.teal),textAlign: TextAlign.left),
                Text(widget.document['cost'],style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),

              ],),
            SizedBox(height : 15),
            Row(
              children:<Widget> [
                SizedBox(width:20),
                Text("CONTACT     :  ",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold, color: Colors.teal),textAlign: TextAlign.left),
                Text(widget.document['Contact'],style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),

              ],),
            SizedBox(height : 35),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15,left: 60,right: 60),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(top: 15, bottom: 15,left: 60,right: 60),
                      primary: Colors.teal.shade200, // background
                      onPrimary: Colors.white,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ) // foreground
                  ),
                  child: Text(
                    'Contact',
                    style: TextStyle(
                        fontFamily: 'Sans',
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  onPressed: () => setState(() {
                    String n=widget.document['Contact'].toString(),
    _launched = _makePhoneCall('tel:$n') as String;
    }),
    ),

              ),
           // ),

          ],

        ),
      ),
      ),
    );
  }

}