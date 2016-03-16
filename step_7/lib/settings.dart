// Copyright 2016, the Flutter project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

const double kSmallFontSize = 18.0;
const double kLargeFontSize = 28.0;

class SettingsScreen extends StatelessWidget {
  SettingsScreen({ this.fontSize, this.onFontSizeChanged });
  final double fontSize;
  final ValueChanged<double> onFontSizeChanged;

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Settings")
      ),
      body: new DefaultTextStyle(
        style: Theme.of(context).textTheme.body1.copyWith(fontSize: fontSize),
        child: new ScrollableList(
          itemExtent: 60.0,
          children: <Widget>[
            new ListItem(
              key: new ValueKey(kSmallFontSize),
              onTap: () => onFontSizeChanged(kSmallFontSize),
              title: new Text('Small font'),
              trailing: new Radio<double>(
                value: kSmallFontSize,
                groupValue: fontSize,
                onChanged: onFontSizeChanged
              )
            ),
            new ListItem(
              key: new ValueKey(kLargeFontSize),
              onTap: () => onFontSizeChanged(kLargeFontSize),
              title: new Text('Large font'),
              trailing: new Radio<double>(
                value: kLargeFontSize,
                groupValue: fontSize,
                onChanged: onFontSizeChanged
              )
            ),
          ]
        )
      )
    );
  }
}
