import 'package:flutter/material.dart';
import 'package:my_expenses/screens/summary_screen.dart';
import 'package:my_expenses/theme/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: AppTheme.lightTheme,
      home: SummaryScreen(),
    );
  }
}
