// Copyright 2016, the Flutter project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math' show Random;

import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: "Firechat",
    theme: new ThemeData(
      primarySwatch: Colors.purple,
      accentColor: Colors.orangeAccent[400]
    ),
    home: new ChatScreen()
  ));
}

class ChatScreen extends StatefulWidget {
  @override
  State createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  String _name = "Guest${new Random().nextInt(1000)}";
  InputValue _currentMessage = InputValue.empty;

  void _handleMessageChanged(InputValue value) {
    setState(() {
      _currentMessage = value;
    });
  }

  void _handleMessageAdded(InputValue value) {
    setState(() {
      _currentMessage = InputValue.empty;
    });
  }

  bool get _isComposing => _currentMessage.text.length > 0;

  Widget _buildTextComposer() {
    ThemeData themeData = Theme.of(context);
    return new Row(
      children: <Widget>[
        new Flexible(
          child: new Input(
            value: _currentMessage,
            hintText: 'Enter message',
            onSubmitted: _handleMessageAdded,
            onChanged: _handleMessageChanged
          )
        ),
        new Container(
          margin: new EdgeInsets.symmetric(horizontal: 4.0),
          child: new IconButton(
            icon: Icons.send,
            onPressed: _isComposing ? () => _handleMessageAdded(_currentMessage) : null,
            color: _isComposing ? themeData.accentColor : themeData.disabledColor
          )
        )
      ]
    );
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Chatting as $_name")
      ),
      body: _buildTextComposer()
    );
  }
}
