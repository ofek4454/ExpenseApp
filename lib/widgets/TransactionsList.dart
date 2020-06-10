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
                  SizedBox(height: 15),
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
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
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
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      size: 25,
                      color: Colors.red,
                    ),
                    onPressed: () => removeTransaction(transactions[index].id),
                  ),
                ),
              );

              /*return Card(
                  elevation: 8,
                  shadowColor: Colors.black38,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 15,
                            ),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              //shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Text(
                              '\$${transactions[index].amount.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                transactions[index].name,
                                style: Theme.of(context).textTheme.title,
                              ),
                              SizedBox(height: 5),
                              Text(
                                DateFormat("HH:mm, dd/MM/yyyy")
                                    .format(transactions[index].date),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete_outline,
                          size: 25,
                          color: Colors.red,
                        ),
                        onPressed: () => removeTransaction(transactions[index]),
                      )
                    ],
                  ),
                );*/
            },
          );
  }
}
