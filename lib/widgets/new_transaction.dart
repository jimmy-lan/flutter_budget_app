import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  final Function onNewTransaction;

  NewTransaction({this.onNewTransaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountController,
            ),
            TextButton(
                onPressed: () => onNewTransaction(titleController.text,
                    double.parse(amountController.text)),
                child: Text("Add Transaction"))
          ],
        ),
      ),
      elevation: 5,
    );
  }
}
