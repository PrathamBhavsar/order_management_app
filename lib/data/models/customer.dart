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
        "AccountRef": accountRef,
        "Address1": address1,
        "Address2": address2,
        "Address3": address3,
        "Address4": address4,
        "Address5": address5,
        "CAddress1": cAddress1,
        "CAddress2": cAddress2,
        "CAddress3": cAddress3,
        "CAddress4": cAddress4,
        "CAddress5": cAddress5,
        "ContactName": contactName,
        "CountryCode": countryCode,
        "CreatedDate": createdDate.toIso8601String(),
        "DateAccountOpened": dateAccountOpened.toIso8601String(),
        "DiscountPercentage": discountPercentage,
        "Email": email,
        "Fax": fax,
        "IsCostcutter": isCostcutter ? 1 : 0,
        "IsDeleted": isDeleted ? 1 : 0,
        "IsHenderson": isHenderson ? 1 : 0,
        "IsMessageEnabled": isMessageEnabled ? 1 : 0,
        "IsMusgrave": isMusgrave ? 1 : 0,
        "IsPredictionEnable": isPredictionEnable ? 1 : 0,
        "IsTemplateEnable": isTemplateEnable ? 1 : 0,
        "Message": message,
        "ModifiedDate": modifiedDate.toIso8601String(),
        "Name": name,
        "Telephone": telephone,
        "Telephone2": telephone2,
        "WebAddress": webAddress
      };
}
