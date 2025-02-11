import 'package:sqflite/sqflite.dart';

import '../../core/database/database_helper.dart';
import '../../core/network/api_manager.dart';
import '../models/api_response.dart';
import '../models/product.dart';

class ProductRepository {
  final ApiManager _apiManager = ApiManager();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<ApiResponse<List<Product>>> fetchProducts() async {
    try {
      final response = await _apiManager.post<List<Product>>(
        "GetProducts",
        fromJsonT: (data) => (data["GetProductsResult"] as List)
            .map((e) => Product.fromJson(e))
            .toList(),
      );

      if (response.success && response.data != null) {
        await _storeProductsInDB(response.data!);
      }

      return response;
    } catch (e) {
      return ApiResponse<List<Product>>(
        success: false,
        statusCode: 500,
        message: "Failed to fetch products: $e",
        data: [],
      );
    }
  }

  Future<void> _storeProductsInDB(List<Product> products) async {
    var db = await _dbHelper.database;
    for (var product in products) {
      await db.insert(
        "products",
        product.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Product>> getProductsFromDB() async {
    var db = await _dbHelper.database;
    var result = await db.query("products");
    return result.map(Product.fromJson).toList();
  }

  Future<void> deleteAllProducts() async {
    var db = await _dbHelper.database;
    await db.delete("products");
  }
}
