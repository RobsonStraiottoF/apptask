import 'package:apptask/database_helper.dart';
import 'package:apptask/menudrawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _tarefas = [];
  final TextEditingController _txtTarefaController = TextEditingController();
  final TextEditingController _txtEditarTarefaController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    carregarTarefas();
  }

  Future<void> carregarTarefas() async {
    final tarefas = await DatabaseHelper.getTarefa();
    setState(() {
      _tarefas = tarefas;
    });
  }

  Future<void> adicionarTarefa() async {
    if (_txtTarefaController.text.isNotEmpty) {
      await DatabaseHelper.adicionarTarefa(_txtTarefaController.text);
      _txtTarefaController.clear();
      carregarTarefas();
    }
  }

  void confirmarDelete(int id) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Excluir tarefa"),
            content:
                const Text("Você tem certeza que deseja excluir essa tarefa?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancelar")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    deletarTarefa(id);
                  },
                  child: const Text("Excluir")),
            ],
          );
        });
  }

  Future<void> deletarTarefa(int id) async {
    await DatabaseHelper.deletarTarefa(id);
    carregarTarefas();
  }

  void editarTarefa(int index) {
    final dadosTarefa = _tarefas[index];
    _txtEditarTarefaController.text = dadosTarefa["tarefa"];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Editar Tarefa"),
          content: TextField(
            controller: _txtEditarTarefaController,
            decoration: const InputDecoration(labelText: "Tarefa"),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancelar")),
            TextButton(
                onPressed: () async {
                  if (_txtEditarTarefaController.text.isNotEmpty) {
                    await DatabaseHelper.editarTarefa(
                      dadosTarefa["id"],
                      _txtEditarTarefaController.text,
                      dadosTarefa["status"],
                    );
                    carregarTarefas();
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

  Future<void> marcarTarefa(int index) async {
    final dadosTarefa = _tarefas[index];
    final status = dadosTarefa["status"] == 0 ? 1 : 0;
    await DatabaseHelper.editarTarefa(
        dadosTarefa["id"], dadosTarefa["tarefa"], status);
    carregarTarefas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Tarefas"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      drawer: const Menudrawer(),
      body: ListView.builder(
        itemCount: 0,
        itemBuilder: (context, index) {
          return const ListTile();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
