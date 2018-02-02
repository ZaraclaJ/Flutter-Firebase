import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(home: new FrostedDemo()));
}

class FrostedDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: [
        new Scaffold(
          body: new ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: new FlutterLogo(),
          ),
        ),
        new BackdropFilter(
          filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: new Container(
            decoration: new BoxDecoration(color: Colors.grey[200].withOpacity(0.1)),
          ),
        ),
      ],
    );
  }
}