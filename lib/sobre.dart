import 'package:flutter/material.dart';

class Sobre extends StatelessWidget {
  const Sobre({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sobre"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
                "Lorem ipsum dolor, sit amet consectetur adipisicing elit. Explicabo, maiores illum sapiente magni recusandae iste ipsa ratione culpa quia, dignissimos omnis nisi nam at quasi quod nulla totam placeat error!")
          ],
        ),
      ),
    );
  }
}
