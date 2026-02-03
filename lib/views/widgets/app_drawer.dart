import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(authProvider.user?.username ?? "Guest"),
            accountEmail: Text(authProvider.user?.email ?? "Welcome!"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: authProvider.user?.image != null 
                  ? NetworkImage(authProvider.user!.image) 
                  : null,
              child: authProvider.user?.image == null ? const Icon(Icons.person) : null,
            ),
            decoration: const BoxDecoration(color: Colors.purple),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text("Products"),
            onTap: () {
               Navigator.pushReplacementNamed(context, '/products');
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text("Favorites"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/favorites');
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text("My Cart"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/cart');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              authProvider.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
