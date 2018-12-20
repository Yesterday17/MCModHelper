import 'package:flutter/material.dart';
import 'dart:collection';

/// Holds all the themes available, or user-designed themes
///
/// This class has a singleton object [instance], so it's
/// not available to create a new instance.
class Themes {
  /// Blue Theme
  ThemeData _blue = ThemeData(
    primarySwatch: Colors.blue,
  );

  ThemeData _green = ThemeData(
    primarySwatch: Colors.green,
  );

  ThemeData _dark = ThemeData(
    primarySwatch: Colors.grey,
  );

  HashMap<String, ThemeData> availableThemes = HashMap();
  static final Themes instance = Themes();

  Themes() {
    this.availableThemes.putIfAbsent("blue", () => _blue);
    this.availableThemes.putIfAbsent("green", () => _green);
    this.availableThemes.putIfAbsent("dark", () => _dark);
  }
}
