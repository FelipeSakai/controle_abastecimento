import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Usuário Exemplo"),
            accountEmail: Text("exemplo@email.com"),
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person, size: 40),
            ),
          ),
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            title: Text('Meus Veículos'),
            leading: Icon(Icons.directions_car),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/vehicles');
            },
          ),
          ListTile(
            title: Text('Adicionar Veículo'),
            leading: Icon(Icons.add),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/add_vehicle');
            },
          ),
          ListTile(
            title: Text('Histórico de Abastecimentos'),
            leading: Icon(Icons.history),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/history');
            },
          ),
          ListTile(
            title: Text('Perfil'),
            leading: Icon(Icons.person),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/profile');
            },
          ),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.exit_to_app),
            onTap: () async {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
