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
    // Transaction(
    //     id: "t1", title: "New Shoes", amount: 69.99, date: DateTime.now()),
    // Transaction(
    //     id: "t2", title: "Groceries", amount: 14.99, date: DateTime.now())
  ];

  void _addNewTransaction(String title, double amount) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: DateTime.now());

    setState(() {
      _userTransactions.add(newTx);
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Budget App",
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _promptNewTransaction(context))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Chart(transactionData: _userTransactions),
          TransactionList(
            transactions: _userTransactions,
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
