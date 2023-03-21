import 'package:intl/intl.dart';
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
  DateTime? _selectedDate=null;

  Future<DateTime?> _presentDate() {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now()).then((pickedDate){
          if(pickedDate==null){
            return;
          }
          setState(() {
            _selectedDate=pickedDate;
          });
        }
        );
  }

  void _submitData() {
    final txtEntered = titleController.text;
    final amountEntered = double.parse(amountController.text);
    if (txtEntered == "" || amountEntered <= 0 || _selectedDate==null) {
      return;
    }
    widget.addTxn(txtEntered, amountEntered,_selectedDate);

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
                onSubmitted: (_) => _submitData()),
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  _selectedDate==null?Text('No date chosen'):Text(DateFormat.yMMMd().format(_selectedDate!) as String),
                  TextButton(
                      onPressed: _presentDate,
                      child: Text(
                        'Choose Date',
                        style: Theme.of(context).textTheme.labelSmall,
                      ))
                ],
              ),
            ),
            ElevatedButton(
              child: Text(
                "Add Transaction",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: () => _submitData(),
            )
          ],
        ),
      ),
    );
  }
}
