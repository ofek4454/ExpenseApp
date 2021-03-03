import 'package:expenseApp/providers/transactions_provider.dart';
import 'package:expenseApp/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import './screens/home_page.dart';
import './di/di.dart' as di;

void main() {
  di.setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TransactionsProvider()),
      ],
      child: Consumer<TransactionsProvider>(
        builder: (context, value, child) => MaterialApp(
          title: 'Expensses app',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            accentColor: Colors.indigoAccent,
            fontFamily: 'OleoScript',
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: const TextStyle(
                    fontFamily: 'BalsamiqSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  button: const TextStyle(
                      color: Colors.white, fontFamily: 'BalsamiqSans'),
                ),
            appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: const TextStyle(
                      fontFamily: 'BalsamiqSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ),
      ),
    );
  }
}
