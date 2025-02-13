import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'order_management.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE customers (
            AccountRef TEXT PRIMARY KEY,
            Name TEXT NOT NULL,
            ContactName TEXT NOT NULL,
            Email TEXT,
            Telephone TEXT,
            Telephone2 TEXT,
            Fax TEXT,
            CountryCode TEXT,
            Address1 TEXT,
            Address2 TEXT,
            Address3 TEXT,
            Address4 TEXT,
            Address5 TEXT,
            CAddress1 TEXT,
            CAddress2 TEXT,
            CAddress3 TEXT,
            CAddress4 TEXT,
            CAddress5 TEXT,
            CreatedDate TEXT,
            DateAccountOpened TEXT,
            DiscountPercentage REAL,
            IsCostcutter INTEGER,
            IsDeleted INTEGER,
            IsHenderson INTEGER,
            IsMessageEnabled INTEGER,
            IsMusgrave INTEGER,
            IsPredictionEnable INTEGER,
            IsTemplateEnable INTEGER,
            Message TEXT,
            ModifiedDate TEXT,
            WebAddress TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE products (
            Id INTEGER PRIMARY KEY,
            Name TEXT NOT NULL,
            BarCode TEXT,
            CreatedDate TEXT,
            Deleted INTEGER,
            IsSpecialOfferSelected INTEGER,
            IsWeight INTEGER,
            ModifiedDate TEXT,
            NominalCode TEXT,
            PackSize INTEGER,
            Price REAL,
            ProductCategory TEXT,
            ProductCode TEXT,
            ProductVatId INTEGER
          )
        ''');

        await db.execute('''
          CREATE TABLE categories (
            Id INTEGER PRIMARY KEY AUTOINCREMENT,
            Name TEXT UNIQUE
          )
        ''');
      },
    );
  }

  Future<void> insertOrUpdateCustomer(Map<String, dynamic> customer) async {
    final db = await database;
    await db.insert(
      'customers',
      customer,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertOrUpdateProduct(Map<String, dynamic> product) async {
    final db = await database;
    await db.insert(
      'products',
      product,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertOrUpdateCategory(Map<String, dynamic> category) async {
    final db = await database;
    await db.insert(
      'categories',
      category,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getCustomers() async {
    final db = await database;
    return await db.query('customers');
  }

  Future<List<Map<String, dynamic>>> getProducts() async {
    final db = await database;
    return await db.query('products');
  }

  Future<List<Map<String, dynamic>>> getCategories() async {
    final db = await database;
    return await db.query('categories');
  }

  Future<void> deleteAllCustomers() async {
    final db = await database;
    await db.delete('customers');
  }

  Future<void> deleteAllProducts() async {
    final db = await database;
    await db.delete('products');
  }

  Future<void> deleteAllCategories() async {
    final db = await database;
    await db.delete('categories');
  }
}
