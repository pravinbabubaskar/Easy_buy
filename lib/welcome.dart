import 'package:flutter/material.dart';
class welcome extends StatefulWidget{
  @override

  _WelcomeState createState() => _WelcomeState();
}


class _WelcomeState extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   // throw UnimplementedError();
    return Scaffold(
     appBar: AppBar(
       title: Text("WELCOME"),
     ),
    );
  }

}