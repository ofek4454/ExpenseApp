import 'dart:convert';

import 'package:flutter/material.dart';

class Transaction {
  final String id;
  final String name;
  final double amount;
  final DateTime date;

  Transaction(
    @required this.id,
    @required this.name,
    @required this.amount,
    @required this.date,
  );

  factory Transaction.fromJson(Map<String, dynamic> transactionJson) {
    return Transaction(
      transactionJson['id'],
      transactionJson['name'],
      transactionJson['amount'],
      DateTime.parse(transactionJson['date']),
    );
  }

  String get toJson {
    return json.encode({
      'id': this.id,
      'name': this.name,
      'amount': this.amount,
      'date': this.date.toIso8601String(),
    });
  }

  String print() {
    var str = '$name \n $amount \$ ';
    return str;
  }
}
