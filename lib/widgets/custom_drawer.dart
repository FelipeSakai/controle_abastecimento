import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomDrawer extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user?.displayName ?? "Usuário"),
            accountEmail: Text(user?.email ?? "Sem e-mail"),
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
              await _auth.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
