import 'package:flutter/material.dart';


class DrawerContent extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return new Drawer(
      child:new ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          new DrawerHeaderContent(),
          new ListTile(title: new Text("Chat"), leading: new Icon(Icons.chat),),
          new ListTile(title: new Text("Compare"), leading: new Icon(Icons.compare),),
          new Divider(),
          new AboutItem(),
        ],
      ),
    );
  }
}

class DrawerHeaderContent extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final safeArea = MediaQuery.of(context).padding;

    return new DrawerHeader(
      padding: new EdgeInsets.only(right : safeArea.right + 32.0, top : 32.0, bottom: 32.0),
      decoration: new BoxDecoration(
          color: Colors.black
      ),
      child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Container(
              child: new Image.asset(
                "assets/icon.png",
                height: 64.0,
                width: 64.0,
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

