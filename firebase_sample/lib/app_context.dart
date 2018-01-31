import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';


class AppContextData {
  final ImageProvider personalImage;

  const AppContextData({this.personalImage});

  AppContextData withPersonalImage(ImageProvider image) {
    return new AppContextData(personalImage: image);
  }
}

class AppContext extends InheritedWidget {
  final AppContextData appContextData;

  final Function(String imageUrl) updatePersonalImage;
  final Function() ensureLoggedIn;

  AppContext({
    Key key,
    @required this.appContextData,
    @required this.updatePersonalImage,
    @required this.ensureLoggedIn,
    @required Widget child,
  })
      : super(key: key, child: child);

  static AppContext of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppContext);
  }

  @override
  bool updateShouldNotify(AppContext old) =>
      appContextData != old.appContextData;
}
