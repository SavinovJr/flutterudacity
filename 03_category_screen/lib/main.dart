// You can read about packages here: https://flutter.io/using-packages/
import 'package:flutter/material.dart';

// TODO: Import the CategoryRoute widget
import 'category_route.dart';

/// The function that is called when main.dart is run.
void main() {
  runApp(UnitConverterApp());
}

/// This widget is the root of our application.
///
/// The first screen we see is a list [Categories].
class UnitConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CategoryRoute(),
    );
  }
}