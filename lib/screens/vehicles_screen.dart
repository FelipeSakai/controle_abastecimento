import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controle_abastecimento/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

String userId = FirebaseAuth.instance.currentUser!.uid;


class VehiclesScreen extends StatelessWidget {
  Future<QuerySnapshot> _fetchVehicles() async {
    return FirebaseFirestore.instance
        .collection('vehicles')
        .where('userId', isEqualTo: 'userId')
        .get();
  }

  void _deleteVehicle(BuildContext context, String vehicleId) async {
    try {
      await FirebaseFirestore.instance.collection('vehicles').doc(vehicleId).delete();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Veículo excluído com sucesso!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao excluir veículo: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meus Veículos')),
      drawer: CustomDrawer(),
      body: FutureBuilder<QuerySnapshot>(
        future: _fetchVehicles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar veículos'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Nenhum veículo cadastrado'));
          }

          final vehicles = snapshot.data!.docs;

          return ListView.builder(
            itemCount: vehicles.length,
            itemBuilder: (context, index) {
              final vehicle = vehicles[index];
              return Card(
                child: ListTile(
                  title: Text(vehicle['name']),
                  subtitle: Text("Modelo: ${vehicle['model']}, Placa: ${vehicle['plate']}"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _deleteVehicle(context, vehicle.id);
                    },
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/vehicle_details', arguments: vehicle);
                  },
                ),
              );
            },
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
