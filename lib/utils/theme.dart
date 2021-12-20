import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData dark = ThemeData(
  primaryColor: const Color(0xffEDAE49),
  scaffoldBackgroundColor: const Color(0xff110f1a),
  brightness: Brightness.dark,
  // visualDensity: VisualDensity.adaptivePlatformDensity,
);

ThemeData light = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.green[400],
  backgroundColor: Colors.blue[200],
);

class ThemeNotifier extends ChangeNotifier {
  final String key = 'theme';
  late SharedPreferences prefs;
  late bool _darkTheme;
  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = true;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    _savePrefs();
    notifyListeners();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await initPrefs();
    _darkTheme = prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _savePrefs() async {
    await initPrefs();
    prefs.setBool(key, _darkTheme);
  }
}
