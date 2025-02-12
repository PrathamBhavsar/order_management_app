import 'package:flutter/material.dart';
import '../../core/constants/constants.dart';
import '../../core/dto/api_request_dto.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/use_cases/local/local_category_use_cases.dart';
import '../../domain/use_cases/remote/remote_category_use_cases.dart';

class CategoryProvider extends ChangeNotifier {
  final GetRemoteCategoriesUseCase _getRemoteCategoriesUseCase;
  final GetLocalCategoriesUseCase _getLocalCategoriesUseCase;

  List<String> _categories = [];
  List<String> get categories => _categories;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  CategoryProvider(
      this._getRemoteCategoriesUseCase, this._getLocalCategoriesUseCase);

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();

    ///try local db first
    _categories = await _getLocalCategoriesUseCase.execute();

    if (_categories.isNotEmpty) {
      _isLoading = false;
      notifyListeners();
      return;
    }

    ApiRequestDTO requestDTO = AppConstants.requestDTO;
    final response = await _getRemoteCategoriesUseCase.execute(requestDTO);

    if (response.success && response.data != null) {
      _categories = response.data!;
    }

    _isLoading = false;
    notifyListeners();
  }
}
