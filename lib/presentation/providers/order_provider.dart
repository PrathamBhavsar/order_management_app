import 'package:flutter/material.dart';
import '../../domain/entities/customer_entity.dart';
import '../../domain/entities/product_entity.dart';

class OrderProvider extends ChangeNotifier {
  CustomerEntity? _selectedCustomer;
  ProductEntity? _selectedProduct;
  String? _selectedCategory;
  int _selectedQuantity = 1;

  List<CustomerEntity> _customers = [];
  List<ProductEntity> _products = [];
  List<String> _categories = [];

  final Map<ProductEntity, int> _orderItems = {};

  CustomerEntity? get selectedCustomer => _selectedCustomer;
  ProductEntity? get selectedProduct => _selectedProduct;
  String? get selectedCategory => _selectedCategory;
  int get selectedQuantity => _selectedQuantity;

  List<CustomerEntity> get customers => _customers;
  List<ProductEntity> get products => _products;
  List<String> get categories => _categories;
  Map<ProductEntity, int> get orderItems => _orderItems;

  void setCustomers(List<CustomerEntity> newCustomers) {
    _customers = newCustomers;
    notifyListeners();
  }

  void setProducts(List<ProductEntity> newProducts) {
    _products = newProducts;
    notifyListeners();
  }

  void setCategories(List<String> newCategories) {
    _categories = newCategories;
    notifyListeners();
  }

  void setSelectedCustomer(CustomerEntity? customer) {
    _selectedCustomer = customer;
    notifyListeners();
  }

  void setSelectedProduct(ProductEntity? product) {
    _selectedProduct = product;
    notifyListeners();
  }

  void setSelectedCategory(String? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSelectedQuantity(int quantity) {
    _selectedQuantity = quantity;
    notifyListeners();
  }

  void addOrderItem() {
    if (_selectedProduct != null) {
      if (_orderItems.containsKey(_selectedProduct)) {
        _orderItems[_selectedProduct!] =
            _orderItems[_selectedProduct]! + _selectedQuantity;
      } else {
        _orderItems[_selectedProduct!] = _selectedQuantity;
      }
      notifyListeners();
    }
  }

  void subtractItemQty(ProductEntity product) {
    if (_orderItems.containsKey(product)) {
      if (_orderItems[product]! > 1) {
        _orderItems[product] = _orderItems[product]! - 1;
      } else {
        _orderItems.remove(product);
      }
      notifyListeners();
    }
  }

  void removeOrderItem(ProductEntity product) {
    _orderItems.remove(product);
    notifyListeners();
  }

  void clearSelections() {
    _selectedCustomer = null;
    _selectedProduct = null;
    _selectedCategory = null;
    _selectedQuantity = 1;
    notifyListeners();
  }
}
