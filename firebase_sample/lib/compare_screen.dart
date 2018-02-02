import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_sample/app_context.dart';
import 'package:firebase_sample/drawer.dart';
import 'package:firebase_sample/firebase_image.dart';
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
  final _reference = FirebaseDatabase.instance.reference().child('images');
  List<FirebaseImage> _allCats = new List();
  Random random = new Random();
  int randomIndexTop;
  int randomIndexBot;

  @override
  void initState() {
    _getCats();
    super.initState();
  }

  _getCats() {
    _reference.onChildAdded.listen(_onEntryAdded);
  }
  _onEntryAdded(Event event) {
    setState(() {
      _allCats.add(new FirebaseImage.fromSnapshot(event.snapshot));
      generateRandomIndexes();
    });
  }

  void generateRandomIndexes(){
    randomIndexTop = random.nextInt(_allCats.length);
    randomIndexBot = random.nextInt(_allCats.length);
    int i = 0;
    while (randomIndexTop == randomIndexBot && i < 50){
      randomIndexBot = random.nextInt(_allCats.length);
      i++;
    }
    print("top : $randomIndexTop, bot : $randomIndexBot");
  }

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
              new ImageCard(Position.Top, _allCats[randomIndexTop], vote),
              new Divider(height: 8.0,),
              new ImageCard(Position.Bot, _allCats[randomIndexBot], vote),
            ]
        ),
      ),
    );
  }

  vote(BuildContext context, Position vote) {
    switch (vote){
      case Position.Bot :
        Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("You voted for the bottom picture")));
        break;
      case Position.Top :
        Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("You voted for the top picture")));
        break;
    }
    setState(() {
      generateRandomIndexes();
    });
  }
}

enum Position{
  Top,
  Bot,
}

class ImageCard extends StatelessWidget {
  final Position position;
  final FirebaseImage image;
  final Function(BuildContext context, Position position) vote;

  ImageCard(this.position, this.image, this.vote);

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new InkWell(
        onTap: () => vote(context, position),
        child: new Stack(
          children: <Widget>[
            new Image.network(image.url,fit: BoxFit.cover,),
            new BackdropFilter(
              filter: new ui.ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
              child: new Container(
                decoration: new BoxDecoration(color: Colors.grey[200].withOpacity(0.1)),
              ),
            ),
            new Image.network(image.url,fit: BoxFit.contain,),
          ],
          fit: StackFit.passthrough,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
