import 'package:flutter/material.dart';

class PoliticasPrivacidade extends StatelessWidget {
  const PoliticasPrivacidade({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Politicas de privacidade"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
    );
  }
}
