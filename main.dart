// CÓDIGO FEITO POR Luis Augusto dos Santos Silva

import 'package:flutter/material.dart';

void main() {
  runApp(const ContadorApp());
}

class ContadorApp extends StatelessWidget {
  const ContadorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contador de Inspeção',
      home: const TelaContador(),
    );
  }
}

class TelaContador extends StatefulWidget{
  const TelaContador({super.key});

  @override
  State<TelaContador> createState() => _TelaContadorState();
}

class _TelaContadorState extends State<TelaContador> {
  int _pecasAprovadas = 0;
  final _nomeController = TextEditingController();
  
}