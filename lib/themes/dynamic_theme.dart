/// Edited from https://github.com/Norbert515/dynamic_theme
/// by Yesterday17
import 'package:flutter/material.dart';
import '../preferences.dart';
import './themes.dart';

typedef Widget ThemedWidgetBuilder(BuildContext context, ThemeData data);

class DynamicTheme extends StatefulWidget {
  final ThemedWidgetBuilder themedWidgetBuilder;

  const DynamicTheme({Key key, this.themedWidgetBuilder}) : super(key: key);

  @override
  DynamicThemeState createState() => new DynamicThemeState();

  static DynamicThemeState of(BuildContext context) {
    return context.ancestorStateOfType(const TypeMatcher<DynamicThemeState>());
  }
}

class DynamicThemeState extends State<DynamicTheme> {
  String _color;
  ThemeData _theme;

  Brightness _brightness;

  static const String _kThemeDark = 'theme_dark';
  static const String _kThemeColor = 'theme_color';

  bool loaded = false;

  get isDark => _brightness == Brightness.dark;
  get brightness => _brightness;
  get data => _color;

  @override
  void initState() {
    super.initState();

    _brightness = Brightness.light;
    _color = 'blue';
    refreshTheme();
    Preferences.init().then((prefs) {
      this._brightness = (prefs.getBool(_kThemeDark) ?? false)
          ? Brightness.dark
          : Brightness.light;
      this._color = (prefs.getString(_kThemeColor) ?? 'blue');

      setState(() {
        refreshTheme();
        loaded = true;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    refreshTheme();
  }

  @override
  void didUpdateWidget(DynamicTheme oldWidget) {
    super.didUpdateWidget(oldWidget);
    refreshTheme();
  }

  @override
  Widget build(BuildContext context) {
    return widget.themedWidgetBuilder(context, _theme);
  }

  void refreshTheme() {
    if (!isDark) {
      this._theme = Themes.instance.availableThemes[this._color];
    } else {
      this._theme = Themes.instance.availableThemes['dark'];
    }
  }

  void setBrightness(Brightness brightness) async {
    setState(() {
      this._brightness = brightness;
      refreshTheme();
    });
    await Preferences.instance.prefs.setBool(_kThemeDark, isDark);
  }

  void setThemeColor(String color) async {
    setState(() {
      this._color = color;
      refreshTheme();
    });
    await Preferences.instance.prefs.setString(_kThemeColor, color);
  }

  bool toggleBrightness() {
    bool result = !isDark;
    setBrightness(isDark ? Brightness.light : Brightness.dark);
    return result;
  }
}
