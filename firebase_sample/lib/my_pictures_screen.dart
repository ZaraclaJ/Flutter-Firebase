import 'dart:async';
import 'dart:io';
import 'dart:math';

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

class MyPictureScreen extends StatefulWidget {
  @override
  State createState() => new MyPictureScreenState();
}

class MyPictureScreenState extends State<MyPictureScreen> {
  final reference = FirebaseDatabase.instance.reference().child('images');
  List<FirebaseImage> images;

  List<FirebaseImage> _getImages(){
    return [new FirebaseImage(AppContext.of(context).appContextData.currentUser.id, "url1"),
    new FirebaseImage(AppContext.of(context).appContextData.currentUser.id, "url2"),
    new FirebaseImage(AppContext.of(context).appContextData.currentUser.id, "url3"),];
  }

  @override
  Widget build(BuildContext context) {
    images = _getImages();
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("My pictures"),
          elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.account_circle), onPressed: AppContext.of(context).ensureLoggedIn),
          ]
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: () async {
            if (await AppContext.of(context).ensureLoggedIn()){
              File imageFile = await ImagePicker.pickImage();
              int random = new Random().nextInt(100000);
              String ownerId = AppContext.of(context).appContextData.currentUser.id;
              StorageReference ref = FirebaseStorage.instance.ref().child("${ownerId}_$random.jpg");
              StorageUploadTask uploadTask = ref.put(imageFile);
              Uri downloadUrl = (await uploadTask.future).downloadUrl;
              FirebaseImage myImage = new FirebaseImage(ownerId, downloadUrl.toString());
              _uploadImage(myImage);
            }
          },
      ),
      drawer: new DrawerContent(),
      body: new SafeArea(
        child: new Center(
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
        ),
      ),
    );
  }

  void _uploadImage(FirebaseImage image) {
    reference.push().set(image.toJson());
    firebaseAnalytics.logEvent(name: 'upload_image');
  }
}
