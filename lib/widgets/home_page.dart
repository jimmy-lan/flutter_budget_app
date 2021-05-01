import 'package:flutter/material.dart';
import 'package:flutter_budget_app/widgets/chart.dart';

import './new_transaction.dart';
import '../models/transaction.dart';
import './transaction_list.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum HomePageDisplay { showList, showChart }

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: "t1",
        title: "New Shoes",
        amount: 69.99,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(
        id: "t2", title: "Groceries", amount: 14.99, date: DateTime.now())
  ];

  var currentDisplay = HomePageDisplay.showList;

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: date);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  void _promptNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTransaction(onNewTransaction: _addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text(
        "My Budget",
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _promptNewTransaction(context))
      ],
    );
    final txList = TransactionList(
      transactions: _userTransactions,
      onDeleteTransaction: _deleteTransaction,
    );
    final availableHeight = (MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top);
    final chartHeight =
        isLandscape ? availableHeight * 0.7 : availableHeight * 0.3;
    final chartContainer = Container(
        height: chartHeight, child: Chart(transactionData: _userTransactions));

    return Scaffold(
      appBar: appBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                    onPressed: () {
                      setState(() {
                        currentDisplay =
                            currentDisplay == HomePageDisplay.showChart
                                ? HomePageDisplay.showList
                                : HomePageDisplay.showChart;
                      });
                    },
                    child: Text(currentDisplay == HomePageDisplay.showChart
                        ? "Show List"
                        : "Show Chart")),
                SizedBox(
                  width: 6,
                )
              ],
            ),
          if (!isLandscape) chartContainer,
          if (!isLandscape) txList,
          if (isLandscape)
            currentDisplay == HomePageDisplay.showChart
                ? chartContainer
                : txList
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _promptNewTransaction(context)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
