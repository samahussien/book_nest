// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// class DBHelper {
//   static Database? _database;
//   static const String _tableBooks = 'books';
//   static const String _tableFavorites = 'favorites';
//   static const String _tableSearchResults = 'search';

//   static Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDB('books.db');
//     return _database!;
//   }

//   static Future<Database> _initDB(String filePath) async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, filePath);

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute('''
//           CREATE TABLE $_tableBooks(
//             id TEXT PRIMARY KEY,
//             title TEXT,
//             author TEXT,
//             description TEXT,
//             imageUrl TEXT
//           )
//         ''');

//         await db.execute('''
//           CREATE TABLE $_tableFavorites(
//             id TEXT PRIMARY KEY,
//             title TEXT,
//             author TEXT,
//             description TEXT,
//             imageUrl TEXT
//           )
//         ''');

//         await db.execute('''
//           CREATE TABLE $_tableSearchResults(
//             query TEXT,
//             id TEXT,
//             title TEXT,
//             author TEXT,
//             description TEXT,
//             imageUrl TEXT,
//             PRIMARY KEY (query, id)
//           )
//         ''');
//       },
//     );
//   }

//   // Insert book
//   static Future<void> insertBook(Map<String, dynamic> book) async {
//     final db = await database;
//     await db.insert(_tableBooks, book, conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   static Future<List<Map<String, dynamic>>> getCachedBooks() async {
//     final db = await database;
//     return await db.query(_tableBooks);
//   }

//   // Insert search result
//   static Future<void> insertSearchResult(String query, Map<String, dynamic> book) async {
//     final db = await database;
//     await db.insert(
//       _tableSearchResults,
//       {
//         ...book,
//         'query': query,
//       },
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   static Future<List<Map<String, dynamic>>> getCachedSearchResults(String query) async {
//     final db = await database;
//     return await db.query(
//       _tableSearchResults,
//       where: 'query = ?',
//       whereArgs: [query],
//     );
//   }

//   // Favorites (same as before)
//   static Future<void> insertFavorite(Map<String, dynamic> book) async {
//     final db = await database;
//     await db.insert(_tableFavorites, book, conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   static Future<void> removeFavorite(String id) async {
//     final db = await database;
//     await db.delete(_tableFavorites, where: 'id = ?', whereArgs: [id]);
//   }

//   static Future<List<Map<String, dynamic>>> getFavorites() async {
//     final db = await database;
//     return await db.query(_tableFavorites);
//   }
// }
