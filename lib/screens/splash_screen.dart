import 'package:expenseApp/providers/transactions_provider.dart';
import 'package:expenseApp/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<TransactionsProvider>(context, listen: false)
        .initTransactions()
        .then((_) => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => HomePage(),
              ),
            ));

    return Container(
      color: Colors.white,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            child: Text(
              'Expenses Manager',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.pink[200],
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Image.asset(
            'assets/images/empty.png',
            width: MediaQuery.of(context).size.width * 0.6,
          ),
        ],
      ),
    );
  }
}
