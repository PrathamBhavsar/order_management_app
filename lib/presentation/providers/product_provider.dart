import 'package:flutter/material.dart';
import '../../core/constants/constants.dart';
import '../../core/dto/api_request_dto.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/remote/remote_customer_usecases.dart';
import '../../domain/entities/customer_entity.dart';
import '../../domain/usecases/remote/remote_product_usecases.dart';

class ProductProvider extends ChangeNotifier {
  final GetProductsUseCase _getProductsUseCase;

  List<ProductEntity> _products = [];
  List<ProductEntity> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ProductProvider(this._getProductsUseCase);

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    ApiRequestDTO requestDTO = AppConstants.requestDTO;

    final response = await _getProductsUseCase.execute(requestDTO);

    if (response.success) {
      _products = response.data!;
    }

    _isLoading = false;
    notifyListeners();
  }
}
