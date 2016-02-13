import 'package:flutter/material.dart';

const double kSmallFontSize = 18.0;
const double kLargeFontSize = 28.0;

class SettingsScreen extends StatelessComponent {
  SettingsScreen({ this.fontSize, this.onFontSizeChanged });
  final double fontSize;
  final ValueChanged<double> onFontSizeChanged;

  Widget build(BuildContext context) {
    return new Scaffold(
      toolBar: new ToolBar(
        center: new Text("Settings")
      ),
      body: new DefaultTextStyle(
        style: Theme.of(context).text.body1.copyWith(fontSize: fontSize),
        child: new ScrollableList(
          itemExtent: 60.0,
          children: [
            new ListItem(
              key: new ValueKey(kSmallFontSize),
              onTap: () => onFontSizeChanged(kSmallFontSize),
              center: new Text('Small font'),
              right: new Radio<double>(
                value: kSmallFontSize,
                groupValue: fontSize,
                onChanged: onFontSizeChanged
              )
            ),
            new ListItem(
              key: new ValueKey(kLargeFontSize),
              onTap: () => onFontSizeChanged(kLargeFontSize),
              center: new Text('Large font'),
              right: new Radio<double>(
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
