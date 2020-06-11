import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/Transaction.dart';
import './transaction_item.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransaction;

  TransactionsList({@required this.transactions, this.removeTransaction});

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
                    style: TextStyle(
                        fontFamily: 'BalsamiqSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.pink[200]),
                  )
                ],
              ),
            ),
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return TransactionItem(transaction: transactions[index], removeTransaction: removeTransaction);
            },
          );
  }
}