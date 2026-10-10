import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'theme/app_tema.dart';

void main() {
  runApp(const FominhaApp());
}

class FominhaApp extends StatelessWidget {
  const FominhaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppMarca.nome,
      debugShowCheckedModeBanner: false,
      theme: AppTema.claro,
      home: const LoginScreen(),
    );
  }
}
