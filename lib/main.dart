import 'package:flutter/material.dart';
import 'package:my_expenses/providers/transaction_provider.dart';
import 'package:my_expenses/screens/summary_screen.dart';
import 'package:my_expenses/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => TransactionProvider())],
    child: MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: SummaryScreen(),
    );
  }
}
