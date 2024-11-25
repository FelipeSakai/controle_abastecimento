import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FuelHistoryScreen extends StatelessWidget {
  final String vehicleId;

  FuelHistoryScreen({required this.vehicleId});

  Stream<QuerySnapshot> _fetchFuelHistory() {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('fuel_records')
        .where('userId', isEqualTo: userId)
        .where('vehicleId', isEqualTo: vehicleId)
        .orderBy('date', descending: true) 
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Histórico de Abastecimentos')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _fetchFuelHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar histórico'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Nenhum abastecimento registrado'));
          }

          final fuelRecords = snapshot.data!.docs;

          return ListView.builder(
            itemCount: fuelRecords.length,
            itemBuilder: (context, index) {
              final record = fuelRecords[index];
              return Card(
                child: ListTile(
                  title: Text("Data: ${DateFormat('yyyy-MM-dd').format(record['date'].toDate())}"),
                  subtitle: Text("Litros: ${record['liters']} | KM: ${record['km']}"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
