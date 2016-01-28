# firechat_flutter

Firechat is a simple, extensible chat widget powered by [Firebase](https://www.firebase.com/?utm_source=firechat).
It is intended to serve as a concise, documented foundation for chat products built on Firebase.
It works out of the box, and is easily extended.

## Getting Started with Firebase

Firechat requires Firebase in order to store data. You can
[sign up here](https://www.firebase.com/signup/?utm_source=firechat) for a free account.

## Getting Started with Flutter

For help getting started with Flutter, view the [Flutter documentation](http://flutter.io/).

## Building for Android

Make sure your checkouts of flutter and firebase-dart are in directories that are adjacent to this one. You should get your firebase-dart from https://github.com/flutter/firebase-dart for now (see [firebase/firebase-dart#71](https://github.com/firebase/firebase-dart/issues/71).

In the firechat-flutter directory, run ```pub get```.

```flutter apk```

```adb install -r build/app.apk```

## Building for iOS

We are currently adding support for third-party iOS services to the ```flutter``` tool. In the meantime, you'll need a custom compiled Flutter engine with firebase enabled to use Firebase on iOS. Contact jackson@google.com for help with this.
