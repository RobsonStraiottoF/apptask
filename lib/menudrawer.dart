import 'package:apptask/deleteall.dart';
import 'package:apptask/home_page.dart';
import 'package:apptask/politicas_privacidade.dart';
import 'package:apptask/sobre.dart';
import 'package:flutter/material.dart';

class Menudrawer extends StatelessWidget {
  const Menudrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  leading: Image(
                    image: AssetImage("assets/whatsapp_icon.png"),
                    width: 100,
                    height: 100,
                  ),
                  title: Text(
                    "Zap Zap",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  subtitle: Text(
                    "Lista de contatos",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Políticas de Privacidade'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PoliticasPrivacidade()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Sobre'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Sobre()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('exclua todos os dados'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Deleteall()),
              );
            },
          ),
        ],
      ),
    );
  }
}
