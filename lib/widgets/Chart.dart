import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/Transaction.dart';
import './ChartBar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart({this.recentTransaction});

  List<Map<String, Object>> get groupedTransactionVlaues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;

      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          totalSum += recentTransaction[i].amount;
        }
      }

      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    });
  }

  double get totalAmount {
    return groupedTransactionVlaues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionVlaues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: data['day'],
                spendingAmount: data['amount'],
                spendingPctOfTotal: totalAmount == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalAmount,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
