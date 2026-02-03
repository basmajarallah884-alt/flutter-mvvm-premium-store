import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/favorite_provider.dart';
import '../../services/api_service.dart';
import 'product_details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Favorites"),
      ),
      body: favoriteProvider.favorites.isEmpty
          ? const Center(child: Text("You have no favorites yet."))
          : ListView.builder(
              itemCount: favoriteProvider.favorites.length,
              itemBuilder: (ctx, i) {
                final fav = favoriteProvider.favorites[i];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.network(fav['thumbnail'], width: 50),
                    title: Text(fav['title']),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: ()async {
                        // We need to fetch the full product object to toggle or just remove by ID
                        // For simplicity, we'll just remove by ID here but normally we'd fetch details
                        final api = ApiService();
                        final product = await api.getProductDetails(fav['id']);
                        if (product != null) {
                            favoriteProvider.toggleFavorite(product);
                        }
                      },
                    ),
                    onTap: () async {
                      // Navigate to details
                      final api = ApiService();
                      final product = await api.getProductDetails(fav['id']);
                      if (product != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailsScreen(product: product),
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}
