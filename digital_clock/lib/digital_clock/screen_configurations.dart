import 'package:flutter/material.dart';

class ScreenConfigurations {
  static double _screenWidth;
  static double _screenHeight;

  void init(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
  }

  static double get screenWidth => _screenWidth;
  static double get screenHeight => _screenHeight;
}
