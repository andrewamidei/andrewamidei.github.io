import 'package:flutter/material.dart';

// use Theme.of(context).colorScheme.<...> to use the colors.
// use Provider.of<ThemeProvider>(context).<...> to use the assets.

// ColorScheme.fromSeed(seedColor: Colors.indigo),

Color lightBackgroundColor = const Color.fromARGB(255, 238, 248, 255);
Color darkBackgroundColor = const Color.fromARGB(255, 30, 30, 30);
Color surfaceDimLight = const Color.fromARGB(255, 174, 213, 243);
Color surfaceDimDark = const Color.fromARGB(255, 36, 69, 94);

Color primary = const Color.fromARGB(255, 19, 124, 223);
Color secondary = const Color.fromARGB(255, 103, 182, 255);
Color tertiary = const Color.fromARGB(255, 246, 189, 96);
Color error = Colors.red.shade300;

const String lightPattern = 'assets/images/light_icon_pattern.png';
const String darkPattern = 'assets/images/dark_icon_pattern.png';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: lightBackgroundColor,
  colorScheme: ColorScheme.light(
    surface: lightBackgroundColor,
    surfaceDim: surfaceDimLight,
    onSurface: Colors.black, // color drawn on surface (text)
    // onSurfaceVariant: lightBackgroundColor,
    primary: primary,
    secondary: secondary,
    tertiary: tertiary,
    error: error,
  )
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: darkBackgroundColor,
  colorScheme: ColorScheme.light(
    surface: darkBackgroundColor,
    surfaceDim: surfaceDimDark,
    onSurface: lightBackgroundColor,
    primary: primary,
    secondary: secondary,
    tertiary: tertiary,
    error: error,
  )
);

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;
  Icon _icon = const Icon(Icons.dark_mode);
  String _patternPath = lightPattern;

  ThemeData get themeData => _themeData;
  Icon get icon => _icon;
  String get patternPath => _patternPath;

  set themeData(ThemeData themeData){
    _themeData = themeData;
    _icon = icon;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode){
      _icon = const Icon(Icons.light_mode);
      _patternPath = darkPattern;
      themeData = darkMode;
    }
    else {
      _icon = const Icon(Icons.dark_mode);
      _patternPath = lightPattern;
      themeData = lightMode;
    }
  }
}

