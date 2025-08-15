import 'package:flutter/material.dart';
import 'package:my_expenses/models/transaction.dart';
import 'package:my_expenses/providers/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class TransactionFormScreen extends StatefulWidget {
  final Transaction? transaction;
  const TransactionFormScreen({super.key, this.transaction});

  @override
  State<TransactionFormScreen> createState() => _TransactionFormScreenState();
}

class _TransactionFormScreenState extends State<TransactionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _selectedCategory = 'Comida';
  TransactionType _selectedType = TransactionType.expense;

  final List<String> _categories = [
    'Comida',
    'Transporte',
    'Entretenimiento',
    'Otros',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.transaction == null
              ? 'Registrar Transaccion'
              : 'Editar Transaccion',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(label: Text('Monto')),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un monto';
                  }
                  final amount = double.tryParse(value);
                  if (amount! <= 0) {
                    return 'El monto debe ser mayor que 0';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(label: Text('Descripcion')),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la descripcion';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField(
                value: _selectedCategory,
                items:
                    _categories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      title: const Text('Gasto'),
                      value: TransactionType.expense,
                      groupValue: _selectedType,
                      onChanged: (TransactionType? value) {
                        setState(() {
                          _selectedType = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: const Text('Ingreso'),
                      value: TransactionType.income,
                      groupValue: _selectedType,
                      onChanged: (TransactionType? value) {
                        setState(() {
                          _selectedType = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final transactionProvider =
                          Provider.of<TransactionProvider>(
                            context,
                            listen: false,
                          );

                      if (widget.transaction == null) {
                        transactionProvider.addTransactions(
                          Transaction(
                            id: Uuid().v4().toString(),
                            category: _selectedCategory,
                            amount: double.parse(_amountController.text),
                            type: _selectedType,
                            date: DateTime.now(),
                          ),
                        );
                      } else {
                        widget.transaction!.category = _selectedCategory;
                        widget.transaction!.amount = double.parse(
                          _amountController.text,
                        );
                        widget.transaction!.type = _selectedType;
                        transactionProvider.notifyListeners();
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            widget.transaction == null
                                ? 'Transaccion Registrada'
                                : 'Transaccion Actualizada',
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    widget.transaction == null
                        ? 'Guardar Transaccion'
                        : 'Transaccion Actualizada',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
