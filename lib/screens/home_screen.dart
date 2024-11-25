import 'package:controle_abastecimento/widgets/custom_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  Future<void> _logout(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao fazer logout: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Tela Principal'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Text(
          'Bem-vindo à tela principal!',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
