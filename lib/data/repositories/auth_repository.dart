import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/storage_service.dart';

class AuthRepository {
  final StorageService _storageService = Get.find<StorageService>();

  // Mock user credentials for demo
  static const String _mockEmail = 'demo@koders.com';
  static const String _mockPassword = 'Demo@123';

  // Mock login - In real app, this would call API
  Future<UserModel> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Validate credentials
    if (email.toLowerCase() != _mockEmail.toLowerCase() || password != _mockPassword) {
      throw Exception('Invalid email or password');
    }

    // Return mock user
    final user = UserModel(
      id: 1,
      name: 'Demo User',
      username: 'demouser',
      email: email,
      phone: '+1234567890',
      website: 'koders.com',
      address: AddressModel(
        street: '123 Tech Street',
        suite: 'Suite 100',
        city: 'San Francisco',
        zipcode: '94102',
      ),
      company: CompanyModel(
        name: 'Koders Tech',
        catchPhrase: 'Building the future',
        bs: 'technology solutions',
      ),
    );

    // Save session
    await _storageService.setLoggedIn(true);
    await _storageService.setToken('mock_token_${DateTime.now().millisecondsSinceEpoch}');
    await _storageService.setUser(user);
    await _storageService.setUserEmail(email);

    return user;
  }

  // Logout
  Future<void> logout() async {
    await _storageService.clearSession();
  }

  // Check if user is logged in
  bool isLoggedIn() {
    return _storageService.isLoggedIn;
  }

  // Get current user
  UserModel? getCurrentUser() {
    return _storageService.getUser();
  }

  // Get mock credentials for display
  Map<String, String> getMockCredentials() {
    return {
      'email': _mockEmail,
      'password': _mockPassword,
    };
  }
}

