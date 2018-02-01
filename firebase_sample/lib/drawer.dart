import 'package:firebase_sample/compare_screen.dart';
import 'package:firebase_sample/app_context.dart';
import 'package:firebase_sample/chat_screen.dart';
import 'package:firebase_sample/my_pictures_screen.dart';
import 'package:flutter/material.dart';

enum PageType {
  Chat,
  Compare,
  MyPicture,
}

class DrawerContent extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child:new ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          new DrawerHeaderContent(),
          new ListTile(title: new Text("Chat"), leading: new Icon(Icons.chat), onTap: () => _navigateTo(context, PageType.Chat),),
          new ListTile(title: new Text("Compare"), leading: new Icon(Icons.compare), onTap: () => _navigateTo(context, PageType.Compare),),
          new ListTile(title: new Text("My pictures"), leading: new Icon(Icons.photo_library), onTap: () => _navigateTo(context, PageType.MyPicture),),
          new Divider(),
          new AboutItem(),
        ],
      ),
    );
  }

  _navigateTo(BuildContext context, PageType page) {
    switch (page){
      case PageType.Chat :
        AppContext.of(context).updateCurrentPage(new ChatScreen());
        break;
      case PageType.Compare :
        AppContext.of(context).updateCurrentPage(new CompareScreen());
        break;
      case PageType.MyPicture :
        AppContext.of(context).updateCurrentPage(new MyPictureScreen());
        break;
    }
    Navigator.of(context).pop();
  }
}

class DrawerHeaderContent extends StatelessWidget{
  final double _imageSize = 100.0;

  @override
  Widget build(BuildContext context) {

    return new DrawerHeader(
      decoration: new BoxDecoration(
          color: Colors.black
      ),
      child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.only(bottom: 8.0, right: 8.0),
              child: new Container(
                height: _imageSize,
                width: _imageSize,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: AppContext.of(context).appContextData.personalImage != null ? new DecorationImage(image: AppContext.of(context).appContextData.personalImage) : null,
                ),
              ),
            )
          ]
      ),
    );
  }
}

class AboutItem extends StatelessWidget {

  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextStyle aboutTextStyle = themeData.textTheme.body2.copyWith(fontSize: 12.0);
    final TextStyle linkStyle = aboutTextStyle.copyWith(color: themeData.accentColor);

    return new AboutListTile(
        icon: new Icon(Icons.info),
        applicationVersion: 'Firebase example v0',
        applicationIcon: new Image(image : new AssetImage("assets/icon.png"), width: 48.0,),
        aboutBoxChildren: <Widget>[
          new Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: new RichText(
                  text: new TextSpan(
                      children: <TextSpan>[
                        new TextSpan(
                            style: aboutTextStyle,
                            text: 'Si vous avez des questions sur les outils utilisés '
                                'n\'hésitez pas à contacter l\'un des dévelopeurs :\n\n'
                        ),
                      ]
                  )
              )
          )
        ]
    );
  }
}

