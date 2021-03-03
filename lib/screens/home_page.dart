import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/Chart.dart';
import '../widgets/TranactionInput.dart';
import '../widgets/TransactionsList.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showChart = false;

  void _openBottomSheet() {
    showModalBottomSheet(
      isScrollControlled:
          MediaQuery.of(context).orientation == Orientation.landscape,
      context: context,
      backgroundColor: Theme.of(context).primaryColorLight,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: TransactionInput(),
        );
      },
    );
  }

  List<Widget> _buildLandscapeContent(
      double bodyHeightSize, Widget txListWidget) {
    return [
      Container(
        height: bodyHeightSize * 0.15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _showChart ? 'Show transactions' : 'Show charts',
              style: Theme.of(context).textTheme.headline6,
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
      _showChart
          ? Container(
              height: bodyHeightSize * 0.83,
              child: Chart(),
            )
          : txListWidget,
    ];
  }

  List<Widget> _buildPortraitContent(
      double bodyHeightSize, Widget txListWidget) {
    return [
      Container(
        height: bodyHeightSize * 0.3,
        child: Chart(),
      ),
      SizedBox(
        height: bodyHeightSize * 0.02,
      ),
      txListWidget,
    ];
  }

  Widget _buildAppBar(bool isLandscape) {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text(
              'Expensses app',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: () => _openBottomSheet(),
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
                onPressed: () => _openBottomSheet(),
              )
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = _buildAppBar(isLandscape);

    final bodyHeightSize = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final txListWidget = Container(
      height: bodyHeightSize * 0.68,
      child: TransactionsList(),
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (isLandscape)
              ..._buildLandscapeContent(bodyHeightSize, txListWidget),
            if (!isLandscape)
              ..._buildPortraitContent(bodyHeightSize, txListWidget),
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
              onPressed: () => _openBottomSheet(),
            ),
          )
        : CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          );
  }
}
