import 'package:sqflite/sqflite.dart';
import '../../core/database/database_helper.dart';
import '../../core/dto/api_request_dto.dart';
import '../../core/network/api_endpoints.dart';
import '../../core/network/api_manager.dart';
import '../models/api_response.dart';

class CategoryRepository {
  final ApiManager _apiManager = ApiManager();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<ApiResponse<List<String>>> fetchCategories(
      ApiRequestDTO requestDTO) async {
    try {
      final response = await _apiManager.post<List<String>>(
        ApiEndpoints.getCategories,
        fromJsonT: (data) => (data as List).map((e) => e.toString()).toList(),
      );

      if (response.success && response.data != null) {
        await _storeCategoriesInDB(response.data!);
      }
      return response;
    } catch (e) {
      return ApiResponse<List<String>>(
        success: false,
        statusCode: 500,
        message: "Failed to fetch categories: $e",
        data: [],
      );
    }
  }

  Future<void> _storeCategoriesInDB(List<String> categories) async {
    var db = await _dbHelper.database;
    Batch batch = db.batch();

    for (var category in categories) {
      batch.insert(
        "categories",
        {"Name": category},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<List<String>> getCategoriesFromDB() async {
    var db = await _dbHelper.database;
    var result = await db.query("categories");

    return result.map((row) => row["Name"] as String).toList();
  }
}
