import 'package:flutter/material.dart';
import '../../core/constants/constants.dart';
import '../../core/dto/api_request_dto.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/local/local_product_usecases.dart';
import '../../domain/usecases/remote/remote_product_usecases.dart';

class ProductProvider extends ChangeNotifier {
  final GetRemoteProductsUseCase _getRemoteProductsUseCase;
  final GetLocalProductsUseCase _getLocalProductsUseCase;

  List<ProductEntity> _products = [];
  List<ProductEntity> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ProductProvider(
      this._getRemoteProductsUseCase, this._getLocalProductsUseCase);

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    ///try local db first
    _products = await _getLocalProductsUseCase.execute();

    if (_products.isNotEmpty) {
      _isLoading = false;
      notifyListeners();
      return;
    }

    ApiRequestDTO requestDTO = AppConstants.requestDTO;
    final response = await _getRemoteProductsUseCase.execute(requestDTO);

    if (response.success && response.data != null) {
      _products = response.data!;
    }

    _isLoading = false;
    notifyListeners();
  }
}
