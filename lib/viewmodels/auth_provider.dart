import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  Future<bool> login(String email, String password) async {
    // Basic validation as requested: contains @ and .com, and password >= 4
    if (email.contains('@') && email.contains('.com') && password.length >= 4) {
      _isLoading = true;
      notifyListeners();

      // Mock delay for realism
      await Future.delayed(const Duration(milliseconds: 500));

      _user = User(
        email: email,
        username: email.split('@')[0], // Use part of email as username
        image: "https://robohash.org/${email.length}.png", // Dynamic-ish image
      );

      _isLoading = false;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
      notifyListeners();
      return true;
    }

    return false;
  }

  void logout() async {
    _user = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    notifyListeners();
  }

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('token')) return;

    // In a real app, you might want to verify the token or fetch user profile
    // For DummyJSON, we'll just assume it's valid if present for now or skip for simplicity
  }
}
