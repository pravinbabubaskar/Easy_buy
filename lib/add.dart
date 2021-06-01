import 'dart:io';
//import 'package:feedthenead/Hotel/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:feedthenead/helpers/style.dart';
//import 'package:feedthenead/widgets/custom_file_button.dart';
//import 'package:feedthenead/widgets/custom_text.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lost_gifts/welcome.dart';
import 'custom_file_button.dart';
//import '../constants.dart';

class addProduct extends StatefulWidget {
  //final String _id;

  addProduct();
  @override
  _addProductState createState() => _addProductState();
}

class _addProductState extends State<addProduct> {
  final _key = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int dropdownValue = 1;
  int quantity = 1;

  String name, des, contact, mail;
  File _image;
  final picker = ImagePicker();
  final _firebaseStorage = FirebaseStorage.instance;
  String imageUrl;
  CollectionReference users = FirebaseFirestore.instance.collection('Items');

  String e = "Product Addedd Successfully..";
  Future pickImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }
  }

  Future uploadImage() async {
    setState(() async {
      if (_image != null) {
        //Upload to Firebase

        var snapshot = await _firebaseStorage
            .ref()
            .child('Product_img/"ITEMS"/${des}')
            .putFile(_image)
            .whenComplete(() {});

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
          users.doc('BnorNcW1pGkX8xlB0lQZ').update({
            "item"
             :
            FieldValue.
            arrayUnion([
              {
                "name": name,
                "Contact": contact,
                "description": des,
                "Email": mail,
                "p_url": imageUrl,

              },
            ]),
          }).then((value) {
            print("product Updated");

          }).catchError((error) => print("Failed to update image: $error"));
          print(imageUrl);
        });
      } else {
        print('No Image Path Received');
      }
    });
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Upload',
              //style: errorStyle,
            ),
            content: Text(
              errormessage,
              //style: messageStyle,
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => welcome()));
                    });
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  openLoadingDialog(BuildContext context, String text) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          content: Row(children: <Widget>[
            SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                    strokeWidth: 1,
                    valueColor: AlwaysStoppedAnimation(Colors.black))),
            SizedBox(width: 10),
            Text(text)
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.teal[100],
          title: Text(
            "Add Product",
            style: TextStyle(color: Colors.black),
          )),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
              height: 130,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: CustomFileUploadButton(
                      icon: Icons.image,
                      text: "Add image",
                      onTap: () async {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext bc) {
                              return Container(
                                child: new Wrap(
                                  children: <Widget>[
                                    new ListTile(
                                        leading: new Icon(Icons.image),
                                        title: new Text('From gallery'),
                                        onTap: () async {
                                          pickImage(ImageSource.gallery);

                                          Navigator.pop(context);
                                        }),
                                    new ListTile(
                                        leading: new Icon(Icons.camera_alt),
                                        title: new Text('Take a photo'),
                                        onTap: () async {
                                          pickImage(ImageSource.camera);

                                          Navigator.pop(context);
                                        }),
                                  ],
                                ),
                              );
                            });
                      },
                    ),
                  )
                ],
              ),
            ),
            Visibility(
              child: FlatButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext bc) {
                          return Container(
                            child: new Wrap(
                              children: <Widget>[
                                new ListTile(
                                    leading: new Icon(Icons.image),
                                    title: new Text('From gallery'),
                                    onTap: () async {
                                      pickImage(ImageSource.gallery);

                                      Navigator.pop(context);
                                    }),
                                new ListTile(
                                    leading: new Icon(Icons.camera_alt),
                                    title: new Text('Take a photo'),
                                    onTap: () async {
                                      pickImage(ImageSource.camera);

                                      Navigator.pop(context);
                                    }),
                              ],
                            ),
                          );
                        });
                  },
                  child: Text(
                     "Change Image",style: TextStyle(color: Colors.grey,
                    fontFamily: "poppin",
                    fontSize: 16.0,),

                  )),
            ),

            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 0.2),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(2, 7),
                          blurRadius: 7)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: TextFormField(
                      validator: (input) {
                        if (input.isEmpty) return 'Email id';
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email id",
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: "raleway",
                              fontSize: 18)),
                      onSaved: (input) => mail = input),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 0.2),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(2, 7),
                          blurRadius: 7)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: TextFormField(
                      validator: (input) {
                        if (input.isEmpty) return 'Name';
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Name",
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: "raleway",
                              fontSize: 18)),
                      onSaved: (input) => name = input[0].toUpperCase() +
                          input.substring(1).toLowerCase()),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 0.2),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(2, 7),
                          blurRadius: 7)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: TextFormField(
                      validator: (input) {
                        if (input.isEmpty) return 'Enter product Description';
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Product description",
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: "raleway",
                              fontSize: 18)),
                      onSaved: (input) => des = input[0].toUpperCase() +
                          input.substring(1).toLowerCase()),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 0.2),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(2, 7),
                          blurRadius: 7)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: TextFormField(
                      validator: (input) {
                        if (input.isEmpty && input.length <10) return 'Contact No.';
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Contact No.",
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: "raleway",
                              fontSize: 18)),
                      onSaved: (input) => contact = input),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              child: Container(
                  decoration: BoxDecoration(
                     // color: primary,
                      border: Border.all(color: Colors.black, width: 0.2),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            offset: Offset(2, 7),
                            blurRadius: 4)
                      ]),
                  child: FlatButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        uploadImage();
                        openLoadingDialog(context, "Uploading...");
                        Future.delayed(const Duration(seconds: 5), () {
                          showError(e);
                        });
                      }
                    },
                    child: Text(
                       "Post",style: TextStyle(color: Colors.black,
                      fontFamily: "poppin",
                      fontSize: 20.0,),

                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}