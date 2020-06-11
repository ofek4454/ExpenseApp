import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  
  final String title;
  final Function handler;

  const AdaptiveFlatButton({this.title , this.handler});
  
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
                  ? CupertinoButton(
                      child: Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                      onPressed: handler,
                    )
                  : FlatButton(
                      child: Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                      onPressed: handler,
                    );
  }
}