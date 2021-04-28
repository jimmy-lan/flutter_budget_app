import 'package:flutter/material.dart';
import 'package:flutter_budget_app/models/spending_by_day.dart';
import 'package:charts_flutter/flutter.dart';

class Chart extends StatelessWidget {
  final List<SpendingByDay> data;

  Chart({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<Series<SpendingByDay, String>> series = [
      Series(
          id: "spending",
          data: data,
          domainFn: (SpendingByDay series, _) => series.day,
          measureFn: (SpendingByDay series, _) => series.amount,
          colorFn: (SpendingByDay series, _) => series.color),
    ];

    return Container(
      height: 280,
      padding: EdgeInsets.all(20),
      child: Card(
          child: Column(
        children: [
          Text("Daily Spending Statistics", style: Theme.of(context).textTheme.bodyText1,),
          SizedBox(height: 10,),
          Expanded(
            child: BarChart(
              series,
              animate: true,
            ),
          )
        ],
      )),
    );
  }
}
