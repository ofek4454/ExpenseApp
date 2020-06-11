import 'dart:io';

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
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Column(
      mainAxisSize: isLandscape ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Flexible(
          flex: isLandscape ? 7 : 10,
          child: Card(
            elevation: 6,
            margin: const EdgeInsets.only(
              top: 20,
              right: 20,
              left: 20,
              bottom: 5,
            ),
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
          ),
        ),
        Flexible(
          flex: isLandscape ? 3 : 1,
          child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(text: 'total weekly spending: '),
                  TextSpan(
                    text: '\$$totalAmount',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
        ),
      ],
    );
  }
}
