import 'package:flutter/material.dart';
import 'package:meta/meta.dart';


class AppContextData {
  final ImageProvider personalImage;
  final Widget currentPage;

  const AppContextData({this.personalImage, this.currentPage});

  AppContextData withPersonalImage(ImageProvider image) {
    return new AppContextData(personalImage: image, currentPage: currentPage);
  }

  AppContextData withCurrentPage(Widget page) {
    return new AppContextData(personalImage: personalImage, currentPage: page);
  }
}

class AppContext extends InheritedWidget {
  final AppContextData appContextData;

  final Function(String imageUrl) updatePersonalImage;
  final Function() ensureLoggedIn;
  final Function(Widget page) updateCurrentPage;

  AppContext({
    Key key,
    @required this.appContextData,
    @required this.updatePersonalImage,
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
