import 'package:controle_abastecimento/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> history = [
    {"date": "2024-11-19", "liters": 45.0, "km": 20000},
    {"date": "2024-11-10", "liters": 50.0, "km": 19800},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Histórico de Abastecimentos')),
      drawer: CustomDrawer(),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final entry = history[index];
          return Card(
            child: ListTile(
              title: Text("Data: ${entry["date"]}"),
              subtitle: Text("Litros: ${entry["liters"]}, KM: ${entry["km"]}"),
            ),
          );
        },
      ),
    );
  }
}
