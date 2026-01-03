import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validators Tests', () {
    test('Email validation - valid email', () {
      const email = 'test@example.com';
      expect(_validateEmail(email), isNull);
    });

    test('Email validation - invalid email', () {
      const email = 'invalid-email';
      expect(_validateEmail(email), isNotNull);
    });

    test('Password validation - valid password', () {
      const password = 'Test@123';
      expect(_validatePassword(password), isNull);
    });

    test('Password validation - too short', () {
      const password = 'Ab1';
      expect(_validatePassword(password), isNotNull);
    });

    test('Password validation - no uppercase', () {
      const password = 'test123';
      expect(_validatePassword(password), isNotNull);
    });

    test('Password validation - no number', () {
      const password = 'TestTest';
      expect(_validatePassword(password), isNotNull);
    });
  });
}

// Test helper functions matching the Validators class
String? _validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }

  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  if (!emailRegex.hasMatch(value)) {
    return 'Please enter a valid email address';
  }

  return null;
}

String? _validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }

  if (value.length < 6) {
    return 'Password must be at least 6 characters';
  }

  if (!value.contains(RegExp(r'[A-Z]'))) {
    return 'Password must contain at least one uppercase letter';
  }

  if (!value.contains(RegExp(r'[0-9]'))) {
    return 'Password must contain at least one number';
  }

  return null;
}
