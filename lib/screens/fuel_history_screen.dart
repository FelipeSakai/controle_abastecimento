import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/custom_drawer.dart';
import 'add_fuel_screen.dart';

class FuelHistoryScreen extends StatelessWidget {
  Stream<QuerySnapshot> _fetchFuelHistory() {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('fuel_records')
        .where('userId', isEqualTo: userId) // Apenas filtra por userId
        .orderBy('date', descending: true) // Ordena por data, do mais recente ao mais antigo
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Histórico de Abastecimentos'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.grey[900],
      body: StreamBuilder<QuerySnapshot>(
        stream: _fetchFuelHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao carregar histórico',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'Nenhum abastecimento registrado',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final fuelRecords = snapshot.data!.docs;

          return ListView.builder(
            itemCount: fuelRecords.length,
            itemBuilder: (context, index) {
              final record = fuelRecords[index];
              return Card(
                color: Colors.grey[800],
                child: ListTile(
                  title: Text(
                    "Data: ${DateFormat('yyyy-MM-dd').format(record['date'].toDate())}",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "Litros: ${record['liters']} | KM: ${record['km']}",
                    style: TextStyle(color: Colors.white70),
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
