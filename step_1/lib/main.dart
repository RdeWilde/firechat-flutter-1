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

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Chatting as $_name")
      )
    );
  }
}
