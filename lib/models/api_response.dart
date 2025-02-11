import 'dart:convert';
import 'package:dio/dio.dart';
import '../service/log_service.dart';

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
      final Map<String, dynamic> json = jsonDecode(response.data);

      return ApiResponse<T>.fromJson(json, fromJsonT);
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
