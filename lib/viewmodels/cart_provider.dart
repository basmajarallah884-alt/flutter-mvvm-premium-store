import 'package:flutter/material.dart';
import '../models/product.dart';
import '../database/database_helper.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartProvider with ChangeNotifier {
  Map<int, CartItem> _items = {};

  Map<int, CartItem> get items => _items;

  int get itemCount {
    int total = 0;
    _items.forEach((key, item) => total += item.quantity);
    return total;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.product.price * cartItem.quantity;
    });
    return total;
  }

  Future<void> loadCart() async {
    final cartData = await DatabaseHelper.instance.getCartItems();
    _items = {};
    for (var item in cartData) {
      final product = Product(
        id: item['id'],
        title: item['title'],
        thumbnail: item['thumbnail'],
        price: (item['price'] as num).toDouble(),
        description: '',
        discountPercentage: 0,
        rating: 0,
        stock: 0,
        brand: '',
        category: '',
        images: [item['thumbnail']],
      );
      _items[product.id] = CartItem(product: product, quantity: item['quantity']);
    }
    notifyListeners();
  }

  void addItem(Product product) async {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity += 1;
      await DatabaseHelper.instance.updateCartQuantity(product.id, _items[product.id]!.quantity);
    } else {
      _items[product.id] = CartItem(product: product);
      await DatabaseHelper.instance.addToCart(product, 1);
    }
    notifyListeners();
  }

  void removeItem(int productId) async {
    _items.remove(productId);
    notifyListeners();
    await DatabaseHelper.instance.removeFromCart(productId);
  }

  void removeSingleItem(int productId) async {
    if (!_items.containsKey(productId)) return;
    if (_items[productId]!.quantity > 1) {
      _items[productId]!.quantity -= 1;
      await DatabaseHelper.instance.updateCartQuantity(productId, _items[productId]!.quantity);
    } else {
      _items.remove(productId);
      await DatabaseHelper.instance.removeFromCart(productId);
    }
    notifyListeners();
  }

  void clearCart() async {
    _items.clear();
    notifyListeners();
    await DatabaseHelper.instance.clearCart();
  }
}
