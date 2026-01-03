import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../app/routes/app_routes.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  // Form controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Observable states
  final RxBool isLoading = false.obs;
  final Rxn<UserModel> currentUser = Rxn<UserModel>();
  final RxBool rememberMe = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadMockCredentials();
  }

  @override
  void onReady() {
    super.onReady();
    // Check login status after widget tree is built
    _checkLoginStatus();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void _checkLoginStatus() {
    if (_authRepository.isLoggedIn()) {
      currentUser.value = _authRepository.getCurrentUser();
      Get.offAllNamed(AppRoutes.home);
    }
  }

  void _loadMockCredentials() {
    final credentials = _authRepository.getMockCredentials();
    emailController.text = credentials['email'] ?? '';
    passwordController.text = credentials['password'] ?? '';
  }

  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    try {
      final user = await _authRepository.login(
        emailController.text.trim(),
        passwordController.text,
      );

      currentUser.value = user;
      Helpers.showSuccessSnackbar(
        message: 'Welcome back, ${user.name}!',
        title: 'Login Successful',
      );

      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Helpers.showErrorSnackbar(
        message: e.toString().replaceAll('Exception: ', ''),
        title: 'Login Failed',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      Helpers.showLoading(message: 'Logging out...');
      
      await _authRepository.logout();
      currentUser.value = null;
      
      // Clear form
      emailController.clear();
      passwordController.clear();
      _loadMockCredentials();

      Helpers.hideLoading();
      Get.offAllNamed(AppRoutes.login);

      Helpers.showSuccessSnackbar(
        message: 'You have been logged out successfully',
        title: 'Logged Out',
      );
    } catch (e) {
      Helpers.hideLoading();
      Helpers.showErrorSnackbar(message: 'Failed to logout');
    }
  }

  Map<String, String> getMockCredentials() {
    return _authRepository.getMockCredentials();
  }
}

