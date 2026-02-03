import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        title: const Text("Your Cart", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Chip(
                    label: Text(
                      "\$${cart.totalAmount.toStringAsFixed(2)}",
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Colors.purple,
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: cart.items.isEmpty
                        ? null
                        : () {
                            Navigator.pushNamed(context, '/confirmation');
                            cart.clearCart();
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("ORDER NOW"),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: cart.items.isEmpty 
              ? const Center(child: Text("Your cart is empty!", style: TextStyle(fontSize: 18, color: Colors.purple)))
              : ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (ctx, i) {
                    final item = cart.items.values.toList()[i];
                    final productId = cart.items.keys.toList()[i];
                    return CartItemWidget(
                      id: productId,
                      title: item.product.title,
                      quantity: item.quantity,
                      price: item.product.price,
                      thumbnail: item.product.thumbnail,
                    );
                  },
                ),
          )
        ],
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final int id;
  final String title;
  final int quantity;
  final double price;
  final String thumbnail;

  const CartItemWidget({
    super.key,
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
    required this.thumbnail,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Colors.red.shade400,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: const Icon(Icons.delete, color: Colors.white, size: 40),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<CartProvider>(context, listen: false).removeItem(id);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(thumbnail, width: 50, height: 50, fit: BoxFit.cover),
            ),
            title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("Price: \$$price\nTotal: \$${(price * quantity).toStringAsFixed(2)}", style: const TextStyle(color: Colors.purple)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.purple),
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false).removeSingleItem(id);
                  },
                ),
                Text("$quantity", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.purple),
                  onPressed: () {
                    final cartProvider = Provider.of<CartProvider>(context, listen: false);
                    final product = cartProvider.items[id]!.product;
                    cartProvider.addItem(product);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
