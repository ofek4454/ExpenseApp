import 'package:expenseApp/providers/transactions_provider.dart';
import 'package:expenseApp/widgets/AdaptiveRaisedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import './AdaptiveFlatButton.dart';

class TransactionInput extends StatefulWidget {
  @override
  _TransactionInputState createState() => _TransactionInputState();
}

class _TransactionInputState extends State<TransactionInput> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final dateController = TextEditingController();
  DateTime _userDate = DateTime.now();

  void submitData() {
    if (amountController.text.isEmpty ||
        titleController.text.isEmpty ||
        _userDate == null) {
      Toast.show("please fill all fields", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      return;
    }
    var inputTitle = titleController.text;
    var inputAmount = double.parse(amountController.text);

    if (inputTitle.isEmpty || inputAmount <= 0 || _userDate == null) {
      Toast.show("please enter valide data", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    Provider.of<TransactionsProvider>(context, listen: false).addTransaction(
      title: inputTitle,
      amount: inputAmount,
      date: _userDate,
    );

    Navigator.of(context).pop();
  }

  void popUpDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            lastDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 365)))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _userDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Card(
            elevation: 5,
            child: Container(
              color: Theme.of(context).primaryColorLight,
              padding: EdgeInsets.only(
                left: constraints.maxWidth * 0.02,
                right: constraints.maxWidth * 0.02,
                top: constraints.maxHeight * 0.05,
                bottom: MediaQuery.of(context).viewInsets.bottom +
                    constraints.maxHeight * 0.05,
              ),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        fillColor: Colors.blue[100],
                        labelText: 'title',
                        filled: true),
                    controller: titleController,
                    //onSubmitted: (_) => submitData(),
                  ),
                  Container(
                    height: constraints.maxHeight * 0.02,
                    color: Theme.of(context).primaryColorLight,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        fillColor: Colors.blue[100],
                        labelText: 'amount',
                        filled: true),
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    //onSubmitted: (_) => submitData(),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: constraints.maxHeight * 0.1,
            margin: const EdgeInsets.only(left: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _userDate == null
                        ? 'no date chossen'
                        : 'picked date: ${DateFormat('dd/MM/yyyy').format(_userDate)}',
                  ),
                ),
                AdaptiveFlatButton(
                  title: 'Choose a date',
                  handler: popUpDatePicker,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: AdaptiveRaisedButton(
              title: 'Add transaction',
              handler: submitData,
            ),
          ),
        ],
      );
    });
  }
}
