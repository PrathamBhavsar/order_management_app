import 'dart:convert';
import 'package:dio/dio.dart';
import '../../service/log_service.dart';

class ApiResponse<T> {
  final bool success;
  final int statusCode;
  final String message;
  final T? data;

  ApiResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory ApiResponse.fromJson(
          Map<String, dynamic> json, T Function(dynamic) fromJsonT) =>
      ApiResponse<T>(
        success: json.containsKey('success') ? json['success'] : true,
        statusCode: json.containsKey('status') ? json['status'] : 200,
        message: json.containsKey('message')
            ? json['message']
            : "Request successful",
        data: json['data'] != null ? fromJsonT(json['data']) : null,
      );

  static ApiResponse<T> fromDioResponse<T>(
      Response response, T Function(dynamic) fromJsonT) {
    try {
      final json =
          response.data is String ? jsonDecode(response.data) : response.data;

      //get first key
      if (json is Map<String, dynamic> && json.isNotEmpty) {
        final firstKey = json.keys.first;
        final extractedData = json[firstKey];

        if (extractedData is List) {
          return ApiResponse<T>.fromJson({"data": extractedData}, fromJsonT);
        }
      }

      return ApiResponse<T>(
        success: false,
        statusCode: response.statusCode ?? 500,
        message: "Unexpected response format",
        data: null,
      );
    } catch (e) {
      LogService().logMessage("Error parsing response: $e");
      return ApiResponse<T>(
        success: false,
        statusCode: response.statusCode ?? 500,
        message: "Error parsing response",
        data: null,
      );
    }
  }
}
