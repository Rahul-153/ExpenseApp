import 'dart:ffi';

import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTxn;

  NewTransaction(this.addTxn);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void SubmitData() {
    final txtEntered = titleController.text;
    final amountEntered = double.parse(amountController.text);
    if (txtEntered == "" || amountEntered <= 0) {
      return;
    }
    widget.addTxn(txtEntered, amountEntered);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Title"),
                onSubmitted: (_) => SubmitData()),
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => SubmitData(),
            ),
            TextButton(
              child: Text(
                "Add Transaction",
                style: TextStyle(color: Colors.purple),
              ),
              onPressed: () => SubmitData(),
            )
          ],
        ),
      ),
    );
  }
}
