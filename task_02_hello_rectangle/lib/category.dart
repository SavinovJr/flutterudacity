import 'package:flutter/material.dart';

/// A custom [Category] widget.
///
/// The widget is composed on an [Icon] and [Text]. Tapping on the widget shows
/// a colored [InkWell] animation.
///
///

class MyCustomWidget extends StatelessWidget {

  /// Creates a [Category].
  ///
  /// A [Category] saves the name of the Category (e.g. 'Length'), its color for
  /// the UI, and the icon that represents it (e.g. a ruler).
  // TODO: You'll need the name, color, and iconLocation from main.dart
  final String name;
  final Color color;
  final IconData icon;
  const MyCustomWidget(this.name, this.color, this.icon);

  /// Builds a custom widget that shows [Category] information.
  ///
  /// This information includes the icon, name, and color for the [Category].
  @override
  // This `context` parameter describes the location of this widget in the
  // widget tree. It can be used for obtaining Theme data from the nearest
  // Theme ancestor in the tree. Below, we obtain the display1 text theme.
  // See https://docs.flutter.io/flutter/material/Theme-class.html
  Widget build(BuildContext context) {
    // TODO: Build the custom widget here, referring to the Specs.
    return Container(
      height: 100.0,
      child: InkWell(
        borderRadius: BorderRadius.circular(50.0),
        highlightColor: color,
        splashColor: color,
        onTap: () {
          print("I was tapped!");
        },
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(
                  icon,
                  size: 60.0,
                ),
              ),
              Center(
                child: Text(
                  name,
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
            ],
          ),
        )
      ),
      );
  }
}