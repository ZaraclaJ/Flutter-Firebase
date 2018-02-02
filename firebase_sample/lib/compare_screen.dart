import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_sample/app_context.dart';
import 'package:firebase_sample/drawer.dart';
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
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Compare pictures"),
          elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.account_circle), onPressed: AppContext.of(context).ensureLoggedIn),
          ]
      ),
      drawer: new DrawerContent(),
      body: new SafeArea(
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new ImageCard(Position.Top),
              new Divider(height: 8.0,),
              new ImageCard(Position.Bot),
            ]
        ),
      ),
    );
  }
}

enum Position{
  Top,
  Bot,
}

class ImageCard extends StatelessWidget {
  final Position position;

  ImageCard(this.position);

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new InkWell(
        onTap: () => _vote(context, position),
        child: new Stack(
          children: <Widget>[
            position == Position.Bot ? new Image.asset("assets/cat/cat1.jpeg",fit: BoxFit.cover,) : new Image.asset("assets/cat/cat2.jpeg",fit: BoxFit.cover,),
            new BackdropFilter(
              filter: new ui.ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
              child: new Container(
                decoration: new BoxDecoration(color: Colors.grey[200].withOpacity(0.1)),
              ),
            ),
            position == Position.Bot ? new Image.asset("assets/cat/cat1.jpeg", fit: BoxFit.contain,) : new Image.asset("assets/cat/cat2.jpeg", fit: BoxFit.contain,),
            
          ],
          fit: StackFit.passthrough,
        ),
      ),
    );
  }

  _vote(BuildContext context, Position vote) {
    switch (vote){
      case Position.Bot :
        Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("You voted for the bottom picture")));
        break;
      case Position.Top :
        Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("You voted for the top picture")));
        break;
    }
  }
}
