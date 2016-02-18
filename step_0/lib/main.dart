// Copyright 2016, the Flutter project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(new FirechatApp());

class FirechatApp extends StatelessComponent {
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Firechat",
      routes: <String, RouteBuilder>{
        '/': (RouteArguments args) => new Scaffold(
          toolBar: new ToolBar(center: new Text("Firechat"))
        )
      }
    );
  }
}
