import 'package:firebase_sample/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';


class ComparePicturesContextData {
  final List<FirebaseImage> allCats;
  final int topIndex;
  final int botIndex;

  const ComparePicturesContextData( {this.allCats, this.botIndex, this.topIndex});

  ComparePicturesContextData withAllCats(List<FirebaseImage> allCats) {
    return new ComparePicturesContextData(allCats: allCats, topIndex: topIndex, botIndex: botIndex);
  }

  ComparePicturesContextData withIndexes(int topIndex, int botIndex) {
    return new ComparePicturesContextData(allCats: allCats, topIndex: topIndex, botIndex: botIndex);
  }
}

class ComparePicturesContext extends InheritedWidget {
  final ComparePicturesContextData comparePicturesContextData;

  final Function() updateIndexes;

  ComparePicturesContext({
    Key key,
    @required this.comparePicturesContextData,
    @required this.updateIndexes,
    @required Widget child,
  })
      : super(key: key, child: child);

  static ComparePicturesContext of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(ComparePicturesContext);
  }

  @override
  bool updateShouldNotify(ComparePicturesContext old) =>
      comparePicturesContextData != old.comparePicturesContextData;
}