import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController(text: "Usuário Exemplo");
  final TextEditingController _emailController = TextEditingController(text: "exemplo@email.com");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil')),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Perfil do Usuário",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
              readOnly: true, // Não permitir edição do e-mail
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Salvar alterações no Firebase
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Perfil atualizado com sucesso!')),
                );
              },
              child: Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
