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
            accountRef TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            contactName TEXT NOT NULL,
            email TEXT,
            telephone TEXT,
            telephone2 TEXT,
            fax TEXT,
            countryCode TEXT,
            address1 TEXT,
            address2 TEXT,
            address3 TEXT,
            address4 TEXT,
            address5 TEXT,
            cAddress1 TEXT,
            cAddress2 TEXT,
            cAddress3 TEXT,
            cAddress4 TEXT,
            cAddress5 TEXT,
            createdDate TEXT,
            dateAccountOpened TEXT,
            discountPercentage REAL,
            isCostcutter INTEGER,
            isDeleted INTEGER,
            isHenderson INTEGER,
            isMessageEnabled INTEGER,
            isMusgrave INTEGER,
            isPredictionEnable INTEGER,
            isTemplateEnable INTEGER,
            message TEXT,
            modifiedDate TEXT,
            webAddress TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE products (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            barCode TEXT,
            createdDate TEXT,
            deleted INTEGER,
            isSpecialOfferSelected INTEGER,
            isWeight INTEGER,
            modifiedDate TEXT,
            nominalCode TEXT,
            packSize INTEGER,
            price REAL,
            productCategory TEXT,
            productCode TEXT,
            productVatId INTEGER
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

  Future<List<Map<String, dynamic>>> getCustomers() async {
    final db = await database;
    return await db.query('customers');
  }

  Future<List<Map<String, dynamic>>> getProducts() async {
    final db = await database;
    return await db.query('products');
  }

  Future<void> deleteAllCustomers() async {
    final db = await database;
    await db.delete('customers');
  }

  Future<void> deleteAllProducts() async {
    final db = await database;
    await db.delete('products');
  }
}
