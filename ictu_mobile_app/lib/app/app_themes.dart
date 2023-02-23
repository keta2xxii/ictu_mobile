import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_styles.dart';

class AppThemes {
  static final themeData = ThemeData(
      primaryColor: $styles.colors.colorPrimary,
      colorScheme: _colorScheme,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ));

  static final _colorScheme = ColorScheme(
    primary: $styles.colors.colorPrimary,
    secondary: $styles.colors.colorAccent,
    background: $styles.colors.colorAccent,
    onBackground: Colors.black,
    surface: Colors.black,
    onSurface: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    brightness: Brightness.light,
  );
}
