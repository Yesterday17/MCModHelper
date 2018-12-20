import 'package:flutter/material.dart';

import './themes.dart';
import './dynamic_theme.dart';

class ThemeSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('选择主题')),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 16.0, top: 10.0, bottom: 10.0),
            child: Text(
              '选择主题',
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: Themes.instance.availableThemes.length,
              itemBuilder: (context, index) {
                String key =
                    Themes.instance.availableThemes.keys.toList()[index];
                return ListTile(
                  leading: Icon(
                    DynamicTheme.of(context).data == key
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color: Themes.instance.availableThemes[key].primaryColor,
                  ),
                  title: Text(
                    Themes.instance.availableThemeInformation[key]['name'],
                  ),
                  subtitle: Text(
                    Themes.instance.availableThemeInformation[key]['desc'],
                  ),
                  enabled: key != 'dark',
                  onTap: () {
                    DynamicTheme.of(context).setThemeColor(key);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
