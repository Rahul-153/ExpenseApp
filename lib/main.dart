import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'package:expense_app/widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/user_transaction.dart';
import './widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Quicksand',
          textTheme: TextTheme(
              labelSmall: TextStyle(
                  color: Colors.purple,
                  fontFamily: 'OpenSans',
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              displaySmall: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   amount: 66.4,
    //   date: DateTime.now(),
    //   id: "t1",
    //   title: "new Shoes",
    // ),
    // Transaction(
    //   amount: 13,
    //   date: DateTime.now(),
    //   id: "t2",
    //   title: "Groceries",
    // ),
    // Transaction(amount: 10, date: DateTime.now(), id: "t3", title: "utensils"),
    // Transaction(amount: 5, date: DateTime.now(), id: "t4", title: "Snacks"),
  ];
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  bool _showChart = false;

  void _addTransaction(String txnTtile, double txnAmount, DateTime dt) {
    final newtxn = Transaction(
        amount: txnAmount,
        date: dt,
        id: DateTime.now().toString(),
        title: txnTtile);
    setState(() {
      _userTransactions.add(newtxn);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final ObstructingPreferredSizeWidget appBar = (Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              "Personal Expense",
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: Text(
              "Personal Expense",
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
            actions: <Widget>[
              IconButton(
                  onPressed: () => _startAddNewTransaction(context),
                  icon: Icon(Icons.add)),
            ],
          )) as ObstructingPreferredSizeWidget;
    final txnList = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.75,
        child: TransactionList(_userTransactions, _deleteTransaction));
    final pageBody = SafeArea(child: SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Show Chart",style: Theme.of(context).textTheme.labelSmall,),
                Switch.adaptive(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    })
              ],
            ),
          if (!isLandscape)
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(_recentTransactions)),
          if (!isLandscape) txnList,
          if (isLandscape)
            _showChart
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    child: Chart(_recentTransactions))
                : txnList,
        ],
      ),
    ));
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _startAddNewTransaction(context),
                    child: Icon(Icons.add),
                  ),
          );
  }
}
