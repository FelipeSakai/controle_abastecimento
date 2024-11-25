import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'add_fuel_screen.dart'; 

class VehiclesScreen extends StatelessWidget {
  Future<QuerySnapshot> _fetchVehicles() async {
    return FirebaseFirestore.instance
        .collection('vehicles')
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Veículos'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.grey[900],
      body: FutureBuilder<QuerySnapshot>(
        future: _fetchVehicles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar veículos', style: TextStyle(color: Colors.white)));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Nenhum veículo cadastrado', style: TextStyle(color: Colors.white)));
          }

          final vehicles = snapshot.data!.docs;

          return ListView.builder(
            itemCount: vehicles.length,
            itemBuilder: (context, index) {
              final vehicle = vehicles[index];
              final vehicleId = vehicle.id;

              return Card(
                color: Colors.grey[800],
                child: ListTile(
                  title: Text(
                    vehicle['name'],
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "Modelo: ${vehicle['model']}, Placa: ${vehicle['plate']}",
                    style: TextStyle(color: Colors.white70),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.add, color: Colors.green),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddFuelScreen(vehicleId: vehicleId),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
