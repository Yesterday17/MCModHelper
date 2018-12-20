import 'package:flutter/material.dart';
import 'dart:collection';

/// Holds all the themes available, or user-designed themes
///
/// This class has a singleton object [instance], so it's
/// not available to create a new instance.
class Themes {
  /// Blue Theme
  ThemeData _blue = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
  );

  ThemeData _green = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.green,
  );

  ThemeData _dark = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blueGrey,
  );

  HashMap<String, ThemeData> availableThemes = HashMap();
  HashMap<String, dynamic> availableThemeInformation = HashMap();
  static final Themes instance = Themes();

  void _addTheme(String name, ThemeData theme, dynamic data) {
    this.availableThemes.putIfAbsent(name, () => theme);
    this.availableThemeInformation.putIfAbsent(name, () => data);
  }

  Themes() {
    _addTheme("blue", _blue, {'name': '蓝色', 'desc': '象征蓝军的蓝色主题'});
    _addTheme("green", _green, {'name': '绿色', 'desc': '象征启蒙的绿色主题'});
    _addTheme("dark", _dark, {'name': '夜间模式', 'desc': '请于主界面右上角修改'});
  }
}
