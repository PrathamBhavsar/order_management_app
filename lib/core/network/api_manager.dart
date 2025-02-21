import 'package:dio/dio.dart';
import '../../data/models/api_response.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'api_endpoints.dart';

class ApiManager {
  static final ApiManager _instance = ApiManager._();

  late final Dio _dio;

  factory ApiManager() => _instance;

  ApiManager._() {
    _dio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));

    _dio.interceptors.addAll([
      LogInterceptor(
        error: true,
        responseBody: true,
        request: true,
        requestBody: true,
        responseHeader: true,
        requestHeader: true,
        logPrint: (object) => debugPrint(object.toString()),
      ),
    ]);
  }

  Future<ApiResponse<T>> post<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    required T Function(dynamic) fromJsonT,
  }) async {
    try {
      Response response = await _dio.post(
        url,
        options:
            options ?? Options(headers: {"Content-Type": "application/json"}),
        data: AppConstants.requestDTO.toJson(),
        queryParameters: queryParameters,
      );

      return ApiResponse.fromDioResponse<T>(response, fromJsonT);
    } catch (e) {
      return ApiResponse<T>(
        success: false,
        statusCode: 500,
        message: "API request failed: $e",
        data: null,
      );
    }
  }
}
