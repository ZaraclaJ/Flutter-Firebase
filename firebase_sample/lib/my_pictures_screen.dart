import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_sample/app_context.dart';
import 'package:firebase_sample/firebase_image.dart';
import 'package:firebase_sample/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyPictureScreen extends StatefulWidget {
  @override
  State createState() => new MyPictureScreenState();
}

class MyPictureScreenState extends State<MyPictureScreen> {
  final reference = FirebaseDatabase.instance.reference().child('images');
  List<FirebaseImage> images = [new FirebaseImage(1, "url1"), new FirebaseImage(2, "url2"), new FirebaseImage(3, "url3"),];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new GridView.builder(
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, ),
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) {
            return new GridTile(
                child: new Padding(
                  padding: new EdgeInsets.all(4.0),
                  child: new Container(
                    child: new Text(images[index].url),
                    color: Colors.primaries[index % Colors.primaries.length],
                  ),
                ),
            );
          }
      ),
    );
  }
}
