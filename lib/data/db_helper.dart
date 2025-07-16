//import sembast and path
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'bible_verse.dart';

class DBHelper {
  final DatabaseFactory _dbFactory = databaseFactoryIo;
  Database? db;
  final store = intMapStoreFactory.store('verses');

  static final DBHelper _instance = DBHelper._internal();
  DBHelper._internal();

  factory DBHelper() {
    return _instance;
  }
  Future<Database> get _database async {
    db ??= await _openDb();
    return db!;
  }

  Future<Database> _openDb() async {
    if (db != null) return db!;

    final appDocDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocDir.path, 'verses.db');

    db = await _dbFactory.openDatabase(dbPath);
    return db!;
  }

  Future<int> insertVerse(BibleVerse verse) async {
    try {
      Database db = await _database;
      return await store.add(db, verse.toMap());
    } on Exception catch (_) {
      return -1; // Return -1 or handle the error as needed
      // TODO
    }
  }

  Future<List<BibleVerse>> getAllVerses() async {
    try {
      Database db = await _database;
      final Finder finder = Finder(sortOrders: [SortOrder('text')]);
      final recordSnapshots = await store.find(db, finder: finder);
      return recordSnapshots.map((snapshot) {
        final verse = BibleVerse.fromMap(snapshot.value);
        verse.id = snapshot.key; // Assign the key to the verse id
        return verse;
      }).toList();
    } on Exception catch (_) {
      return []; // Return an empty list or handle the error as needed
      // TODO
    }
  }

  Future<bool> deleteVerse(int id) async {
    try {
      Database db = await _database;
      await store.record(id).delete(db);
      return true; // Return true if a record was deleted
    } on Exception catch (_) {
      return false; // Return false or handle the error as needed
      // TODO
    }
  }
  // static const String dbName = 'bible_verses.db';
  // static const String storeName = 'verses';
  // late Database _database;
  // late StoreRef<String, Map<String, dynamic>> _store;

  // Future<Database> get database async {
  //   return _database;
  // }

  // Future<void> insertVerse(BibleVerse verse) async {
  //   final db = await database;
  //   await _store.record(verse.id as String).put(db, verse.toMap());
  // }

  // Future<BibleVerse?> getVerse(String id) async {
  //   final db = await database;
  //   final recordSnapshot = await _store.record(id).getSnapshot(db);
  //   if (recordSnapshot != null) {
  //     return BibleVerse.fromMap(recordSnapshot.value);
  //   }
  //   return null;
  // }
}
