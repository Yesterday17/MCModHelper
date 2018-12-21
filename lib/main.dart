import 'package:flutter/material.dart';
import 'package:open_iconic_flutter/open_iconic_flutter.dart';

import './themes/dynamic_theme.dart';
import './drawer.dart';
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
      drawer: DrawerInstance(),
      body: Center(
        child: Column(
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
              builder: (context) => TinkersForgingCalcualtor(),
            ),
          );
        },
        tooltip: '锻造计算器',
        child: Icon(Icons.add),
      ),
    );
  }
}
