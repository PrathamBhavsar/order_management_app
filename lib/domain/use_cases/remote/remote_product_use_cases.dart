import '../../../core/dto/api_request_dto.dart';
import '../../../data/models/api_response.dart';
import '../../../data/repositories/product_repository.dart';
import '../../entities/product_entity.dart';

class GetRemoteProductsUseCase {
  final ProductRepository repository;

  GetRemoteProductsUseCase(this.repository);

  Future<ApiResponse<List<ProductEntity>>> execute(
      ApiRequestDTO requestDTO) async {
    final response = await repository.fetchProducts(requestDTO);

    if (response.success && response.data != null) {
      List<ProductEntity> products = response.data!
          .map((product) => ProductEntity(
                id: product.id,
                name: product.name,
                barCode: product.barCode,
                createdDate: product.createdDate,
                deleted: product.deleted,
                isSpecialOfferSelected: product.isSpecialOfferSelected,
                isWeight: product.isWeight,
                modifiedDate: product.modifiedDate,
                nominalCode: product.nominalCode,
                packSize: product.packSize,
                price: product.price,
                productCategory: product.productCategory,
                productCode: product.productCode,
                productVatId: product.productVatId,
              ))
          .toList();

      return ApiResponse(
          success: true, statusCode: 200, message: "Success", data: products);
    }

    return ApiResponse(
        success: false,
        statusCode: response.statusCode,
        message: response.message,
        data: []);
  }
}
