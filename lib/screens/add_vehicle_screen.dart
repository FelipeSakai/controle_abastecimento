import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controle_abastecimento/screens/vehicles_screen.dart';
import 'package:flutter/material.dart';

class AddVehicleScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _plateController = TextEditingController();

  Future<void> _saveVehicle(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        CollectionReference vehicles = FirebaseFirestore.instance.collection('vehicles');

        await vehicles.add({
          'name': _nameController.text,
          'model': _modelController.text,
          'year': _yearController.text,
          'plate': _plateController.text,
          'userId': 'userId',
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Veículo cadastrado com sucesso!')));

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => VehiclesScreen(),
            ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao cadastrar veículo: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Veículo'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  labelStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do veículo';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _modelController,
                decoration: InputDecoration(
                  labelText: 'Modelo',
                  labelStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _yearController,
                decoration: InputDecoration(
                  labelText: 'Ano',
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
                controller: _plateController,
                decoration: InputDecoration(
                  labelText: 'Placa',
                  labelStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _saveVehicle(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                child: Center(
                  child: Text(
                    'Salvar',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
