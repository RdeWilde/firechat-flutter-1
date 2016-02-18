// Copyright 2016, the Flutter project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessComponent {
  ChatMessage(Map<String, String> source)
    : name = source['name'], text = source['text'];
  final String name;
  final String text;

  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeDims.all(3.0),
      child: new Text("$name: $text")
    );
  }
}

class ChatScreen extends StatefulComponent {
  const ChatScreen({ this.fontSize, this.user, this.firebase });
  final double fontSize;
  final String user;
  final Firebase firebase;

  @override
  State createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  InputValue _currentMessage;
  List<Map<String, String>> _messages;
  StreamSubscription _onChildAdded;

  @override
  void initState() {
    _currentMessage = InputValue.empty;
    _messages = <Map<String, String>>[];
    _onChildAdded = config.firebase.root().onChildAdded.listen((Event event) {
      setState(() => _messages.add(event.snapshot.val()));
    });
    super.initState();
  }

  @override
  void dispose() {
    _onChildAdded.cancel();
    super.dispose();
  }

  Widget _buildDrawer(BuildContext context) {
    return new Drawer(
      child: new Block(children: <Widget>[
        new DrawerHeader(child: new Text(config.user ?? '')),
        new DrawerItem(
          icon: 'action/settings',
          child: new Text('Settings'),
          onPressed: () {
            Navigator.pushNamed(context, '/settings');
          }
        ),
        new DrawerItem(
          icon: 'action/help',
          child: new Text('Help & Feedback'),
          onPressed: () {
            showDialog(
              context: context,
              child: new Dialog(
                title: new Text('Need help?'),
                content: new Text('Email flutter-discuss@googlegroups.com.'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: new Text('OK')
                  ),
                ]
              )
            );
          }
        )
      ])
    );
  }

  void _handleMessageChanged(InputValue value) {
    setState(() {
      _currentMessage = value;
    });
  }

  void _handleMessageAdded(InputValue value) {
    Map<String, String> message = {
      'name': config.user,
      'text': value.text,
    };
    config.firebase.push().set(message);
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
                onPressed: () => _handleMessageAdded(_currentMessage),
                backgroundColor: _isComposing ? null : Colors.grey[500],
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
        center: new Text("Chatting as ${config.user}")
      ),
      drawer: _buildDrawer(context),
      body: new DefaultTextStyle(
        style: Theme.of(context).text.body1.copyWith(fontSize: config.fontSize),
        child: new Column(
          children: [
            new Flexible(
              child: new Block(
                padding: const EdgeDims.symmetric(horizontal: 8.0),
                scrollAnchor: ViewportAnchor.end,
                children: _messages.map((m) => new ChatMessage(m)).toList()
              )
            ),
            _buildTextComposer(),
          ]
        )
      )
    );
  }
}
