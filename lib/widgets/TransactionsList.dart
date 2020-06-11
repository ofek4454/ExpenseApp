import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/Transaction.dart';

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
              return Card(
                elevation: 8,
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: FittedBox(
                        child: Text(
                            '\$${transactions[index].amount.toStringAsFixed(2)}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].name,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat("dd/MM/yyyy").format(transactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 500
                      ? FlatButton.icon(
                          textColor: Theme.of(context).errorColor,
                          onPressed: () =>
                              removeTransaction(transactions[index].id),
                          icon: Icon(
                            Icons.delete_outline,
                            color: Theme.of(context).errorColor,
                          ),
                          label: const Text('DELETE'),
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.delete_outline,
                            size: 25,
                            color: Theme.of(context).errorColor,
                          ),
                          onPressed: () =>
                              removeTransaction(transactions[index].id),
                        ),
                ),
              );
            },
          );
  }
}
