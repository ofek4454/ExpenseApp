import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/Transaction.dart';

class TransactionItem extends StatelessWidget {
  
  final Transaction transaction;
  final Function removeTransaction;

  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.removeTransaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  '\$${transaction.amount.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          transaction.name,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat("dd/MM/yyyy").format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 500
            ? FlatButton.icon(
                textColor: Theme.of(context).errorColor,
                onPressed: () =>
                    removeTransaction(transaction.id),
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
                    removeTransaction(transaction.id),
              ),
      ),
    );
  }
}
