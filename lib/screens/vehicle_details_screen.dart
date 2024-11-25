import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controle_abastecimento/screens/add_fuel_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VehicleDetailsScreen extends StatefulWidget {
  final String vehicleId;

  VehicleDetailsScreen({required this.vehicleId});

  @override
  _VehicleDetailsScreenState createState() => _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
  double averageConsumption = 0.0;

  Future<void> calculateAverageConsumption() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    double totalLiters = 0.0;
    int totalKmDifference = 0;

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('fuel_records')
          .where('userId', isEqualTo: userId)
          .where('vehicleId', isEqualTo: widget.vehicleId)
          .orderBy('date') 
          .get();

      if (snapshot.docs.length > 1) {
        for (int i = 1; i < snapshot.docs.length; i++) {
          var currentRecord = snapshot.docs[i];
          var previousRecord = snapshot.docs[i - 1];

          int kmDifference = currentRecord['km'] - previousRecord['km'];
          double liters = currentRecord['liters'];

          totalKmDifference += kmDifference;
          totalLiters += liters;
        }

        if (totalKmDifference > 0 && totalLiters > 0) {
          setState(() {
            averageConsumption = totalKmDifference / totalLiters;
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao calcular média: $e')));
    }
  }

  @override
  void initState() {
    super.initState();
    calculateAverageConsumption();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Veículo'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informações do Veículo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Nome: Veículo Exemplo', 
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              'Modelo: Modelo Exemplo', 
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              'Placa: ABC-1234',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 20),

            Text(
              'Média de Consumo:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              averageConsumption > 0
                  ? "${averageConsumption.toStringAsFixed(2)} km/L"
                  : "Sem dados suficientes para calcular a média.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddFuelScreen(vehicleId: widget.vehicleId),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              child: Center(
                child: Text(
                  'Registrar Novo Abastecimento',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
