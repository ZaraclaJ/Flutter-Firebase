import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_sample/app_context.dart';
import 'package:firebase_sample/compare_context.dart';
import 'package:firebase_sample/drawer.dart';
import 'package:firebase_sample/firebase_image.dart';
import 'package:firebase_sample/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CompareScreenContainer extends StatefulWidget {
  @override
  State createState() => new CompareScreenContainerState();
}

class CompareScreenContainerState extends State<CompareScreenContainer> {
  ComparePicturesContextData comparePicturesContextData;

  final _reference = FirebaseDatabase.instance.reference().child('images');

  @override
  void initState() {
    comparePicturesContextData = new ComparePicturesContextData(allCats: new List(), topIndex: -1, botIndex: -1);
    _getCats();
    super.initState();
  }

  _getCats() {
    _reference.onChildAdded.listen(_onEntryAdded);
  }
  _onEntryAdded(Event event) {
    setState(() {
      comparePicturesContextData.allCats.add(new FirebaseImage.fromSnapshot(event.snapshot));
      _updateIndexes();
    });
  }

  _updateIndexes() {
    Random random = new Random();
    int randomIndexTop = random.nextInt(comparePicturesContextData.allCats.length);
    int randomIndexBot = random.nextInt(comparePicturesContextData.allCats.length);
    int i = 0;
    while (randomIndexTop == randomIndexBot && i < 50){
      randomIndexBot = random.nextInt(comparePicturesContextData.allCats.length);
      i++;
    }
    setState(() {
      comparePicturesContextData = comparePicturesContextData.withIndexes(randomIndexTop, randomIndexBot);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new ComparePicturesContext(
        child: new CompareScreen(),
        comparePicturesContextData: comparePicturesContextData,
        updateIndexes: _updateIndexes,
    );
  }
}

class CompareScreen extends StatelessWidget {

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
            children: _getPage(context)
        ),
      ),
    );
  }

  _getPage(BuildContext context) {
    if (ComparePicturesContext.of(context).comparePicturesContextData.topIndex != -1 && ComparePicturesContext.of(context).comparePicturesContextData.botIndex != -1){
      return <Widget>[
        new ImageCard(Position.Top, ComparePicturesContext.of(context).comparePicturesContextData.allCats[ComparePicturesContext.of(context).comparePicturesContextData.topIndex]),
        new Divider(height: 8.0,),
        new ImageCard(Position.Bot, ComparePicturesContext.of(context).comparePicturesContextData.allCats[ComparePicturesContext.of(context).comparePicturesContextData.botIndex]),
      ];
    } else {
      return <Widget>[
        new Container(),
      ];
    }
  }
}

enum Position{
  Top,
  Bot,
}

class ImageCard extends StatelessWidget {
  final Position position;
  final FirebaseImage image;

  ImageCard(this.position, this.image);

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

  vote(BuildContext context, Position vote) {
//    switch (vote){
//      case Position.Bot :
//        Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("You voted for the bottom picture")));
//        break;
//      case Position.Top :
//        Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("You voted for the top picture")));
//        break;
//    }
    ComparePicturesContext.of(context).updateIndexes();
  }
}
