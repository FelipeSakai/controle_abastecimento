import 'package:cloud_firestore/cloud_firestore.dart';
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
        
        // Adicionar um novo veículo à coleção
        await vehicles.add({
          'name': _nameController.text,
          'model': _modelController.text,
          'year': _yearController.text,
          'plate': _plateController.text,
          'userId': 'userId', 
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Veículo cadastrado com sucesso!')));

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao cadastrar veículo: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Veículo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do veículo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _modelController,
                decoration: InputDecoration(labelText: 'Modelo'),
              ),
              TextFormField(
                controller: _yearController,
                decoration: InputDecoration(labelText: 'Ano'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _plateController,
                decoration: InputDecoration(labelText: 'Placa'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: ()=>_saveVehicle(context),
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
