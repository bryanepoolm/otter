import 'dart:io';
import 'package:otter/models/gastos/gastos_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class GastosProvider {
  GastosProvider._privateConstructor();
  static final GastosProvider instance = GastosProvider._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'otter.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE gastos(
        id INTEGER PRIMARY KEY,
        nombre TEXT,
        monto decimal,
        fecha_pago Datetime
      )
    ''');
  }

  Future<List<Gastos>> selectGastos() async {
    Database db = await instance.database;
    var gastos = await db.query('gastos');

    List<Gastos> gastosList =
        gastos.isNotEmpty ? gastos.map((e) => Gastos.fromMap(e)).toList() : [];
    return gastosList;
  }

  Future<int> insertGasto(Gastos gasto) async {
    Database db = await instance.database;
    return await db.insert('gastos', gasto.toMap());
  }

  Future<int> deleteGasto(int id) async {
    Database db = await instance.database;
    return await db.delete('gastos', where: 'id = ?', whereArgs: [id]);
  }
}
