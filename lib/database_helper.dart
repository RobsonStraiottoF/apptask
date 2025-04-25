import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const String tableContato = "contatos";

  static Future<Database> getDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'dbContatos_v2.db'), // Alterado o nome do banco para 'dbContatos_v2.db'
      onCreate: (db, version) {
        return db.execute('''
            create table $tableContato(
              id integer primary key autoincrement,
              contato text not null,
              numero text not null,
              status integer not null
            )
''');
      },
      version: 1,
    );
  } //create

  static Future<void> adicionarContato(String contato, String numero) async {
    final db = await getDatabase();
    await db.insert(tableContato, {
      'contato': contato,
      'numero': numero,
      'status': 0
    }); // Adicionado 'numero'
  } //Read

  static Future<void> editarContato(int id, String contato, int status) async {
    final db = await getDatabase();
    await db.update(
      tableContato,
      {"contato": contato, "status": status},
      where: "id = ?",
      whereArgs: [id],
    );
  } //Update

  static Future<List<Map<String, dynamic>>> getContato() async {
    final db = await getDatabase();
    return await db.query(tableContato);
  } //Read

  static Future<void> deletarContato(int id) async {
    final db = await getDatabase();
    await db.delete(tableContato, where: "id = ?", whereArgs: [id]);
  }
}
