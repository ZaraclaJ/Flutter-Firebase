
import 'package:firebase_sample/app_context.dart';
import 'package:firebase_sample/chat_screen.dart';
import 'package:firebase_sample/compare_screen.dart';
import 'package:firebase_sample/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';

final googleSignIn = new GoogleSignIn();
final firebaseAnalytics = new FirebaseAnalytics();
final firebaseAuth = FirebaseAuth.instance;

final ThemeData kIOSTheme = new ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = new ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);

const String _name = "Your Name";

void main() {
  runApp(new AppContainer());
}

class AppContainer extends StatefulWidget {
  @override
  _AppContainerState createState() => new _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {
  AppContextData appContextData;

  @override
  void initState() {
    appContextData = new AppContextData(personalImage: null, currentPage: new CompareScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new AppContext(
        appContextData: appContextData,
        ensureLoggedIn: _ensureLoggedIn,
        updateCurrentUser: _updateCurrentUser,
        updatePersonalImage: _updatePersonalImage,
        updateCurrentPage: _updateCurrentPage,
        child: new FirebaseApp());
  }

  _updatePersonalImage(String imageUrl) {
    NetworkImage personalImage = new NetworkImage(imageUrl);
    setState(() {
      appContextData = appContextData.withPersonalImage(personalImage);
    });
  }

  _updateCurrentUser(GoogleSignInAccount user) {
    setState(() {
      appContextData = appContextData.withCurrentUser(user);
    });
  }

  Future<bool> _ensureLoggedIn() async {
    GoogleSignInAccount user = appContextData.currentUser;
    if (user == null)
      user = await googleSignIn.signInSilently();
    if (user == null) {
      await googleSignIn.signIn();
      firebaseAnalytics.logLogin();
    }
    if (await firebaseAuth.currentUser() == null) {
      GoogleSignInAuthentication credentials = await googleSignIn.currentUser.authentication;
      await firebaseAuth.signInWithGoogle(
        idToken: credentials.idToken,
        accessToken: credentials.accessToken,
      );
    }
    if (googleSignIn.currentUser != null) {
      _updateCurrentUser(googleSignIn.currentUser);
    }
    return user != null;
  }

  _updateCurrentPage(Widget page) {
    setState(() {
      appContextData = appContextData.withCurrentPage(page);
    });
  }
}

class FirebaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Firebase Test",
      theme: defaultTargetPlatform == TargetPlatform.iOS
          ? kIOSTheme
          : kDefaultTheme,
      home: AppContext.of(context).appContextData.currentPage,
    );
  }
}
