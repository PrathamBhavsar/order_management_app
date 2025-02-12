import '../../../core/dto/api_request_dto.dart';
import '../../../data/models/api_response.dart';
import '../../../data/repositories/customer_repository.dart';
import '../../entities/customer_entity.dart';

class GetRemoteCustomersUseCase {
  final CustomerRepository repository;

  GetRemoteCustomersUseCase(this.repository);

  Future<ApiResponse<List<CustomerEntity>>> execute(
      ApiRequestDTO requestDTO) async {
    final response = await repository.fetchCustomers(requestDTO);

    if (response.success && response.data != null) {
      List<CustomerEntity> customers = response.data!
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

      return ApiResponse(
          success: true, statusCode: 200, message: "Success", data: customers);
    }

    return ApiResponse(
        success: false,
        statusCode: response.statusCode,
        message: response.message,
        data: []);
  }
}
