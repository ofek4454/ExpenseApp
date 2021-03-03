import 'package:expenseApp/di/di.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/Transaction.dart';
import './transaction_item.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionsList() : transactions = getIt();

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Center(
            child: FittedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset('assets/images/empty.png'),
                  const SizedBox(height: 15),
                  Text(
                    'You haven\'t coduced \n any transactions.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Colors.pink[200],
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                  )
                ],
              ),
            ),
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return TransactionItem(
                transaction: transactions[index],
              );
            },
          );
  }
}
