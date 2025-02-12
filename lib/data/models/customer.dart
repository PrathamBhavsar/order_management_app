import '../../utils/date_util.dart';

class Customer {
  final String accountRef;
  final String address1;
  final String? address2;
  final String? address3;
  final String? address4;
  final String? address5;
  final String? cAddress1;
  final String? cAddress2;
  final String? cAddress3;
  final String? cAddress4;
  final String? cAddress5;
  final String contactName;
  final String countryCode;
  final DateTime createdDate;
  final DateTime dateAccountOpened;
  final double discountPercentage;
  final String email;
  final String? fax;
  final bool isCostcutter;
  final bool isDeleted;
  final bool isHenderson;
  final bool isMessageEnabled;
  final bool isMusgrave;
  final bool isPredictionEnable;
  final bool isTemplateEnable;
  final String message;
  final DateTime modifiedDate;
  final String name;
  final String? telephone;
  final String? telephone2;
  final String? webAddress;

  Customer({
    required this.accountRef,
    required this.address1,
    this.address2,
    this.address3,
    this.address4,
    this.address5,
    this.cAddress1,
    this.cAddress2,
    this.cAddress3,
    this.cAddress4,
    this.cAddress5,
    required this.contactName,
    required this.countryCode,
    required this.createdDate,
    required this.dateAccountOpened,
    required this.discountPercentage,
    required this.email,
    this.fax,
    required this.isCostcutter,
    required this.isDeleted,
    required this.isHenderson,
    required this.isMessageEnabled,
    required this.isMusgrave,
    required this.isPredictionEnable,
    required this.isTemplateEnable,
    required this.message,
    required this.modifiedDate,
    required this.name,
    this.telephone,
    this.telephone2,
    this.webAddress,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        accountRef: json["AccountRef"] ?? "",
        address1: json["Address1"] ?? "",
        address2: json["Address2"],
        address3: json["Address3"],
        address4: json["Address4"],
        address5: json["Address5"],
        cAddress1: json["CAddress1"],
        cAddress2: json["CAddress2"],
        cAddress3: json["CAddress3"],
        cAddress4: json["CAddress4"],
        cAddress5: json["CAddress5"],
        contactName: json["ContactName"] ?? "",
        countryCode: json["CountryCode"] ?? "",
        createdDate: DateUtils.parseApiDate(json["CreatedDate"]),
        dateAccountOpened: DateUtils.parseApiDate(json["DateAccountOpened"]),
        discountPercentage: (json["DiscountPercentage"] ?? 0).toDouble(),
        email: json["Email"] ?? "",
        fax: json["Fax"],
        isCostcutter: json["IsCostcutter"] ?? false,
        isDeleted: json["IsDeleted"] ?? false,
        isHenderson: json["IsHenderson"] ?? false,
        isMessageEnabled: json["IsMessageEnabled"] ?? false,
        isMusgrave: json["IsMusgrave"] ?? false,
        isPredictionEnable: json["IsPredictionEnable"] ?? false,
        isTemplateEnable: json["IsTemplateEnable"] ?? false,
        message: json["Message"] ?? "",
        modifiedDate: DateUtils.parseApiDate(json["ModifiedDate"]),
        name: json["Name"] ?? "",
        telephone: json["Telephone"],
        telephone2: json["Telephone2"],
        webAddress: json["WebAddress"],
      );

  Map<String, dynamic> toJson() => {
        "accountRef": accountRef,
        "address1": address1,
        "address2": address2,
        "address3": address3,
        "address4": address4,
        "address5": address5,
        "cAddress1": cAddress1,
        "cAddress2": cAddress2,
        "cAddress3": cAddress3,
        "cAddress4": cAddress4,
        "cAddress5": cAddress5,
        "contactName": contactName,
        "countryCode": countryCode,
        "createdDate": createdDate.toIso8601String(),
        "dateAccountOpened": dateAccountOpened.toIso8601String(),
        "discountPercentage": discountPercentage,
        "email": email,
        "fax": fax,
        "isCostcutter": isCostcutter ? 1 : 0,
        "isDeleted": isDeleted ? 1 : 0,
        "isHenderson": isHenderson ? 1 : 0,
        "isMessageEnabled": isMessageEnabled ? 1 : 0,
        "isMusgrave": isMusgrave ? 1 : 0,
        "isPredictionEnable": isPredictionEnable ? 1 : 0,
        "isTemplateEnable": isTemplateEnable ? 1 : 0,
        "message": message,
        "modifiedDate": modifiedDate.toIso8601String(),
        "name": name,
        "telephone": telephone,
        "telephone2": telephone2,
        "webAddress": webAddress
      };
}
