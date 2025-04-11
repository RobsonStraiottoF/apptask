import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const String tableTarefa = "tarefas";

  static Future<Database> getDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'dbTarefas.db'),
      onCreate: (db, version) {
        return db.execute('''
            create table $tableTarefa(
              id integer primary key autoincrement,
              tarefa text not null,
              status integer not null
            )
''');
      },
      version: 1,
    );
  } //create

  static Future<void> adicionarTarefa(String tarefa) async {
    final db = await getDatabase();
    await db.insert(tableTarefa, {'tarefa': tarefa, 'status': 0});
  } //Read

  static Future<void> editarTarefa(int id, String tarefa, int status) async {
    final db = await getDatabase();
    await db.update(
      tableTarefa,
       {"tarefa":tarefa, "status": status},
       where: "id = ?",
       whereArgs: [id],
       );
  } //Update

  static Future<List<Map<String, dynamic>>> getTarefa() async {
    final db = await getDatabase();
    return await db.query(tableTarefa);
  } //Read
static Future<void> deletarTarefa(int id) async {
  final db = await getDatabase();
  await db.delete(tableTarefa, where: "id = ?", whereArgs: [id]);
}
}
