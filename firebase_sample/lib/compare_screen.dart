import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_sample/app_context.dart';
import 'package:firebase_sample/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CompareScreen extends StatefulWidget {
  @override
  State createState() => new CompareScreenState();
}

class CompareScreenState extends State<CompareScreen> {
  final reference = FirebaseDatabase.instance.reference().child('messages');

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Expanded(
          child: new InkWell(
            onTap: () => _voteTop(context),
            child: new Container(
              color: Colors.green,
              child: new Image.asset("assets/cat/cat2.jpeg"),
            ),
          ),
        ),
        new Divider(height: 1.0),
        new Expanded(
          child: new InkWell(
            onTap: () => _voteBot(context),
            child: new Container(
              color: Colors.red,
              child: new Image.asset("assets/cat/cat1.jpeg"),
            ),
          ),
        ),
      ]
    );
  }

  _voteTop(BuildContext context) {
    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("You voted for the top picture")));
  }

  _voteBot(BuildContext context) {
    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("You voted for the bottom picture")));
  }
}
