import 'package:flutter/material.dart';
import 'package:open_iconic_flutter/open_iconic_flutter.dart';

import './themes/dynamic_theme.dart';
import './themes/select_theme.dart';
import './utilities/tinkers_forging_calculator_.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      themedWidgetBuilder: (content, theme) {
        return MaterialApp(
          title: 'Modded Minecraft Helper',
          theme: theme,
          home: HomePage(title: 'Modded Minecraft Helper'),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(DynamicTheme.of(context).isDark
                ? OpenIconicIcons.sun
                : OpenIconicIcons.moon),
            onPressed: () {
              DynamicTheme.of(context).toggleBrightness();
            },
          )
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${DynamicTheme.of(context).brightness}\n${DynamicTheme.of(context).data}',
              style: Theme.of(context).textTheme.body2,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder:
                      (context) => /* ThemeSelector() */ TinkersForgingCalcualtor()));
        },
        tooltip: 'Utils',
        child: Icon(Icons.add),
      ),
    );
  }
}
