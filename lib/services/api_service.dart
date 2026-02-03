import 'package:dio/dio.dart';
import '../models/product.dart';
import '../models/category.dart';
import '../models/user.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://dummyjson.com',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  Future<User?> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {
          'username': username,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      }
    } catch (e) {
      print('Login Error: $e');
    }
    return null;
  }

  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get('/products');
      if (response.statusCode == 200) {
        return (response.data['products'] as List)
            .map((p) => Product.fromJson(p))
            .toList();
      }
    } catch (e) {
      print('Get Products Error: $e');
    }
    return [];
  }

  Future<List<Category>> getCategories() async {
    try {
      final response = await _dio.get('/products/categories');
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((item) {
          if (item is String) {
            // Handle old string-only format
            return Category(
              slug: item,
              name: item[0].toUpperCase() + item.substring(1),
              url: 'https://dummyjson.com/products/category/$item',
            );
          } else {
            // Handle new object format
            return Category.fromJson(item);
          }
        }).toList();
      }
    } catch (e) {
      print('Get Categories Error: $e');
    }
    return [];
  }

  Future<List<Product>> getProductsByCategory(String categorySlug) async {
    try {
      final response = await _dio.get('/products/category/$categorySlug');
      if (response.statusCode == 200) {
        return (response.data['products'] as List)
            .map((p) => Product.fromJson(p))
            .toList();
      }
    } catch (e) {
      print('Get Products By Category Error: $e');
    }
    return [];
  }

  Future<Product?> getProductDetails(int id) async {
    try {
      final response = await _dio.get('/products/$id');
      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      }
    } catch (e) {
      print('Get Product Details Error: $e');
    }
    return null;
  }
}
