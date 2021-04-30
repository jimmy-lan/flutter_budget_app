import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function onDeleteTransaction;

  TransactionList({this.transactions, this.onDeleteTransaction});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: transactions.isEmpty
          ? Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "No transactions added yet!",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      "assets/images/waiting.png",
                      fit: BoxFit.cover,
                    ))
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                var e = transactions[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 5),
                  child: ListTile(
                    leading: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: CircleAvatar(
                            radius: 30,
                            child: Text(
                              "\$${e.amount.toStringAsFixed(2)}",
                            ),
                          ),
                        )),
                    title: Text(
                      e.title,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMMd().format(e.date),
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => onDeleteTransaction(e.id),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
