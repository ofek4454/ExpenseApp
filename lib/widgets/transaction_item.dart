import 'package:expenseApp/providers/transactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/Transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  const TransactionItem({
    Key key,
    @required this.transaction,
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
              child: Text('\$${transaction.amount.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          transaction.name,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat("dd/MM/yyyy").format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 500
            ? FlatButton.icon(
                textColor: Theme.of(context).errorColor,
                onPressed: () =>
                    Provider.of<TransactionsProvider>(context, listen: false)
                        .removeTransaction(transaction.id),
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
                    Provider.of<TransactionsProvider>(context, listen: false)
                        .removeTransaction(transaction.id),
              ),
      ),
    );
  }
}
