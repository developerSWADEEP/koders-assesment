# App Information - Koders Assessment Flutter App

## 📱 Application Overview

This is a Flutter mobile application built using the **MVVM (Model-View-ViewModel)** architecture pattern with **GetX** state management. The app consumes the [JSONPlaceholder](https://jsonplaceholder.typicode.com) REST API to demonstrate a complete social media-style post management system with authentication, post listing, details, and creation capabilities.

---

## 🏗️ How the App Works

### Architecture Flow

The app follows a clean, layered architecture that separates concerns:

```
User Interaction (View)
    ↓
Controller (ViewModel) - Manages State & Business Logic
    ↓
Repository - Handles Data Operations
    ↓
API Client / Storage Service - Network & Local Storage
    ↓
External API / Local Database
```

### Application Initialization Flow

1. **App Startup** (`main.dart`):
   - Initializes Flutter bindings
   - Configures system UI (status bar, navigation bar)
   - Sets preferred device orientation (portrait only)
   - Initializes `StorageService` for local data persistence
   - Sets up GetX routing and navigation

2. **Dependency Injection** (`InitialBinding`):
   - Registers `ApiClient` as a singleton service
   - Registers `StorageService` for local storage operations
   - Makes services available throughout the app via GetX dependency injection

3. **Route Initialization**:
   - App checks if user is logged in via `StorageService`
   - If logged in → Navigate to Home Screen
   - If not logged in → Navigate to Login Screen

### Data Flow Architecture

#### 1. **Network Layer** (`core/network/`)
- **ApiClient**: Centralized HTTP client using Dio
  - Handles all API requests (GET, POST, PUT, DELETE)
  - Manages request/response interceptors
  - Automatically adds authentication tokens to headers
  - Converts Dio exceptions to custom `ApiException` types
  - Handles timeout, network errors, and HTTP status codes

#### 2. **Repository Layer** (`data/repositories/`)
- **PostRepository**: Manages all post-related operations
  - Fetches posts with pagination support
  - Retrieves single post details
  - Fetches comments for posts
  - Creates, updates, and deletes posts
- **AuthRepository**: Handles authentication logic
  - Validates credentials (mock authentication)
  - Manages user session
  - Stores/retrieves user data from local storage

#### 3. **Controller Layer** (`modules/*/controllers/`)
- **HomeController**: Manages posts list state
  - Handles pagination logic
  - Manages pull-to-refresh
  - Controls loading, error, and empty states
  - Handles post deletion
  
- **AuthController**: Manages authentication state
  - Validates login form
  - Handles login/logout operations
  - Manages "Remember Me" functionality
  
- **DetailController**: Manages post detail view
  - Loads post data and comments
  - Handles refresh functionality
  
- **CreatePostController**: Manages post creation
  - Validates form inputs
  - Submits new posts to API
  - Updates home feed after creation

#### 4. **View Layer** (`modules/*/views/`)
- Reactive UI that automatically updates when controller state changes
- Uses GetX observables for state management
- Implements custom widgets for consistent UI

---

## ✨ Features in Detail

### 1. Authentication Module

**Location**: `modules/auth/`

**How it Works**:
- **Login Screen**: 
  - Email and password input fields with real-time validation
  - "Remember Me" checkbox to save credentials locally
  - Form validation ensures:
    - Email format is correct
    - Password meets minimum requirements
  - Mock authentication (no real backend)
  - Session management using `GetStorage`
  - Auto-redirect to home if already logged in

**Key Features**:
- ✅ Email format validation
- ✅ Password strength validation
- ✅ Remember Me functionality
- ✅ Session persistence
- ✅ Auto-login on app restart
- ✅ Logout functionality
- ✅ Demo credentials pre-filled for testing

**Demo Credentials**:
- Email: `demo@koders.com`
- Password: `Demo@123`

**Technical Implementation**:
- Uses `AuthRepository` for authentication logic
- Stores user session in `GetStorage`
- Validates credentials against mock data
- Manages authentication state with GetX observables

---

### 2. Posts Feed (Home Screen)

**Location**: `modules/home/`

**How it Works**:
- Displays a scrollable list of posts fetched from JSONPlaceholder API
- Implements **pagination** to load posts in chunks (10 posts per page)
- **Pull-to-refresh** functionality to reload posts
- **Infinite scroll** - automatically loads more posts when user scrolls to bottom
- Each post card displays:
  - Post title
  - Post body (truncated)
  - Author information
  - Delete option

**Key Features**:
- ✅ Pagination (10 posts per page)
- ✅ Pull-to-refresh
- ✅ Infinite scroll pagination
- ✅ Loading states with spinners
- ✅ Empty state when no posts available
- ✅ Error state with retry functionality
- ✅ Delete post with confirmation dialog
- ✅ Smooth scrolling animations
- ✅ Post cards with user information

**Technical Implementation**:
- Uses `HomeController` to manage state
- `PostRepository` handles API calls with pagination parameters
- Tracks current page and page size
- Manages `hasMoreData` flag to prevent unnecessary API calls
- Reactive UI updates when posts list changes

**State Management**:
- `ViewState` enum: `initial`, `loading`, `loaded`, `empty`, `error`
- Observable list of posts that automatically updates UI
- Separate loading state for pagination (`isLoadingMore`)

---

### 3. Post Detail Screen

**Location**: `modules/detail/`

**How it Works**:
- Displays full post content with all details
- Shows post author information
- Shows all comments associated with the post
- Pull-to-refresh to reload post and comments
- Share and like buttons (UI only, no backend functionality)

**Key Features**:
- ✅ Full post content display
- ✅ Author information section
- ✅ Comments list with loading indicator
- ✅ Pull-to-refresh functionality
- ✅ Error handling with retry option
- ✅ Loading states
- ✅ Share button (UI)
- ✅ Like button (UI)

**Technical Implementation**:
- Receives post data via GetX route arguments
- Can also fetch post by ID if needed
- Loads comments asynchronously after post loads
- Uses `DetailController` to manage state
- Comments loading doesn't block UI (fails silently if error occurs)

**Data Flow**:
1. Post data passed from Home screen via navigation
2. Controller receives post in `onInit()`
3. Post displayed immediately
4. Comments fetched in background
5. Comments list updates when loaded

---

### 4. Create Post Screen

**Location**: `modules/create_post/`

**How it Works**:
- Form with two input fields:
  - **Title**: Required, minimum length validation
  - **Body**: Required, minimum length validation
- Real-time form validation
- Writing tips displayed to guide users
- Submit button creates new post via API
- After successful creation:
  - Shows success message
  - Adds post to top of home feed
  - Navigates back to home screen

**Key Features**:
- ✅ Form validation (title and body required)
- ✅ Minimum length validation
- ✅ Real-time validation feedback
- ✅ Loading state during submission
- ✅ Success/error notifications
- ✅ Auto-update home feed after creation
- ✅ Writing tips for users

**Technical Implementation**:
- Uses `CreatePostController` for form management
- Validates form before submission
- Calls `PostRepository.createPost()` with form data
- Updates `HomeController` posts list after successful creation
- Uses GetX snackbar for user feedback

**Validation Rules**:
- Title: Required, minimum 3 characters
- Body: Required, minimum 10 characters

---

## 🔄 User Flow

### Complete User Journey

1. **App Launch**:
   - App checks for existing session
   - If logged in → Go to Home
   - If not → Go to Login

2. **Login Flow**:
   - User enters credentials
   - Form validates inputs
   - On submit, credentials are validated
   - Session is saved to local storage
   - User redirected to Home screen

3. **Home Screen Flow**:
   - Posts are fetched automatically (first page)
   - User can scroll to load more posts
   - User can pull down to refresh
   - User can tap a post to view details
   - User can delete posts (with confirmation)
   - User can create new post via FAB button

4. **Post Detail Flow**:
   - Post details displayed immediately
   - Comments load in background
   - User can refresh to reload data
   - User can navigate back to home

5. **Create Post Flow**:
   - User fills form with title and body
   - Form validates inputs in real-time
   - On submit, post is created via API
   - Success message shown
   - Post appears at top of home feed
   - User returns to home screen

---

## 🎨 UI/UX Features

### Design System

- **Color Scheme**: Custom gradient colors with primary and secondary themes
- **Typography**: Consistent text styles throughout the app
- **Components**: Reusable custom widgets for buttons, text fields, loading states

### State Indicators

1. **Loading States**:
   - Spinner animations during data fetching
   - Skeleton loaders for better UX
   - Loading overlays for async operations

2. **Error States**:
   - User-friendly error messages
   - Retry buttons for failed operations
   - Network error detection and messaging

3. **Empty States**:
   - Informative empty state widgets
   - Action buttons to refresh or create content
   - Helpful messages to guide users

### Animations & Transitions

- Smooth page transitions (fade animation)
- Pull-to-refresh animations
- Loading spinner animations
- Button press feedback
- List item animations

---

## 🔧 Technical Features

### State Management (GetX)

- **Reactive Programming**: Uses observables (`Rx`, `RxList`, `Rxn`)
- **Dependency Injection**: Automatic service registration and retrieval
- **Navigation**: Route-based navigation with arguments
- **Snackbars & Dialogs**: Built-in UI feedback mechanisms

### Network Handling

- **Centralized API Client**: Single point for all HTTP requests
- **Error Handling**: Custom exception types for different error scenarios
- **Request Interceptors**: Automatic token injection
- **Response Interceptors**: Error transformation
- **Timeout Management**: Configurable connection and receive timeouts
- **Logging**: Request/response logging in debug mode

### Local Storage

- **GetStorage**: Lightweight key-value storage
- **Session Persistence**: User login state saved
- **Credential Storage**: "Remember Me" functionality
- **Token Management**: Authentication token storage

### Code Organization

- **Separation of Concerns**: Clear layer separation
- **Reusable Components**: Shared widgets for common UI elements
- **Constants Management**: Centralized constants for API, app config, storage keys
- **Theme Management**: Centralized color and text style definitions
- **Utility Functions**: Helper functions for common operations

---

## 📊 Data Models

### PostModel
- `id`: Unique post identifier
- `userId`: Author's user ID
- `title`: Post title
- `body`: Post content
- `user`: Associated user information

### UserModel
- `id`: User identifier
- `name`: User's full name
- `email`: User's email address
- `username`: User's username

### CommentModel
- `id`: Comment identifier
- `postId`: Associated post ID
- `name`: Commenter's name
- `email`: Commenter's email
- `body`: Comment content

---

## 🔐 Security & Best Practices

### Implemented Practices

- ✅ Form validation on client side
- ✅ Secure storage for sensitive data
- ✅ Error handling for network failures
- ✅ Session management
- ✅ Token-based authentication (ready for real backend)
- ✅ Input sanitization
- ✅ Proper resource disposal (controllers, text fields)

### Error Handling Strategy

- **Network Errors**: Detected and shown with retry options
- **API Errors**: Parsed and displayed with user-friendly messages
- **Validation Errors**: Shown inline with form fields
- **Unexpected Errors**: Caught and handled gracefully

---

## 🚀 Performance Optimizations

- **Pagination**: Loads data in chunks to reduce initial load time
- **Image Caching**: Uses `cached_network_image` for efficient image loading
- **Lazy Loading**: Comments load asynchronously without blocking UI
- **State Management**: Efficient reactive updates only when needed
- **Memory Management**: Proper disposal of controllers and resources

---

## 📱 Platform Support

- **Android**: Fully supported
- **iOS**: Fully supported
- **Web**: Supported (with Flutter web)
- **Desktop**: Can be extended (not currently configured)

---

## 🔄 API Integration

### Base URL
- `https://jsonplaceholder.typicode.com`

### Endpoints Used

1. **GET /posts**: Fetch posts (with pagination)
2. **GET /posts/:id**: Get single post
3. **GET /posts/:id/comments**: Get post comments
4. **POST /posts**: Create new post
5. **PUT /posts/:id**: Update post
6. **DELETE /posts/:id**: Delete post

### API Features

- Pagination support via `_start` and `_limit` query parameters
- Error handling for all HTTP status codes
- Request/response logging in debug mode
- Automatic retry logic (can be extended)

---

## 📝 Code Quality

### Architecture Benefits

- **Maintainability**: Clear separation makes code easy to modify
- **Testability**: Each layer can be tested independently
- **Scalability**: Easy to add new features and modules
- **Reusability**: Components and utilities can be reused
- **Readability**: Well-organized structure with clear naming

### Best Practices Followed

- ✅ MVVM architecture pattern
- ✅ Dependency injection
- ✅ Repository pattern for data access
- ✅ Service layer for external dependencies
- ✅ Custom widgets for reusability
- ✅ Constants management
- ✅ Error handling
- ✅ Loading states
- ✅ Form validation
- ✅ Resource disposal

---

## 🎯 Future Enhancement Possibilities

While not currently implemented, the architecture supports:

- Real authentication backend integration
- Offline data caching
- Push notifications
- Image upload functionality
- Post editing
- User profiles
- Search functionality
- Filtering and sorting
- Dark mode theme
- Multi-language support
- Unit and widget testing
- CI/CD pipeline integration

---

## 📚 Summary

This Flutter application demonstrates a production-ready architecture with:

- **Clean MVVM Architecture**: Separation of concerns for maintainability
- **GetX State Management**: Reactive and efficient state handling
- **Complete CRUD Operations**: Create, Read, Update, Delete posts
- **Robust Error Handling**: User-friendly error messages and retry mechanisms
- **Modern UI/UX**: Smooth animations, loading states, and responsive design
- **Session Management**: Persistent login state
- **Pagination**: Efficient data loading with pagination
- **Form Validation**: Real-time input validation
- **API Integration**: Complete integration with JSONPlaceholder API

The app is structured to be easily extensible and maintainable, following Flutter and Dart best practices throughout the codebase.

---

**Last Updated**: January 2026  
**Flutter Version**: ^3.9.2  
**Architecture**: MVVM with GetX  
**API**: JSONPlaceholder REST API

