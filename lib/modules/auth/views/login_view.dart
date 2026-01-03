import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/validators.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  _buildHeader(),
                  const SizedBox(height: 48),
                  _buildLoginForm(),
                  const SizedBox(height: 24),
                  _buildRememberMe(),
                  const SizedBox(height: 32),
                  _buildLoginButton(),
                  const SizedBox(height: 24),
                  _buildMockCredentialsInfo(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.code_rounded,
            size: 48,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          'Welcome Back!',
          style: AppTextStyles.h1.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Sign in to continue to your account',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          CustomTextField(
            label: 'Email Address',
            hint: 'Enter your email',
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.email_outlined,
            textInputAction: TextInputAction.next,
            validator: Validators.validateEmail,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'Password',
            hint: 'Enter your password',
            controller: controller.passwordController,
            obscureText: true,
            prefixIcon: Icons.lock_outlined,
            textInputAction: TextInputAction.done,
            validator: Validators.validatePassword,
            onSubmitted: (_) => controller.login(),
          ),
        ],
      ),
    );
  }

  Widget _buildRememberMe() {
    return Obx(
      () => Row(
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: Checkbox(
              value: controller.rememberMe.value,
              onChanged: (_) => controller.toggleRememberMe(),
              activeColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: controller.toggleRememberMe,
            child: Text(
              'Remember me',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              // Forgot password action
            },
            child: Text(
              'Forgot Password?',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return Obx(
      () => CustomButton(
        text: 'Sign In',
        onPressed: controller.login,
        isLoading: controller.isLoading.value,
        icon: Icons.login_rounded,
      ),
    );
  }

  Widget _buildMockCredentialsInfo() {
    final credentials = controller.getMockCredentials();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.info.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.info.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.info_outline,
                color: AppColors.info,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Demo Credentials',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.info,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildCredentialRow('Email', credentials['email'] ?? ''),
          const SizedBox(height: 4),
          _buildCredentialRow('Password', credentials['password'] ?? ''),
        ],
      ),
    );
  }

  Widget _buildCredentialRow(String label, String value) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }
}

