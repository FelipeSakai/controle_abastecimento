import 'package:controle_abastecimento/screens/add_fuel_screen.dart';
import 'package:flutter/material.dart';

class VehicleDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vehicle =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return Scaffold(
      appBar: AppBar(title: Text('Detalhes do Veículo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddFuelScreen(vehicleId: vehicle['id']),
                  ),
                );
              },
              child: Text('Registrar Novo Abastecimento'),
            ),
            Text("Nome: ${vehicle["name"]}", style: TextStyle(fontSize: 20)),
            Text("Modelo: ${vehicle["model"]}", style: TextStyle(fontSize: 18)),
            Text("Placa: ${vehicle["plate"]}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text(
              "Média de Consumo: 12.5 km/L", // Substituir com cálculo dinâmico
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
