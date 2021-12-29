
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:projet/Model/Composant.dart';
import 'package:sqflite/sqflite.dart'  ;
import 'package:path/path.dart';
import 'dart:io' as io;


class COMPOSANTHelper {
  static get table => 'composants';
  static get matricule => 'matricule';
  static get nom => 'nom';
  static get description => 'description';
  static get qte => 'qte';
  static get cat_id => 'idCategory';
  static const String DB_Name = 'gstock.db';

  static Future<void> createTable(Database database) async {


    await database.execute("""CREATE TABLE IF NOT EXISTS $table (
        $matricule INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        $nom TEXT,
        $description TEXT,
        $qte INTEGER,
        $cat_id INTEGER,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY ($cat_id)  REFERENCES categories (id) ON DELETE NO ACTION ON UPDATE NO ACTION
      )
      """);
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }
  // id: the id of a Composant
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<Database> db() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_Name);
    return openDatabase(
      path,
      version: 2,
      onCreate: (Database database, int version) async {
        await createTable(database);
      },
      onConfigure: _onConfigure
    );
  }

  // Create new Composant (journal)
  static Future<int> createComposant(Composant composant) async {
    final db = await COMPOSANTHelper.db();


    final id = await db.insert(table, composant.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  // Read all Composants (journals)
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await COMPOSANTHelper.db();
    await createTable(db);
    return db.query(table, orderBy: matricule);

  }

  // Read a single Composant by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<Composant?>? getItem(int matricule) async {
    var db = await COMPOSANTHelper.db();
    var res = await  db.query(table, where: "matricule = ?", whereArgs: [matricule], limit: 1);
    if (res.isNotEmpty) {
      return Composant.fromMap(res.first);
    }
    return null;
  }

  // Update a Composant by id
  static Future<int> updateComposant(
      int matricule, Composant composant) async {
    final db = await COMPOSANTHelper.db();
    composant.matricule=matricule;
    final result =
    await db.update(table, composant.toMap(), where: "matricule = ?", whereArgs: [matricule]);
    return result;
  }

  // Delete
  static Future<void> deleteComposant(int id) async {
    final db = await COMPOSANTHelper.db();
    try {
      await db.delete(table, where: "matricule = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}