import '../../utils/date_util.dart';

class Product {
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

  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['Id'] ?? 0,
        name: json['Name'] ?? '',
        barCode: json['BarCode'],
        createdDate: DateUtils.parseApiDate(json["CreatedDate"]),
        deleted: json['Deleted'] ?? false,
        isSpecialOfferSelected: json['IsSpecialOfferSelected'] ?? false,
        isWeight: json['IsWeight'] ?? false,
        modifiedDate: DateUtils.parseApiDate(json["ModifiedDate"]),
        nominalCode: json['NominalCode'] ?? '',
        packSize: json['PackSize'] ?? 1,
        price: (json['Price'] ?? 0.0).toDouble(),
        productCategory: json['ProductCategory'] ?? '',
        productCode: json['ProductCode'] ?? '',
        productVatId: json['ProductVatId'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "BarCode": barCode,
        "CreatedDate": createdDate.toIso8601String(),
        "Deleted": deleted,
        "IsSpecialOfferSelected": isSpecialOfferSelected,
        "IsWeight": isWeight,
        "ModifiedDate": modifiedDate.toIso8601String(),
        "NominalCode": nominalCode,
        "PackSize": packSize,
        "Price": price,
        "ProductCategory": productCategory,
        "ProductCode": productCode,
        "ProductVatId": productVatId,
      };
}
