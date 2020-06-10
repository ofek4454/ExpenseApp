import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class TransactionInput extends StatefulWidget {
  final Function addHandler;

  TransactionInput(this.addHandler);

  @override
  _TransactionInputState createState() => _TransactionInputState();
}

class _TransactionInputState extends State<TransactionInput> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final dateController = TextEditingController();
  DateTime _userDate;

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
    
    widget.addHandler(
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Card(
          elevation: 5,
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                    fillColor: Colors.blue[100],
                    labelText: 'title',
                    filled: true),
                controller: titleController,
                onSubmitted: (_) => submitData(),
              ),
              Container(
                height: 3,
                color: Theme.of(context).primaryColorLight,
              ),
              TextField(
                decoration: InputDecoration(
                    fillColor: Colors.blue[100],
                    labelText: 'amount',
                    filled: true),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
              ),
            ],
          ),
        ),
        Container(
          height: 50,
          margin: EdgeInsets.only(left: 10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  _userDate == null
                      ? 'no date chossen'
                      : 'picked date: ${DateFormat('dd/MM/yyyy').format(_userDate)}',
                ),
              ),
              FlatButton(
                child: Text(
                  'Choose a date',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
                onPressed: popUpDatePicker,
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 10),
          child: RaisedButton(
            child: Text(
              'Add transaction',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            textColor: Theme.of(context).textTheme.button.color,
            color: Theme.of(context).primaryColor,
            onPressed: submitData,
          ),
        ),
      ],
    );
  }
}
