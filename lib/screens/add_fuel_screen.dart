import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class AddFuelScreen extends StatefulWidget {
  final String vehicleId;

  AddFuelScreen({required this.vehicleId});

  @override
  _AddFuelScreenState createState() => _AddFuelScreenState();
}

class _AddFuelScreenState extends State<AddFuelScreen> {
  final _litersController = TextEditingController();
  final _kmController = TextEditingController();
  final _dateController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final String vehicleId = widget.vehicleId;

  Future<void> _saveFuelRecord() async {
    try {
      String userId = _auth.currentUser!.uid;
      String vehicleId = widget.vehicleId;
      DateTime date = DateFormat('yyyy-MM-dd').parse(_dateController.text.trim());

      await FirebaseFirestore.instance.collection('fuel_records').add({
        'userId': userId,
        'vehicleId': vehicleId,
        'liters': double.parse(_litersController.text.trim()),
        'km': int.parse(_kmController.text.trim()),
        'date': date,
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Abastecimento registrado com sucesso!')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao registrar abastecimento: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Novo Abastecimento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _litersController,
              decoration: InputDecoration(labelText: 'Quantidade de Litros'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            TextFormField(
              controller: _kmController,
              decoration: InputDecoration(labelText: 'Quilometragem Atual'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Data do Abastecimento'),
              keyboardType: TextInputType.datetime,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  setState(() {
                    _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                  });
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveFuelRecord,
              child: Text('Salvar Abastecimento'),
            ),
          ],
        ),
      ),
    );
  }
}
