import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';


class AppContextData {
  final ImageProvider personalImage;
  final Widget currentPage;
  final GoogleSignInAccount currentUser;

  const AppContextData({this.personalImage, this.currentPage, this.currentUser});

  AppContextData withPersonalImage(ImageProvider image) {
    return new AppContextData(personalImage: image, currentPage: currentPage, currentUser: currentUser);
  }

  AppContextData withCurrentPage(Widget page) {
    return new AppContextData(personalImage: personalImage, currentPage: page, currentUser: currentUser);
  }

  AppContextData withCurrentUser(GoogleSignInAccount user) {
    return new AppContextData(personalImage: new NetworkImage(user.photoUrl), currentPage: currentPage, currentUser: user);
  }
}

class AppContext extends InheritedWidget {
  final AppContextData appContextData;

  final Function(String imageUrl) updatePersonalImage;
  final Function(GoogleSignInAccount user) updateCurrentUser;
  final Function() ensureLoggedIn;
  final Function(Widget page) updateCurrentPage;

  AppContext({
    Key key,
    @required this.appContextData,
    @required this.updatePersonalImage,
    @required this.updateCurrentUser,
    @required this.ensureLoggedIn,
    @required this.updateCurrentPage,
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
