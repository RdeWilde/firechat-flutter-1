# Firechat for Flutter

Firechat is a simple, extensible chat app powered by
[Firebase Realtime Database](https://firebase.google.com/?utm_source=firechat),
a cloud-hosted NoSQL database. This version of Firechat
is built with [Flutter](https://flutter.io),
a new project to help developers build high-performance, high-fidelity,
mobile apps for iOS and Android from a single codebase.

This repo is a companion to the
[Build cross-platform Firebase apps with Flutter][codelab]
codelab. This repo is organized as a series
of steps of increasing complexity. If you just want to see
the Firechat for Flutter app working, you can run
the app in the `step_5` directory after you follow
the setup instructions below.

## Setup

To build and run the app in the `step_5` directory,
you will first need to install Flutter, sign up
for a free Firebase account,
and configure your app.

Note: If you are following the [codelab][codelab], then you
can skip these setup instructions. The codelab leads you
through the setup.

### Installing Flutter

To install Flutter and its dependencies,
visit [Setup Flutter](https://flutter.io/setup/).

The projects in this repo assume that your checkout of Flutter
is in an adjacent
directory nammed `flutter`.
If it's somewhere else, you need to edit the path in
pubspec.yaml for each of the steps.

### Creating a Firebase project

Firechat requires Firebase in order to store data.
[Create a new Firebase project](https://firebase.google.com/)
in order to generate a unique project name.

### Configuring your app

Follow [step 12 of the codelab](https://codelabs.developers.google.com/codelabs/flutter/index.html#11)
in order to configure this app to connect to your Firebase project.

If you do not properly configure your local copy of the Firechat app to
use your new Firebase project, you will likely encounter rate limiting
issues.

## Documentation

The [codelab][codelab] guides you through learning the
basics of Flutter and connecting it to Firebase.
To dive deeper, check out our
additional docs:

* [Firebase for Flutter API docs](https://flutter.github.io/firebase-dart)
* [Flutter API docs](http://docs.flutter.io)

## Building and running

In the directory of the step you want to build, run `pub get`
and `flutter run`.

Use `flutter run --release` if you want to remove the "Slow Mode" banner
and improve performance.

[codelab]: https://codelabs.developers.google.com/codelabs/flutter/index.html#0
