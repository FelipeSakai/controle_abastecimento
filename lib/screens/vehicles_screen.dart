import 'package:controle_abastecimento/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class VehiclesScreen extends StatelessWidget {
  final List<Map<String, String>> vehicles = [
    {"name": "Carro A", "model": "Modelo X", "plate": "ABC-1234"},
    {"name": "Carro B", "model": "Modelo Y", "plate": "DEF-5678"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meus Veículos')),
      drawer: CustomDrawer(),
      body: ListView.builder(
        itemCount: vehicles.length,
        itemBuilder: (context, index) {
          final vehicle = vehicles[index];
          return Card(
            child: ListTile(
              title: Text(vehicle["name"]!),
              subtitle: Text("Modelo: ${vehicle["model"]}, Placa: ${vehicle["plate"]}"),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // Implementar exclusão do veículo
                },
              ),
              onTap: () {
                Navigator.pushNamed(context, '/vehicle_details', arguments: vehicle);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_vehicle');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
