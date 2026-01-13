import 'package:flutter/material.dart';
import '../models/expense.dart';

class ViewExpenseScreen extends StatelessWidget {
  final List<Expense> expenses;

  const ViewExpenseScreen({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Expenses")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: expenses.length,
        itemBuilder: (_, i) {
          final e = expenses[i];
          return Card(
            child: ListTile(
              title: Text(e.title),
              subtitle: Text(e.category),
              trailing: Text("₹${e.amount}"),
            ),
          );
        },
      ),
    );
  }
}
