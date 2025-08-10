import 'package:flutter/material.dart';
import 'package:my_expenses/models/expense_data.dart';
import 'package:my_expenses/screens/transaction_form_screen.dart';
import 'package:my_expenses/widgets/expense_chart.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ExpenseData> expenseData = [
      ExpenseData(120, 'Comida'),
      ExpenseData(300, 'Entretenimiento'),
      ExpenseData(230, 'Comida'),
      ExpenseData(100, 'Viajes'), // se agrupará en "Otros"
    ];

    // Convertimos la lista en un Map con sumatoria por categoría
    final Map<String, double> categoryMap = {};
    for (var e in expenseData) {
      categoryMap[e.category] = (categoryMap[e.category] ?? 0) + e.ammount;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Resumen de Gastos'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumen del Mes',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Card(
              child: ListTile(
                leading: Icon(Icons.arrow_upward_outlined, color: Colors.green),
                title: Text('Ingresos'),
                subtitle: Text('\$0.0'),
              ),
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.arrow_downward_outlined, color: Colors.red),
                title: Text('Gastos'),
                subtitle: Text('\$0.0'),
              ),
            ),
            const SizedBox(height: 20),

            // Nuevo gráfico adaptado
            ExpenseChart(categoryData: categoryMap),

            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TransactionFormScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Añadir Transaccion'),
                style: ElevatedButton.styleFrom(foregroundColor: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
