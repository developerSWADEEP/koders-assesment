# Koders Assessment - Flutter App

A Flutter mobile application demonstrating clean MVVM architecture with GetX state management, built as part of the Koders Flutter Developer Assessment.

## 📱 Project Overview

This application consumes the [JSONPlaceholder](https://jsonplaceholder.typicode.com) public REST API and demonstrates structured code, efficient state management, and a polished user interface.

## ✨ Features

- **Authentication Module**: Mock login with validation and session handling
- **Posts Feed**: List screen with pull-to-refresh and pagination
- **Post Details**: Detail screen with comments
- **Create Post**: Form with proper validations
- **State Handling**: Loading, empty, and error states

## 🏗️ Architecture

The project follows **MVVM (Model-View-ViewModel)** architecture pattern with **GetX** for state management.

```
lib/
├── main.dart                    # App entry point
├── app/
│   ├── bindings/               # Dependency injection
│   └── routes/                 # Navigation routes
├── core/
│   ├── constants/              # App, API, and storage constants
│   ├── theme/                  # Colors, text styles, and theme
│   ├── network/                # API client, exceptions, responses
│   └── utils/                  # Validators and helpers
├── data/
│   ├── models/                 # Data models (User, Post, Comment)
│   ├── repositories/           # Business logic layer
│   └── services/               # Storage and API services
├── modules/
│   ├── auth/                   # Login module
│   │   ├── bindings/
│   │   ├── controllers/
│   │   └── views/
│   ├── home/                   # Posts list module
│   │   ├── bindings/
│   │   ├── controllers/
│   │   └── views/
│   ├── detail/                 # Post detail module
│   │   ├── bindings/
│   │   ├── controllers/
│   │   └── views/
│   └── create_post/            # Create post module
│       ├── bindings/
│       ├── controllers/
│       └── views/
└── shared/
    └── widgets/                # Reusable UI components
```

## 🛠️ Tech Stack

| Category | Technology |
|----------|------------|
| Framework | Flutter (Latest Stable) |
| State Management | GetX ^4.6.6 |
| HTTP Client | Dio ^5.4.0 |
| Local Storage | GetStorage ^2.1.1 |
| Architecture | MVVM |
| API | JSONPlaceholder |

## 📋 Requirements

- Flutter SDK ^3.9.2
- Dart SDK ^3.9.2
- Android Studio / VS Code
- Xcode (for iOS builds)

## 🚀 Getting Started

### 1. Clone the repository

```bash
git clone <repository-url>
cd koders_assesment
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Run the app

```bash
# For Android
flutter run

# For iOS
flutter run -d ios
```

## 🔐 Demo Credentials

For testing the login functionality:

| Field | Value |
|-------|-------|
| Email | demo@koders.com |
| Password | Demo@123 |

## 📱 Screens

### 1. Login Screen
- Email and password validation
- Remember me option
- Mock authentication with session handling

### 2. Home Screen (Posts Feed)
- Pull-to-refresh functionality
- Infinite scroll pagination
- Post cards with user info
- Delete post option

### 3. Post Detail Screen
- Full post content
- Author information
- Comments section
- Share and like actions (UI only)

### 4. Create Post Screen
- Title and content fields
- Form validation
- Writing tips
- Submit functionality

## 🎨 UI/UX Features

- Clean and modern design
- Custom color scheme with gradients
- Smooth animations and transitions
- Loading states with spinners
- Error states with retry options
- Empty states with action buttons
- Responsive layout

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.6              # State management & navigation
  dio: ^5.4.0              # HTTP client
  get_storage: ^2.1.1      # Local storage
  cupertino_icons: ^1.0.8  # iOS icons
  flutter_spinkit: ^5.2.1  # Loading animations
  cached_network_image: ^3.3.1  # Image caching
  intl: ^0.19.0            # Internationalization
```

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart
```

## 📝 Best Practices Implemented

- ✅ Clean Architecture with MVVM
- ✅ Separation of concerns
- ✅ Reusable widgets
- ✅ Centralized constants and themes
- ✅ Proper error handling
- ✅ Form validations
- ✅ Session management
- ✅ API response parsing
- ✅ Loading states
- ✅ Empty states
- ✅ Error states with retry

## 📄 License

This project is created for assessment purposes for Koders.

---

**Developer**: Flutter Assessment Candidate  
**Date**: January 2026  
**Flutter Version**: ^3.9.2  
**State Management**: GetX
