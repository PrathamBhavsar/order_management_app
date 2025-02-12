import '../../../core/dto/api_request_dto.dart';
import '../../../data/models/api_response.dart';
import '../../../data/repositories/category_repository.dart';

class GetRemoteCategoriesUseCase {
  final CategoryRepository repository;

  GetRemoteCategoriesUseCase(this.repository);

  Future<ApiResponse<List<String>>> execute(ApiRequestDTO requestDTO) async {
    final response = await repository.fetchCategories(requestDTO);

    if (response.success && response.data != null) {
      List<String> categories = List<String>.from(response.data!);

      return ApiResponse(
          success: true, statusCode: 200, message: "Success", data: categories);
    }

    return ApiResponse(
        success: false,
        statusCode: response.statusCode,
        message: response.message,
        data: []);
  }
}
