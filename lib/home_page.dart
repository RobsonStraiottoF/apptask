import 'package:apptask/database_helper.dart';
import 'package:apptask/menudrawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _contatos = [];
  final TextEditingController _txtContatoController = TextEditingController();
  final TextEditingController _txtNumeroController = TextEditingController();
  final TextEditingController _txtEditarContatoController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    carregarContatos();
  }

  Future<void> carregarContatos() async {
    final contatos = await DatabaseHelper.getContato();
    setState(() {
      _contatos = contatos;
    });
  }

  Future<void> adicionarContato() async {
    if (_txtContatoController.text.isNotEmpty &&
        _txtNumeroController.text.isNotEmpty) {
      await DatabaseHelper.adicionarContato(
        _txtContatoController.text,
        _txtNumeroController.text, // Adicionado o número
      );
      _txtContatoController.clear();
      _txtNumeroController.clear();
      carregarContatos();
    }
  }

  void confirmarDelete(int id) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Excluir contato"),
            content:
                const Text("Você tem certeza que deseja excluir esse contato?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancelar")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    deletarContato(id);
                  },
                  child: const Text("Excluir")),
            ],
          );
        });
  }

  Future<void> deletarContato(int id) async {
    await DatabaseHelper.deletarContato(id);
    carregarContatos();
  }

  void editarContato(int index) {
    final dadosContato = _contatos[index];
    _txtEditarContatoController.text = dadosContato["contato"];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Editar Contato"),
          content: TextField(
            controller: _txtEditarContatoController,
            decoration: const InputDecoration(labelText: "Contato"),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancelar")),
            TextButton(
                onPressed: () async {
                  if (_txtEditarContatoController.text.isNotEmpty
                    
                  ) {
                    await DatabaseHelper.editarContato(
                      dadosContato["id"],
                      _txtEditarContatoController.text,
                      dadosContato["status"],
                    );
                    carregarContatos();
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                },
                child: const Text("Salvar")),
          ],
        );
      },
    );
  }

  Future<void> marcarContato(int index) async {
    final dadosContato = _contatos[index];
    final status = dadosContato["status"] == 0 ? 1 : 0;
    await DatabaseHelper.editarContato(
        dadosContato["id"], dadosContato["contato"], status);
    carregarContatos();
  }

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
      body: ListView.builder(
        itemCount:
            _contatos.length, // Atualizado para refletir o tamanho da lista
        itemBuilder: (context, index) {
          final contato = _contatos[index];
          return ListTile(
            leading: contato["imagem"] != null
                ? Image.network(
                    contato["imagem"], // URL ou caminho da imagem
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  )
                : Icon(
                    contato["status"] == 0
                        ? Icons.call_outlined
                        : Icons.call_made_outlined,
                    color: contato["status"] == 0 ? Colors.grey : Colors.green,
                  ),
            title: Text(contato["contato"]),
            subtitle: Text(contato["numero"]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    editarContato(index);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    confirmarDelete(contato["id"]);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Adicionar contato"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _txtContatoController,
                      decoration: const InputDecoration(labelText: "Nome"),
                    ),
                    TextField(
                      controller: _txtNumeroController,
                      decoration: const InputDecoration(labelText: "Numero"),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancelar")),
                  TextButton(
                      onPressed: () {
                        adicionarContato();
                        Navigator.of(context).pop();
                      },
                      child: const Text("Adicionar")),
                ],
              );
            },
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
