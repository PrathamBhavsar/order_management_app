import 'package:flutter/material.dart';
import '../../core/constants/constants.dart';
import '../../core/dto/api_request_dto.dart';
import '../../domain/use_cases/local/local_customer_use_cases.dart';
import '../../domain/use_cases/remote/remote_customer_use_cases.dart';
import '../../domain/entities/customer_entity.dart';

class CustomerProvider extends ChangeNotifier {
  final GetRemoteCustomersUseCase _getCustomersUseCase;
  final GetLocalCustomersUseCase _getLocalCustomersUseCase;

  List<CustomerEntity> _customers = [];
  List<CustomerEntity> get customers => _customers;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  CustomerProvider(this._getCustomersUseCase, this._getLocalCustomersUseCase);

  Future<void> fetchCustomers() async {
    _isLoading = true;
    notifyListeners();

    ///try local db first
    _customers = await _getLocalCustomersUseCase.execute();

    if (_customers.isNotEmpty) {
      _isLoading = false;
      notifyListeners();
      return;
    }

    ApiRequestDTO requestDTO = AppConstants.requestDTO;
    final response = await _getCustomersUseCase.execute(requestDTO);

    if (response.success && response.data != null) {
      _customers = response.data!;
    }

    _isLoading = false;
    notifyListeners();
    print(_customers.length);
  }
}
