import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:my_expenses/models/transaction.dart';
import 'package:my_expenses/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

class ExpenseChart extends StatelessWidget {
  const ExpenseChart({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final expenses =
        transactionProvider.transactions
            .where((tr) => tr.type == TransactionType.expense)
            .toList();

    final Map<String, double> categoryData = {};
    for (var tr in expenses) {
      final category = _normalizeCategory(tr.category);
      categoryData[category] = (categoryData[category] ?? 0) + tr.amount;
    }

    final List<PieChartSectionData> sections =
        categoryData.entries.map((entry) {
          final category = entry.key;
          final color = _getColorForCategory(category);

          return PieChartSectionData(
            color: color,
            value: entry.value,
            title: '$category\n\$${entry.value.toStringAsFixed(2)}',
            radius: 60,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          );
        }).toList();

    return SizedBox(
      height: 250,
      child: PieChart(
        PieChartData(
          sections: sections,
          centerSpaceRadius: 40,
          sectionsSpace: 2,
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }

  /// NORMALIZA CATEGORIA Y AGRUPA DESCONOCIDAS POR ¨OTROS¨
  String _normalizeCategory(String category) {
    const categoriasValidas = [
      'Comida',
      'Transporte',
      'Entretenimiento',
      'Otros',
    ];
    if (!categoriasValidas.contains(category)) {
      return 'Otros';
    }
    return category;
  }

  // COLOR POR CATEGORIA
  Color _getColorForCategory(String category) {
    switch (category) {
      case 'Comida':
        return Colors.redAccent;
      case 'Transporte':
        return Colors.blueAccent;
      case 'Entretenimiento':
        return Colors.greenAccent;
      case 'Otros':
      default:
        return Colors.grey;
    }
  }
}
