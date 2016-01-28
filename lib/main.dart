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
  String _user;

  void initState() {
    _firebase = new Firebase("https://firechat-ios.firebaseio-demo.com/");
    _user = "Guest${new math.Random().nextInt(1000)}";
    _firebase.onChildAdded.listen((Event event) {
      Map<String, String> message = event.snapshot.val();
      setState(() => _messages.insert(0, message));
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

  Widget build(BuildContext context) {
    return new Scaffold(
      toolBar: new ToolBar(
        center: new Text("Chatting as $_user")
      ),
      body: new Material(
        child: new Column(
          children: [
            new Container(
              margin: const EdgeDims.all(6.0),
              child: new Input(
                key: _messageKey,
                hintText: 'Enter message',
                keyboardType: KeyboardType.text,
                onSubmitted: _addMessage
              )
            ),

            // This works, but doesn't adapt to items of varying size
            // new Flexible(
            //   child: new Container(
            //     decoration: const BoxDecoration(backgroundColor: const Color(0x1100FF00)),
            //     child: new ScrollableList(
            //       itemExtent: 25.0,
            //       children: new Iterable.generate(_messages.length)
            //                             .map((index) => _buildMessage(index))
            //     )
            //   )
            // ),

            // This works, but is inefficient because it builds all the widgets
            new Flexible(
              child: new Container(
                decoration: const BoxDecoration(backgroundColor: const Color(0x110000FF)),
                child: new ScrollableViewport(
                  child: new Column(
                    children: new Iterable.generate(_messages.length)
                                          .map((index) => _buildMessage(index))
                                          .toList()
                  )
                )
              )
            ),

            // This is the ideal solution
            // new Flexible(
            //   child: new Container(
            //     decoration: const BoxDecoration(backgroundColor: const Color(0x11FF0000)),
            //     child: new ScrollableMixedWidgetList(
            //       builder: (BuildContext _, int index) => _buildMessage(index),
            //       token: _messages.length
            //     )
            //   )
            // ),
          ]
        )
      )
    );
  }
}
