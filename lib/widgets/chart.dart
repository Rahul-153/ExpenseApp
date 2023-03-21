import 'package:expense_app/widgets/chart_bar.dart';

import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);
  List<Map<String, Object>> get GroupedTransactions {
    return List.generate(7, (index) {
      var weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year)
          totalSum += recentTransaction[i].amount;
      }
      print(DateFormat.E().format(weekDay).substring(0, 1));
      return {
        'Day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  double get totalSpend {
    return GroupedTransactions.fold(
        0.0, (sum, item) => sum + (item['amount'] as double));
  }

  @override
  Widget build(BuildContext context) {
    print(recentTransaction);
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: GroupedTransactions.map((data) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
              data['Day'] as String,
              data['amount'] as double,
              totalSpend ==0?0.0: (data['amount'] as double)/totalSpend,
            ),
          );
        }).toList()),
      ),
    );
  }
}
