import 'dart:convert';

import 'package:expenseApp/di/di.dart';
import 'package:expenseApp/models/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class TransactionsProvider with ChangeNotifier {
  List<Transaction> _transactions;

  TransactionsProvider() : _transactions = getIt();

  List<Transaction> get recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  Future<void> initTransactions() async {
    await Future.delayed(Duration(seconds: 2));
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('transactions')) {
      print('hete');
      prefs.getStringList('transactions').forEach((trans) {
        final transJson = json.decode(trans);
        _transactions.add(Transaction.fromJson(transJson));
      });
    }
  }

  void removeTransaction(String id) {
    _transactions.removeWhere((tx) => tx.id == id);
    notifyListeners();
    _saveToLocal();
  }

  void addTransaction({String title, double amount, DateTime date}) async {
    _transactions.add(
      Transaction(
        Uuid().v4(),
        title,
        amount,
        date,
      ),
    );
    notifyListeners();
    _saveToLocal();
  }

  List<String> _transactionsToJson() {
    final List<String> trans = [];
    _transactions.forEach((transaction) {
      trans.add(transaction.toJson);
    });
    return trans;
  }

  Future<void> _saveToLocal() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('transactions');
    prefs.setStringList('transactions', _transactionsToJson());
  }
}
