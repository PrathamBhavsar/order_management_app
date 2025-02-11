import '../../data/models/customer.dart';

class CustomerEntity {
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

  CustomerEntity({
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

  CustomerEntity mapCustomerToEntity(Customer model) => CustomerEntity(
        accountRef: model.accountRef,
        address1: model.address1,
        address2: model.address2,
        address3: model.address3,
        address4: model.address4,
        address5: model.address5,
        cAddress1: model.cAddress1,
        cAddress2: model.cAddress2,
        cAddress3: model.cAddress3,
        cAddress4: model.cAddress4,
        cAddress5: model.cAddress5,
        contactName: model.contactName,
        countryCode: model.countryCode,
        createdDate: model.createdDate,
        dateAccountOpened: model.dateAccountOpened,
        discountPercentage: model.discountPercentage,
        email: model.email,
        fax: model.fax,
        isCostcutter: model.isCostcutter,
        isDeleted: model.isDeleted,
        isHenderson: model.isHenderson,
        isMessageEnabled: model.isMessageEnabled,
        isMusgrave: model.isMusgrave,
        isPredictionEnable: model.isPredictionEnable,
        isTemplateEnable: model.isTemplateEnable,
        message: model.message,
        modifiedDate: model.modifiedDate,
        name: model.name,
        telephone: model.telephone,
        telephone2: model.telephone2,
        webAddress: model.webAddress,
      );
}
