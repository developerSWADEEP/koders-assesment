import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_colors.dart';

class Helpers {
  Helpers._();

  /// Show success snackbar
  static void showSuccessSnackbar({
    required String message,
    String? title,
    Duration? duration,
  }) {
    Get.snackbar(
      title ?? 'Success',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.success,
      colorText: AppColors.white,
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      icon: const Icon(Icons.check_circle, color: AppColors.white),
    );
  }

  /// Show error snackbar
  static void showErrorSnackbar({
    required String message,
    String? title,
    Duration? duration,
  }) {
    Get.snackbar(
      title ?? 'Error',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.error,
      colorText: AppColors.white,
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      icon: const Icon(Icons.error, color: AppColors.white),
    );
  }

  /// Show warning snackbar
  static void showWarningSnackbar({
    required String message,
    String? title,
    Duration? duration,
  }) {
    Get.snackbar(
      title ?? 'Warning',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.warning,
      colorText: AppColors.white,
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      icon: const Icon(Icons.warning, color: AppColors.white),
    );
  }

  /// Show info snackbar
  static void showInfoSnackbar({
    required String message,
    String? title,
    Duration? duration,
  }) {
    Get.snackbar(
      title ?? 'Info',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.info,
      colorText: AppColors.white,
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      icon: const Icon(Icons.info, color: AppColors.white),
    );
  }

  /// Show loading dialog
  static void showLoading({String? message}) {
    Get.dialog(
      PopScope(
        canPop: false,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(color: AppColors.primary),
                if (message != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    message,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  /// Hide loading dialog
  static void hideLoading() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  /// Show confirmation dialog
  static Future<bool?> showConfirmDialog({
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
  }) async {
    return await Get.dialog<bool>(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(cancelText ?? 'Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            child: Text(confirmText ?? 'Confirm'),
          ),
        ],
      ),
    );
  }

  /// Format date
  static String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  /// Get greeting based on time
  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
}

