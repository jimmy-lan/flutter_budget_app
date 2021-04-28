import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class SpendingByDay {
  final String day;
  final double amount;
  final charts.Color color;

  SpendingByDay({@required this.day, @required this.amount, @required this.color});
}