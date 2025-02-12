import '../../../data/repositories/customer_repository.dart';
import '../../entities/customer_entity.dart';

class GetLocalCustomersUseCase {
  final CustomerRepository repository;

  GetLocalCustomersUseCase(this.repository);

  Future<List<CustomerEntity>> execute() async {
    final customers = await repository.getCustomersFromDB();
    return customers
        .map((customer) => CustomerEntity(
              accountRef: customer.accountRef,
              address1: customer.address1,
              contactName: customer.contactName,
              countryCode: customer.countryCode,
              createdDate: customer.createdDate,
              dateAccountOpened: customer.dateAccountOpened,
              discountPercentage: customer.discountPercentage,
              email: customer.email,
              isCostcutter: customer.isCostcutter,
              isDeleted: customer.isDeleted,
              isHenderson: customer.isHenderson,
              isMessageEnabled: customer.isMessageEnabled,
              isMusgrave: customer.isMusgrave,
              isPredictionEnable: customer.isPredictionEnable,
              isTemplateEnable: customer.isTemplateEnable,
              message: customer.message,
              modifiedDate: customer.modifiedDate,
              name: customer.name,
            ))
        .toList();
  }
}
