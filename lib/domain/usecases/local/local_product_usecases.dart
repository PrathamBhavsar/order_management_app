import '../../../data/repositories/product_repository.dart';
import '../../entities/product_entity.dart';

class GetLocalProductsUseCase {
  final ProductRepository repository;

  GetLocalProductsUseCase(this.repository);

  Future<List<ProductEntity>> execute() async {
    final products = await repository.getProductsFromDB();
    return products
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
  }
}
