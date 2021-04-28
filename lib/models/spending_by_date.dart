import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SpendingByDate {
  final String date;
  final double amount;
  final charts.Color color;

  SpendingByDate({@required this.date, @required this.amount, Color color})
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
