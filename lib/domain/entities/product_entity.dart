import '../../data/models/product.dart';

class ProductEntity {
  final int id;
  final String name;
  final String? barCode;
  final DateTime createdDate;
  final bool deleted;
  final bool isSpecialOfferSelected;
  final bool isWeight;
  final DateTime modifiedDate;
  final String nominalCode;
  final int packSize;
  final double price;
  final String productCategory;
  final String productCode;
  final int productVatId;

  ProductEntity({
    required this.id,
    required this.name,
    this.barCode,
    required this.createdDate,
    required this.deleted,
    required this.isSpecialOfferSelected,
    required this.isWeight,
    required this.modifiedDate,
    required this.nominalCode,
    required this.packSize,
    required this.price,
    required this.productCategory,
    required this.productCode,
    required this.productVatId,
  });

  ProductEntity mapCustomerToEntity(Product model) => ProductEntity(
        id: model.id,
        name: model.name,
        createdDate: model.createdDate,
        deleted: model.deleted,
        isSpecialOfferSelected: model.isSpecialOfferSelected,
        isWeight: model.isWeight,
        modifiedDate: model.modifiedDate,
        nominalCode: model.nominalCode,
        packSize: model.packSize,
        price: model.price,
        productCategory: model.productCategory,
        productCode: model.productCode,
        productVatId: model.productVatId,
      );
}
