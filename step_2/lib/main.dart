// Copyright 2016, the Flutter project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: "Firechat",
    theme: new ThemeData(
      brightness: ThemeBrightness.light,
      primarySwatch: Colors.purple,
      accentColor: Colors.orangeAccent[200]
    ),
    routes: <String, RouteBuilder>{
      '/': (RouteArguments args) => new ChatScreen()
    }
  ));
}

class ChatScreen extends StatefulComponent {
  @override
  State createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  String _user;
  InputValue _currentMessage;

  void initState() {
    _user = "Guest${new math.Random().nextInt(1000)}";
    _currentMessage = InputValue.empty;
    super.initState();
  }

  void _handleMessageChanged(InputValue message) {
    setState(() {
      _currentMessage = message;
    });
  }

  void _handleMessageAdded(InputValue value) {
    setState(() {
      _currentMessage = InputValue.empty;
    });
  }

  bool get _isComposing => _currentMessage.text.length > 0;

  Widget _buildTextComposer() {
    return new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Flexible(
              child: new Input(
                value: _currentMessage,
                hintText: 'Enter message',
                keyboardType: KeyboardType.text,
                onSubmitted: _handleMessageAdded,
                onChanged: _handleMessageChanged
              )
            ),
            new Container(
              margin: const EdgeDims.symmetric(horizontal: 4.0),
              child: new FloatingActionButton(
                child: new Icon(icon: 'content/send', size: IconSize.s18),
                onPressed: _isComposing ? () => _handleMessageAdded(_currentMessage) : null,
                backgroundColor: _isComposing ? null : Theme.of(context).disabledColor,
                mini: true
              )
            )
          ]
        )
      ]
    );
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      toolBar: new ToolBar(
        center: new Text("Chatting as $_user")
      ),
      body: _buildTextComposer()
    );
  }
}
