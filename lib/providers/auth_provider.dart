import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _userEmail;
  String? _errorMessage;

  // Getters
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get userEmail => _userEmail;
  String? get errorMessage => _errorMessage;

  // Constructor - check if user is already logged in
  AuthProvider() {
    _checkAuthStatus();
  }

  // Check if user is already authenticated
  Future<void> _checkAuthStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isAuthenticated = prefs.getBool('isAuthenticated') ?? false;
      _userEmail = prefs.getString('userEmail');
      notifyListeners();
    } catch (e) {
      _isAuthenticated = false;
      notifyListeners();
    }
  }

  // Login method (dummy implementation)
  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      // Dummy validation - accept any email with password "password123"
      if (password == 'password123' && email.contains('@')) {
        _isAuthenticated = true;
        _userEmail = email;
        
        // Save to local storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isAuthenticated', true);
        await prefs.setString('userEmail', email);
        
        _setLoading(false);
        notifyListeners();
        return true;
      } else {
        _setError('Invalid email or password. Use "password123" as password.');
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('Login failed. Please try again.');
      _setLoading(false);
      return false;
    }
  }

  // Register method (dummy implementation)
  Future<bool> register(String email, String password, String confirmPassword, String fullName) async {
    _setLoading(true);
    _clearError();

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      // Dummy validation
      if (password != confirmPassword) {
        _setError('Passwords do not match.');
        _setLoading(false);
        return false;
      }

      if (password.length < 6) {
        _setError('Password must be at least 6 characters long.');
        _setLoading(false);
        return false;
      }

      if (!email.contains('@')) {
        _setError('Please enter a valid email address.');
        _setLoading(false);
        return false;
      }

      // Simulate successful registration
      _isAuthenticated = true;
      _userEmail = email;
      
      // Save to local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isAuthenticated', true);
      await prefs.setString('userEmail', email);
      await prefs.setString('fullName', fullName);
      
      _setLoading(false);
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Registration failed. Please try again.');
      _setLoading(false);
      return false;
    }
  }

  // Forgot password method (dummy implementation)
  Future<bool> forgotPassword(String email) async {
    _setLoading(true);
    _clearError();

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      if (!email.contains('@')) {
        _setError('Please enter a valid email address.');
        _setLoading(false);
        return false;
      }

      // Simulate successful password reset request
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Failed to send reset email. Please try again.');
      _setLoading(false);
      return false;
    }
  }

  // Logout method
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      
      _isAuthenticated = false;
      _userEmail = null;
      _clearError();
      notifyListeners();
    } catch (e) {
      // Handle logout error if needed
    }
  }

  // Helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearError() {
    _clearError();
  }
}