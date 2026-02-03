import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/product.dart';

class FavoriteProvider with ChangeNotifier {
  List<Map<String, dynamic>> _favorites = [];

  List<Map<String, dynamic>> get favorites => _favorites;

  Future<void> fetchFavorites() async {
    _favorites = await DatabaseHelper.instance.getFavorites();
    notifyListeners();
  }

  Future<void> toggleFavorite(Product product) async {
    final isFav = await DatabaseHelper.instance.isFavorite(product.id);
    if (isFav) {
      await DatabaseHelper.instance.removeFavorite(product.id);
    } else {
      await DatabaseHelper.instance.addFavorite(product);
    }
    await fetchFavorites();
  }

  Future<bool> isFavorite(int id) async {
    return await DatabaseHelper.instance.isFavorite(id);
  }
}
