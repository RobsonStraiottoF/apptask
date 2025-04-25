import 'package:apptask/menudrawer.dart';
import 'package:flutter/material.dart';

class Deleteall extends StatefulWidget {
  const Deleteall({super.key});

  @override
  State<Deleteall> createState() => _DeleteallState();
}

class _DeleteallState extends State<Deleteall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Contatos"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      drawer: const Menudrawer(),
    );
  }
}
