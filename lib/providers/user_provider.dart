import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  String? _fullName;
  String? _email;
  String? _phoneNumber;
  String? _address;
  String? _dateOfBirth;
  String? _idNumber;
  bool _isKycVerified = false;
  bool _isLoading = false;

  // Getters
  String? get fullName => _fullName;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get address => _address;
  String? get dateOfBirth => _dateOfBirth;
  String? get idNumber => _idNumber;
  bool get isKycVerified => _isKycVerified;
  bool get isLoading => _isLoading;

  // Constructor - load user data
  UserProvider() {
    _loadUserData();
  }

  // Load user data from local storage
  Future<void> _loadUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _fullName = prefs.getString('fullName');
      _email = prefs.getString('userEmail');
      _phoneNumber = prefs.getString('phoneNumber');
      _address = prefs.getString('address');
      _dateOfBirth = prefs.getString('dateOfBirth');
      _idNumber = prefs.getString('idNumber');
      _isKycVerified = prefs.getBool('isKycVerified') ?? false;
      notifyListeners();
    } catch (e) {
      // Handle error loading user data
    }
  }

  // Update user profile
  Future<bool> updateProfile({
    String? fullName,
    String? phoneNumber,
    String? address,
    String? dateOfBirth,
  }) async {
    _setLoading(true);

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      final prefs = await SharedPreferences.getInstance();

      if (fullName != null) {
        _fullName = fullName;
        await prefs.setString('fullName', fullName);
      }

      if (phoneNumber != null) {
        _phoneNumber = phoneNumber;
        await prefs.setString('phoneNumber', phoneNumber);
      }

      if (address != null) {
        _address = address;
        await prefs.setString('address', address);
      }

      if (dateOfBirth != null) {
        _dateOfBirth = dateOfBirth;
        await prefs.setString('dateOfBirth', dateOfBirth);
      }

      _setLoading(false);
      notifyListeners();
      return true;
    } catch (e) {
      _setLoading(false);
      return false;
    }
  }

  // Submit KYC information
  Future<bool> submitKyc({
    required String idNumber,
    required String fullName,
    required String dateOfBirth,
    required String address,
  }) async {
    _setLoading(true);

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 3));

      final prefs = await SharedPreferences.getInstance();

      _idNumber = idNumber;
      _fullName = fullName;
      _dateOfBirth = dateOfBirth;
      _address = address;
      _isKycVerified = true; // In real app, this would be pending approval

      await prefs.setString('idNumber', idNumber);
      await prefs.setString('fullName', fullName);
      await prefs.setString('dateOfBirth', dateOfBirth);
      await prefs.setString('address', address);
      await prefs.setBool('isKycVerified', true);

      _setLoading(false);
      notifyListeners();
      return true;
    } catch (e) {
      _setLoading(false);
      return false;
    }
  }

  // Get user initials for avatar
  String getUserInitials() {
    if (_fullName == null || _fullName!.isEmpty) {
      return _email?.substring(0, 1).toUpperCase() ?? 'U';
    }
    
    final names = _fullName!.split(' ');
    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    } else {
      return names[0].substring(0, 1).toUpperCase();
    }
  }

  // Check if profile is complete
  bool isProfileComplete() {
    return _fullName != null &&
           _email != null &&
           _phoneNumber != null &&
           _address != null;
  }

  // Get completion percentage
  double getProfileCompletionPercentage() {
    int completedFields = 0;
    const int totalFields = 6;

    if (_fullName != null && _fullName!.isNotEmpty) completedFields++;
    if (_email != null && _email!.isNotEmpty) completedFields++;
    if (_phoneNumber != null && _phoneNumber!.isNotEmpty) completedFields++;
    if (_address != null && _address!.isNotEmpty) completedFields++;
    if (_dateOfBirth != null && _dateOfBirth!.isNotEmpty) completedFields++;
    if (_isKycVerified) completedFields++;

    return completedFields / totalFields;
  }

  // Clear user data (for logout)
  void clearUserData() {
    _fullName = null;
    _email = null;
    _phoneNumber = null;
    _address = null;
    _dateOfBirth = null;
    _idNumber = null;
    _isKycVerified = false;
    notifyListeners();
  }

  // Helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Set email (called from auth provider)
  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }
}