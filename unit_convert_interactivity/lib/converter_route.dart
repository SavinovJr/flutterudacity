// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'unit.dart';
import 'dart:math';

const _padding = EdgeInsets.all(16.0);

/// [ConverterRoute] where users can input amounts to convert in one [Unit]
/// and retrieve the conversion in another [Unit] for a specific [Category].
///
/// While it is named ConverterRoute, a more apt name would be ConverterScreen,
/// because it is responsible for the UI at the route's destination.
class ConverterRoute extends StatefulWidget {
  /// This [Category]'s name.
  final String name;

  /// Color for this [Category].
  final Color color;

  /// Units for this [Category].
  final List<Unit> units;

  /// This [ConverterRoute] requires the name, color, and units to not be null.
  const ConverterRoute({
    @required this.name,
    @required this.color,
    @required this.units,
  })  : assert(name != null),
        assert(color != null),
        assert(units != null);

  @override
  _ConverterRouteState createState() => _ConverterRouteState();
}

class _ConverterRouteState extends State<ConverterRoute> {
  // TODO: Set some variables, such as for keeping track of the user's input
  // value and units
  Unit unitFrom;
  Unit unitTo;
  double inputValue;
  String convertedValue = '';
  bool needShowError = false;

  // TODO: Determine whether you need to override anything, such as initState()

  // TODO: Add other helper functions. We've given you one, _format()

  /// Clean up conversion; trim trailing zeros, e.g. 5.500 -> 5.5, 10.0 -> 10
  String _format(double conversion) {
    var outputNum = conversion.toStringAsPrecision(7);
    if (outputNum.contains('.') && outputNum.endsWith('0')) {
      var i = outputNum.length - 1;
      while (outputNum[i] == '0') {
        i -= 1;
      }
      outputNum = outputNum.substring(0, i + 1);
    }
    if (outputNum.endsWith('.')) {
      return outputNum.substring(0, outputNum.length - 1);
    }
    return outputNum;
  }

  void _updateConversion() {
    setState(() {
      convertedValue =
          _format(inputValue * (unitTo.conversion / unitFrom.conversion));
    });
  }

  Widget _dropDownWidgetWith(Unit currentUnit, ValueChanged<Unit> onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        child: DropdownButtonHideUnderline(
            child: DropdownButton<Unit>(
                value: currentUnit,
                isDense: true,
                items: widget.units.map((Unit unit) {
                  return new DropdownMenuItem<Unit>(
                    value: unit,
                    child: new Text(unit.name),
                  );
                }).toList(),
                onChanged: onChanged)),
      ),
    );
  }

  Widget inputWidgets() {
    return Padding(
      padding: _padding,
      child: Column(
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                errorStyle: TextStyle(color: Colors.red),
                errorText: needShowError ? "Error" : null,
                border: OutlineInputBorder(),
                labelText: "Input"),
            onChanged: (String newValue) {
              setState(() {
                if (newValue.isEmpty || newValue == null) {
                  convertedValue = "";
                  return;
                }
                try {
                  inputValue = double.parse(newValue);
                  needShowError = false;
                  _updateConversion();
                } catch (exception) {
                  needShowError = true;
                }
              });
            },
          ),
          _dropDownWidgetWith(unitFrom, (Unit newValue) {
            setState(() {
              unitFrom = newValue;
              _updateConversion();
            });
          }),
        ],
      ),
    );
  }

  Widget compareArrows() {
    return Transform.rotate(
        angle: pi / 2, child: Icon(Icons.compare_arrows, size: 40.0));
  }

  Widget outputWidgets() {
    return Padding(
      padding: _padding,
      child: Column(
        children: <Widget>[
          InputDecorator(
            child: Text(convertedValue),
            decoration: InputDecoration(
              labelText: "Outline",
              border: OutlineInputBorder(),
            ),
          ),
          _dropDownWidgetWith(unitTo, (Unit newUnit) {
            setState(() {
              unitTo = newUnit;
              _updateConversion();
            });
          }),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    unitFrom = widget.units.first;
    unitTo = widget.units.last;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Create the 'input' group of widgets. This is a Column that
    // includes the output value, and 'from' unit [Dropdown].

    // TODO: Create a compare arrows icon.

    // TODO: Create the 'output' group of widgets. This is a Column that

    // TODO: Return the input, arrows, and output widgets, wrapped in

    return ListView(
      children: <Widget>[
        inputWidgets(),
        compareArrows(),
        outputWidgets()
      ],
    );
  }
}
