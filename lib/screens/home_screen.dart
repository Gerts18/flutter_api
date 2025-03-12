import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/* Pantalla principal de la aplicación donde se mostrara una lista de todos los personajes de la serie Rick and Morty. */

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty Home',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,       
      ),
      body: Center(
        child: ElevatedButton(child: Text('Ir a otra pagina'),
          onPressed: () => context.go('/character'),
        ),
      ),
    );
  }
}