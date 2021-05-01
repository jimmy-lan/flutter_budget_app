import 'package:flutter/material.dart';
import 'package:flutter_budget_app/widgets/chart.dart';

import './new_transaction.dart';
import '../models/transaction.dart';
import './transaction_list.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

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

    return Scaffold(
      appBar: appBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.3,
              child: Chart(transactionData: _userTransactions)),
          TransactionList(
            transactions: _userTransactions,
            onDeleteTransaction: _deleteTransaction,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _promptNewTransaction(context)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
