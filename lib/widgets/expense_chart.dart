import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ExpenseChart extends StatelessWidget {
  final Map<String, double> categoryData;

  ExpenseChart({required this.categoryData});

  @override
  Widget build(BuildContext context) {
    final List<PieChartSectionData> sections =
        categoryData.entries.map((entry) {
          final category = _normalizeCategory(entry.key);
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

  /// Normaliza la categoría para agrupar las desconocidas en "Otros"
  String _normalizeCategory(String category) {
    const categoriasValidas = ['Comida', 'Transporte', 'Entretenimiento'];
    if (!categoriasValidas.contains(category)) {
      return 'Otros';
    }
    return category;
  }

  /// Asigna color por categoría
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
