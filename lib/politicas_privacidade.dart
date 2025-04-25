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
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              leading: Image(
                image: AssetImage("assets/whatsapp_icon.png"),
                width: 100,
                height: 100,
              ),
              title: Text(
                "Zap Zap",
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Lista de contatos"),
            ),
            SizedBox(height: 20),
            Text(
                "Lorem ipsum dolor, sit amet consectetur adipisicing elit. Explicabo, maiores illum sapiente magni recusandae iste ipsa ratione culpa quia, dignissimos omnis nisi nam at quasi quod nulla totam placeat error!"),
            Text(
                "Lorem ipsum dolor, sit amet consectetur adipisicing elit. Explicabo, maiores illum sapiente magni recusandae iste ipsa ratione culpa quia, dignissimos omnis nisi nam at quasi quod nulla totam placeat error!")
          ],
        ),
      ),
    );
  }
}
