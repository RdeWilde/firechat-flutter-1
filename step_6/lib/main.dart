// Copyright 2016, the Flutter project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math' show Random;

import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';

import 'chat.dart';
import 'settings.dart';

void main() => runApp(new FirechatApp());

class FirechatApp extends StatefulComponent {
  @override
  State createState() => new FirechatAppState();
}

class FirechatAppState extends State {
  Firebase _firebase;
  String _user;
  double _fontSize;

  void initState() {
    _user = "Guest${new Random().nextInt(1000)}";
    _firebase = new Firebase("https://firechat-flutter.firebaseio.com/");
    super.initState();
  }

  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Firechat",
      theme: new ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.orangeAccent[400]
      ),
      routes: <String, RouteBuilder>{
        '/': (RouteArguments args) => new ChatScreen(
          fontSize: _fontSize,
          firebase: _firebase.root(),
          user: _user
        ),
        '/settings': (RouteArguments args) => new SettingsScreen(
          fontSize: _fontSize,
          onFontSizeChanged: (double fontSize) {
            setState(() => _fontSize = fontSize);
          }
        )
      }
    );
  }
}
