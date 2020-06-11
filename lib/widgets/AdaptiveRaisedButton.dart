import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveRaisedButton extends StatelessWidget {
  
  final String title;
  final Function handler;

  const AdaptiveRaisedButton({this.title , this.handler});
  
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
              ? CupertinoButton(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.button.color,
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: handler,
                )
              : RaisedButton(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  textColor: Theme.of(context).textTheme.button.color,
                  color: Theme.of(context).primaryColor,
                  onPressed: handler,
                );
  }
}