// Copyright (c) 2015, the Flutter project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'dart:math' as math;

void main() => runApp(new FirechatApp());

class FirechatApp extends StatelessComponent {
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Firechat",
      theme: new ThemeData(
        brightness: ThemeBrightness.light,
        primarySwatch: Colors.purple,
        accentColor: Colors.orangeAccent[200]
      ),
      routes: <String, RouteBuilder>{
        '/': (RouteArguments args) => new ChatScreen(),
      }
    );
  }
}

class ChatScreen extends StatefulComponent {
  @override
  State createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  String _user;

  void initState() {
    _user = "Guest${new math.Random().nextInt(1000)}";
    super.initState();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      toolBar: new ToolBar(
        center: new Text("Chatting as $_user")
      )
    );
  }
}
