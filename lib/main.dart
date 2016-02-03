// Copyright (c) 2015, the Flutter project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart';
import 'dart:math' as math;

void main() {
  runApp(
    new MaterialApp(
      title: "Firechat",
      routes: <String, RouteBuilder>{
        '/': (RouteArguments args) => new FirechatApp()
      }
    )
  );
}

class FirechatApp extends StatefulComponent {
  @override
  State createState() => new FirechatAppState();
}

class FirechatAppState extends State {
  Firebase _firebase;
  List<Map<String, String>> _messages;
  String _currentMessage;
  String _user;

  void initState() {
    _firebase = new Firebase("https://firechat-flutter.firebaseio.com/");
    _user = "Guest${new math.Random().nextInt(1000)}";
    _firebase.onChildAdded.listen((Event event) {
      Map<String, String> message = event.snapshot.val();
      setState(() => _messages.add(message));
    });
    _messages = <Map<String, String>>[];
    super.initState();
  }

  void _addMessage(String text) {
    Map<String, String> message = {
      'name': _user,
      'text': text,
    };
    _firebase.push().set(message);
    setState(() {
      _currentMessage = null;
      _messageKey.currentState.setText('');
    });
  }

  Widget _buildMessage(int index) {
    if (index >= _messages.length)
      return null;
    Map<String, String> message = _messages[index];
    return new Container(
      margin: const EdgeDims.all(3.0),
      child: new Center(
        child: new Text("${message['name']}: ${message['text']}")
      )
    );
  }

  GlobalKey _messageKey = new GlobalKey();

  Widget _buildDrawer(BuildContext context) {
    return new Drawer(
      child: new Block(children: <Widget>[
        new DrawerHeader(child: new Text(_user)),
        new DrawerItem(
          icon: 'action/assessment',
          selected: true,
          child: new Text('Stock List')
        ),
        new DrawerItem(
          icon: 'action/account_balance',
          onPressed: () {
            showDialog(
              context: context,
              child: new Dialog(
                title: new Text('Not Implemented'),
                content: new Text('This feature has not yet been implemented.'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: new Text('USE IT')
                  ),
                  new FlatButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: new Text('OH WELL')
                  ),
                ]
              )
            );
          },
          child: new Text('Account Balance')
        ),
        new DrawerItem(
          icon: 'device/dvr',
          onPressed: () {
            try {
              debugDumpApp();
            } catch (e, stack) {
              debugPrint('Exception while dumping app:\n$e\n$stack');
            }
          },
          child: new Text('Dump App to Console')
        ),
        new DrawerDivider(),
        new DrawerItem(
          icon: 'action/help',
          child: new Text('Help & Feedback'))
      ])
    );
  }

  void _onMessageChanged(String message) {
    setState(() {
      _currentMessage = message;
    });
  }

  bool get _isComposing => _currentMessage == null || _currentMessage.length == null > 0;

  Widget _buildTextComposer() {
    return new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Flexible(
              child: new Input(
                key: _messageKey,
                hintText: 'Enter message',
                keyboardType: KeyboardType.text,
                onSubmitted: _addMessage,
                onChanged: _onMessageChanged
              )
            ),
            new FloatingActionButton(
              child: new Icon(icon: 'content/send', size: IconSize.s18),
              onPressed: () => _addMessage(_message),
              backgroundColor: _isComposing ? null : Colors.grey[500],
              mini: true
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
      drawer: _buildDrawer(context),
      body: new Material(
        child: new Column(
          children: [
            new Flexible(
              child: new ScrollableMixedWidgetList(
                builder: (BuildContext _, int index) => _buildMessage(index),
                token: _messages.length
              )
            ),
            _buildTextComposer(),
          ]
        )
      )
    );
  }
}
