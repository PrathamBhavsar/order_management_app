import 'package:sqflite/sqflite.dart';
import '../../core/database/database_helper.dart';
import '../../core/dto/api_request_dto.dart';
import '../../core/network/api_endpoints.dart';
import '../../core/network/api_manager.dart';
import '../models/api_response.dart';
import '../models/customer.dart';

class CustomerRepository {
  final ApiManager _apiManager = ApiManager();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<ApiResponse<List<Customer>>> fetchCustomers(
      ApiRequestDTO requestDTO) async {
    try {
      final response = await _apiManager.post<List<Customer>>(
        ApiEndpoints.getCustomers,
        data: requestDTO.toJson(),
        fromJsonT: (data) =>
            (data as List).map((e) => Customer.fromJson(e)).toList(),
      );

      if (response.success && response.data != null) {
        await _storeCustomersInDB(response.data!);
      }

      return response;
    } catch (e) {
      return ApiResponse<List<Customer>>(
        success: false,
        statusCode: 500,
        message: "Failed to fetch customers: $e",
        data: [],
      );
    }
  }

  Future<void> _storeCustomersInDB(List<Customer> customers) async {
    var db = await _dbHelper.database;
    for (var customer in customers) {
      print(customer.toJson());
      await db.insert(
        "customers",
        customer.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Customer>> getCustomersFromDB() async {
    var db = await _dbHelper.database;
    var result = await db.query("customers");
    return result.map(Customer.fromJson).toList();
  }
}
