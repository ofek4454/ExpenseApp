import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './widgets/TranactionInput.dart';
import './widgets/TransactionsList.dart';
import './models/Transaction.dart';
import './myValues.dart';
import './widgets/Chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expensses app',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.indigoAccent,
        fontFamily: 'OleoScript',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: const TextStyle(
                fontFamily: 'BalsamiqSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button:
                  const TextStyle(color: Colors.white, fontFamily: 'BalsamiqSans'),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: const TextStyle(
                  fontFamily: 'BalsamiqSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void removeTransaction(int id) {
    setState(() {
      transactions.removeWhere((tx) => tx.id == id);
    });
  }

  void addTransaction({String title, double amount, DateTime date}) {
    setState(
      () {
        transactions.add(
          new Transaction(
            myValues.getId(),
            title,
            amount,
            date,
          ),
        );
      },
    );
  }

  void _openBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      backgroundColor: Theme.of(context).primaryColorLight,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: TransactionInput(addTransaction),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text(
              'Expensses app',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: () => _openBottomSheet(context),
                  child: const Icon(CupertinoIcons.add),
                )
              ],
            ),
          )
        : AppBar(
            centerTitle: true,
            title: const Text(
              'Expensses app',
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _openBottomSheet(context),
              )
            ],
          );

    final bodyHeightSize = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final txListWidget = Container(
      height: bodyHeightSize * 0.7,
      child: TransactionsList(
        transactions: transactions,
        removeTransaction: removeTransaction,
      ),
    );

    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (isLandscape)
              Container(
                height: bodyHeightSize * 0.15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      _showChart ? 'Show transactions' : 'Show charts',
                      style: Theme.of(context).textTheme.title,
                    ),
                    Switch.adaptive(
                      activeColor: Theme.of(context).accentColor,
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
            if (!isLandscape)
              Container(
                height: bodyHeightSize * 0.3,
                child: Chart(
                  recentTransaction: _recentTransactions,
                ),
              ),
            if (!isLandscape) txListWidget,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: bodyHeightSize * 0.85,
                      child: Chart(
                        recentTransaction: _recentTransactions,
                      ),
                    )
                  : txListWidget,
          ],
        ),
      ),
    );

    return Platform.isAndroid
        ? Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => _openBottomSheet(context),
            ),
          )
        : CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          );
  }
}
