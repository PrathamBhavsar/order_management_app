import 'package:flutter/material.dart';
import '../../core/constants/constants.dart';
import '../../core/dto/api_request_dto.dart';
import '../../domain/usecases/remote/remote_customer_usecases.dart';
import '../../domain/entities/customer_entity.dart';

class CustomerProvider extends ChangeNotifier {
  final GetRemoteCustomersUseCase _getCustomersUseCase;

  List<CustomerEntity> _customers = [];
  List<CustomerEntity> get customers => _customers;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  CustomerProvider(this._getCustomersUseCase);

  Future<void> fetchCustomers() async {
    _isLoading = true;
    notifyListeners();

    ApiRequestDTO requestDTO = AppConstants.requestDTO;

    final response = await _getCustomersUseCase.execute(requestDTO);

    if (response.success) {
      _customers = response.data!;
    }

    _isLoading = false;
    notifyListeners();
  }
}
