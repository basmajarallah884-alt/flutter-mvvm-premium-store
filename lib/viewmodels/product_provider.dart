import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/product.dart';
import '../models/category.dart';

class ProductProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  List<Product> _products = [];
  List<Category> _categories = [];
  String? _selectedCategory;
  bool _isLoading = false;

  List<Product> get products => _products;
  List<Category> get categories => _categories;
  String? get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;

  Future<void> fetchCategories() async {
    _categories = await _apiService.getCategories();
    notifyListeners();
  }

  Future<void> fetchProducts({String? categorySlug}) async {
    _isLoading = true;
    _selectedCategory = categorySlug;
    notifyListeners();

    if (categorySlug == null) {
      _products = await _apiService.getProducts();
    } else {
      _products = await _apiService.getProductsByCategory(categorySlug);
    }

    _isLoading = false;
    notifyListeners();
  }
}
