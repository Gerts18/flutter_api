import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/screens/character_screen.dart';
import 'package:rick_and_morty_app/screens/home_screen.dart';

void main() => runApp(const MyApp());

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [ /* Sub rutas que dependeran de la ruta principal  */
        GoRoute(
          path: '/character',
          builder: (context, state) => const CharacterScreen()
          )
      ],
    ),
  ],
); /* Creamos el enrutador de la app  */

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Rick and Morty App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
      routerConfig: _router, /* Le decimos que queremos usar nuestra configuración de routing para manejar las paginas de la app */
    );
  }
} 
