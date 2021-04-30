import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function onNewTransaction;

  NewTransaction({this.onNewTransaction});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void onSubmitData() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if (title.isEmpty || amount <= 0 || _selectedDate == null) {
      return;
    }

    widget.onNewTransaction(titleController.text,
        double.parse(amountController.text), _selectedDate);

    // Close modal
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019, 1, 1),
            lastDate: DateTime.now())
        .then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        _selectedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Center(
                child: Text("New Transaction",
                    style: Theme.of(context).textTheme.headline3),
              ),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => onSubmitData(),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                      _selectedDate == null
                          ? "Transaction Date: Not Selected"
                          : "Transaction Date: ${DateFormat.yMd().format(_selectedDate)}",
                      style: Theme.of(context).textTheme.bodyText2),
                ),
                TextButton(
                    onPressed: _presentDatePicker,
                    child: Text("Choose Date",
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
            ElevatedButton(
                onPressed: onSubmitData, child: Text("Add Transaction"))
          ],
        ),
      ),
      elevation: 5,
    );
  }
}
