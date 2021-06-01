import 'package:flutter/material.dart';
import 'package:lost_gifts/add.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lost_gifts/find.dart';
import 'find.dart';
import 'login.dart';
class welcome extends StatefulWidget{
  @override

  _WelcomeState createState() => _WelcomeState();
}



class _WelcomeState extends State<welcome> {
  void toadd()
  {
    Navigator.push(context,
        MaterialPageRoute(
            builder:(context)=>addProduct()
        )
    );
  }

  void tofind()
  {
    Navigator.push(context,
        MaterialPageRoute(
            builder:(context)=>HotelPage()
        )
    );
  }
   void Signout() async
  {
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.signOut();

  Navigator.pushReplacement(

      context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   // throw UnimplementedError();
    AssetImage assetimage=AssetImage('images/MC1.png');
    Image image=Image(image:assetimage,width: 250,height: 450,);
    return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.teal[100],
       title: Text("WELCOME"),
     ),
      body: Container(
        child:Column(
          children:<Widget>[
            image,
            //SizedBox(height: 20,),
              Center(
                child:
                Container(
                  height: 40,
                  width: 250,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(top:5, bottom: 5),
                            //color: Colors.teal,
                            primary: Colors.grey[300], // background
                            //onPrimary: Colors.white,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),

                            ) // foreground
                        ),
                        onPressed:toadd,
                        child: Text(
                          'ADD ITEMS',
                          style: TextStyle(fontSize: 15,color: Colors.teal,),
                        ),
                        ),
                ),
              ),
              SizedBox(height: 15,),
            Center(
              child:
              Container(
                height: 40,
                width: 250,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      //color: Colors.teal,
                      primary: Colors.grey[300], // background
                      //onPrimary: Colors.black,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ) // foreground
                  ),
                  onPressed: tofind,
                  child: Text(
                    'FIND',
                    style: TextStyle(fontSize: 15,color: Colors.teal,),
                  ),
                ),
              ),
            ),

            SizedBox(height: 15,),
            Center(
              child:
              Container(
                height: 40,
                width: 250,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      //color: Colors.teal,
                      primary: Colors.grey[300], // background
                      //onPrimary: Colors.black,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ) // foreground
                  ),
                  onPressed: Signout,
                  child: Text(
                    'Log Out',
                    style: TextStyle(fontSize: 15,color: Colors.teal,),
                  ),
                ),
              ),
            ),

          ]
        ),
      ),
    );
  }

}