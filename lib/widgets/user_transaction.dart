import './new_transaction.dart';
import './transaction_list.dart';
import '../models/transaction.dart';
import 'package:flutter/material.dart';

class UserTransaction extends StatefulWidget {
  const UserTransaction({super.key});

  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _userTransactions = [
    Transaction(
        amount: 66.4, date: DateTime.now(), id: "t1", title: "new Shoes"),
    Transaction(amount: 13, date: DateTime.now(), id: "t2", title: "Groceries"),
    // Transaction(amount: 10, date: DateTime.now(), id: "t3", title: "utensils"),
    // Transaction(amount: 5, date: DateTime.now(), id: "t4", title: "Snacks"),
  ];

  void _addTransaction(String txnTtile, double txnAmount) {
    final newtxn = Transaction(
        amount: txnAmount,
        date: DateTime.now(),
        id: DateTime.now().toString(),
        title: txnTtile);
        setState(() {
          _userTransactions.add(newtxn);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addTransaction),
        TransactionList(_userTransactions),
      ],
    );
  }
}
