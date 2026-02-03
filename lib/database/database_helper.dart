import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/product.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('shop_app.db'); // New multi-purpose DB name
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2, // Version increased for new cart table
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE favorites ( 
  id INTEGER PRIMARY KEY, 
  title TEXT NOT NULL,
  thumbnail TEXT NOT NULL
)
''');
    await db.execute('''
CREATE TABLE cart ( 
  id INTEGER PRIMARY KEY, 
  title TEXT NOT NULL,
  thumbnail TEXT NOT NULL,
  price REAL NOT NULL,
  quantity INTEGER NOT NULL
)
''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
CREATE TABLE IF NOT EXISTS cart ( 
  id INTEGER PRIMARY KEY, 
  title TEXT NOT NULL,
  thumbnail TEXT NOT NULL,
  price REAL NOT NULL,
  quantity INTEGER NOT NULL
)
''');
    }
  }

  // Favorite operations
  Future<int> addFavorite(Product product) async {
    final db = await instance.database;
    return await db.insert('favorites', {
      'id': product.id,
      'title': product.title,
      'thumbnail': product.thumbnail,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> removeFavorite(int id) async {
    final db = await instance.database;
    return await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await instance.database;
    return await db.query('favorites');
  }

  Future<bool> isFavorite(int id) async {
    final db = await instance.database;
    final maps = await db.query('favorites', where: 'id = ?', whereArgs: [id]);
    return maps.isNotEmpty;
  }

  // Cart operations
  Future<void> addToCart(Product product, int quantity) async {
    final db = await instance.database;
    await db.insert('cart', {
      'id': product.id,
      'title': product.title,
      'thumbnail': product.thumbnail,
      'price': product.price,
      'quantity': quantity,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateCartQuantity(int id, int quantity) async {
    final db = await instance.database;
    if (quantity <= 0) {
      await db.delete('cart', where: 'id = ?', whereArgs: [id]);
    } else {
      await db.update('cart', {'quantity': quantity}, where: 'id = ?', whereArgs: [id]);
    }
  }

  Future<void> removeFromCart(int id) async {
    final db = await instance.database;
    await db.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getCartItems() async {
    final db = await instance.database;
    return await db.query('cart');
  }

  Future<void> clearCart() async {
    final db = await instance.database;
    await db.delete('cart');
  }

  Future close() async {
    final db = await _database;
    if (db != null) await db.close();
  }
}
