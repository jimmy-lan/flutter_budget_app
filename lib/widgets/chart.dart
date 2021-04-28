import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import '../models/spending_by_date.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactionData;

  Chart({@required this.transactionData});

  List<Transaction> get _recentTransactions {
    return transactionData.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  List<SpendingByDate> _calculateChartData(BuildContext context) {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: 6 - index));
      var totalSum = 0.0;

      for (var i = 0; i < _recentTransactions.length; i++) {
        if (_recentTransactions[i].date.day == weekDay.day &&
            _recentTransactions[i].date.month == weekDay.month &&
            _recentTransactions[i].date.year == weekDay.year) {
          totalSum += _recentTransactions[i].amount;
        }
      }

      return SpendingByDate(
          date: DateFormat.MMMd().format(weekDay),
          amount: totalSum,
          color: Theme.of(context).primaryColor);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Series<SpendingByDate, String>> series = [
      Series(
          id: "spending",
          data: _calculateChartData(context),
          domainFn: (SpendingByDate series, _) => series.date,
          measureFn: (SpendingByDate series, _) => series.amount,
          colorFn: (SpendingByDate series, _) => series.color),
    ];

    return Container(
      height: 280,
      padding: EdgeInsets.all(20),
      child: Card(
          child: Column(
        children: [
          Text(
            "Daily Spending Statistics",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            height: 10,
          ),
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
