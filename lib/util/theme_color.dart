import 'package:flutter/material.dart';

class DiyoTheme {
  static const MaterialColor diyotheme =
      MaterialColor(_diyothemePrimaryValue, <int, Color>{
    50: Color(0xFFFDEAE8),
    100: Color(0xFFFACAC5),
    200: Color(0xFFF7A69F),
    300: Color(0xFFF48278),
    400: Color(0xFFF1685B),
    500: Color(_diyothemePrimaryValue),
    600: Color(0xFFED4638),
    700: Color(0xFFEB3D30),
    800: Color(0xFFE83428),
    900: Color(0xFFE4251B),
  });
  static const int _diyothemePrimaryValue = 0xFFEF4D3E;

  static const MaterialColor diyothemeAccent =
      MaterialColor(_diyothemeAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_diyothemeAccentValue),
    400: Color(0xFFFFB5B2),
    700: Color(0xFFFF9C98),
  });
  static const int _diyothemeAccentValue = 0xFFFFE6E5;
}
