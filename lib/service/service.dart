// ignore_for_file: non_constant_identifier_names

import 'package:audio_book_kwork_1/model/book_model.dart';
import 'package:audio_book_kwork_1/model/previously_viewed_model.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  Database? database;
  String tableName = "music";

  LocalDatabase();

  Future<Database> getMusicDB() async {
    if (database == null) {
      database = await createDataBaseMusic();
      return database!;
    }
    return database!;
  }

  createDataBaseMusic() async {
    String dataBasePath = await getDatabasesPath();
    String path = '${dataBasePath}kirim.db';

    var database =
        await openDatabase(path, version: 1, onCreate: populateMusicDb);

    return database;
  }

  void populateMusicDb(Database db, int version) async {
    await db.execute(
      "CREATE TABLE $tableName ("
      "id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "title TEXT,"
      "artist TEXT,"
      "duration TEXT,"
      "path TEXT"
      ")",
    );
  }

  Future addMusic(Music music) async {
    try {
      Database db = await getMusicDB();
      var id = await db.insert(tableName, music.toMap());

      if (kDebugMode) {
        print("Music shu  ID bilan qoshildi $id");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error while adding music: $e");
      }
      // Handle the error gracefully here, such as showing an error message to the user.
    }
  }

  Future<List<Music>> getAllMusics() async {
    try {
      Database db = await getMusicDB();
      List<Map<String, dynamic>> results = await db.query(tableName);

      List<Music> musicList = results.map((map) {
        return Music.fromMap(map);
      }).toList();

      return musicList;
    } catch (e) {
      if (kDebugMode) {
        print("Error while getting all music records: $e");
      }
      return [];
    }
  }

  String tableNamePVMODEL = "PreviouslyViewedModel";

  Future<Database> getPVModelDB() async {
    if (database == null) {
      database = await createDataBasePVModel();
      return database!;
    }
    return database!;
  }

  createDataBasePVModel() async {
    String dataBasePath = await getDatabasesPath();
    String path = '${dataBasePath}tableNamePVMODEL.db';

    var database =
        await openDatabase(path, version: 1, onCreate: populatePVModelDb);

    return database;
  }

  void populatePVModelDb(Database db, int version) async {
    await db.execute(
      "CREATE TABLE $tableNamePVMODEL ("
      "id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "title TEXT,"
      "artist TEXT,"
      "duration TEXT,"
      "path TEXT"
      ")",
    );
  }


  Future<void> addPVModel(PreviouslyViewedModel PVModel) async {
    try {
      Database db = await getPVModelDB(); // Assuming you have a function to get the database instance.

      // Check if a PVModel with the same title already exists
      var existingPVModels = await db.query(
        tableNamePVMODEL,
        where: 'title = ?',
        whereArgs: [PVModel.title],
      );

      if (existingPVModels.isEmpty) {
        // If no PVModel with the same title exists, then insert the new PVModel
        var id = await db.insert(tableNamePVMODEL, PVModel.toMap());

        if (kDebugMode) {
          print("PVModel with ID $id added successfully");
        }
      } else {
        // If a PVModel with the same title already exists, you can handle it here.
        // For example, you can show an error message to the user indicating that the PVModel already exists.
        if (kDebugMode) {
          print("PVModel with the same title already exists: ${PVModel.title}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error while adding PVModel: $e");
      }
      // Handle the error gracefully here, such as showing an error message to the user.
    }
  }



  Future<List<PreviouslyViewedModel>> getAllPVModels() async {
    try {
      Database db = await getPVModelDB();
      List<Map<String, dynamic>> results = await db.query(tableNamePVMODEL);

      List<PreviouslyViewedModel> PVModelList = results.map((map) {
        return PreviouslyViewedModel.fromMap(map);
      }).toList();

      return PVModelList;
    } catch (e) {
      if (kDebugMode) {
        print("Error while getting all PVModel records: $e");
      }
      return [];
    }
  }
}
