import 'package:flutter/material.dart';

class Transaction {
  final int id;
  final String name;
  final double amount;
  final DateTime date;

  Transaction(
    @required this.id,
    @required this.name,
    @required this.amount,
    @required this.date,
  );

  String print(){
    var str = '$name \n $amount \$ ';
    return str;
  }
}
