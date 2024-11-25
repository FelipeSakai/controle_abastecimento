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

  Future<void> _saveFuelRecord() async {
    try {
      String userId = _auth.currentUser!.uid;
      String vehicleId = widget.vehicleId;
      DateTime date = DateFormat('dd/MM/yyyy').parse(_dateController.text.trim());

      await FirebaseFirestore.instance.collection('fuel_records').add({
        'userId': userId,
        'vehicleId': vehicleId,
        'liters': double.parse(_litersController.text.trim()),
        'km': int.parse(_kmController.text.trim()),
        'date': date,
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Abastecimento registrado com sucesso!')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao registrar abastecimento: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Abastecimento'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _litersController,
              decoration: InputDecoration(
                labelText: 'Quantidade de Litros',
                labelStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _kmController,
              decoration: InputDecoration(
                labelText: 'Quilometragem Atual',
                labelStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Data do Abastecimento',
                labelStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.datetime,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.dark(
                          primary: Colors.blue,
                          onPrimary: Colors.white,
                          surface: const Color.fromARGB(255, 59, 59, 59),
                          onSurface: Colors.white,
                        ),
                        dialogBackgroundColor: Colors.grey[900],
                      ),
                      child: child!,
                    );
                  },
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Cor do botão
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              child: Center(
                child: Text(
                  'Salvar Abastecimento',
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
