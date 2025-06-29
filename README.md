# Todo Task Management Mobile Application

A cross-platform Todo Task Management Mobile App built with Flutter for the hackathon challenge. This app enables users to log in via Google authentication and manage personal tasks with full CRUD operations.

## 🚀 Features

### ✅ Authentication
- **Google Sign-In Integration**: Secure authentication using Google OAuth
- **Error Handling**: Comprehensive error states and user feedback
- **Loading States**: Smooth loading indicators during authentication

### ✅ Task Management
- **Full CRUD Operations**: Create, Read, Update, and Delete tasks
- **Task Fields**: Title, description, due date, status, and priority levels
- **Local State Management**: Tasks stored in local state for the session
- **Priority Levels**: High, Medium, and Low priority with color coding

### ✅ User Experience
- **Intuitive UI Components**:
  - Tabbed interface (All, Open, Completed tasks)
  - Advanced filtering by status and priority
  - Real-time search functionality
  - No data states with helpful prompts
  - Floating Action Button for adding tasks
- **Smooth Animations**: List interactions with insertion, deletion, and completion animations
- **Swipe-to-Delete**: Swipe left on any task to delete it
- **Pull-to-Refresh**: Pull down to refresh the task list

### ✅ Polish & Extras
- **Modern UI Design**: Clean, responsive design with Material 3
- **Crash Reporting**: Sentry integration for error tracking
- **Error Handling**: Comprehensive error handling throughout the app
- **Responsive Design**: Works seamlessly on both Android and iOS

## 🛠 Tech Stack

- **Frontend**: Flutter (Cross-platform mobile development)
- **State Management**: Provider pattern
- **Authentication**: Google Sign-In
- **Crash Reporting**: Sentry
- **UI Components**: Material Design 3
- **Animations**: Flutter's built-in animation system

## 📱 Screenshots

### Login Screen
- Beautiful gradient background
- Google Sign-In button
- Feature showcase
- Error handling with user-friendly messages

### Home Screen
- Tabbed interface (All/Open/Completed)
- Search bar with real-time filtering
- Priority and status filter chips
- Swipe-to-delete functionality
- Pull-to-refresh support

### Task Management
- Add new tasks with priority selection
- Edit task details
- Mark tasks as complete/incomplete
- Visual priority indicators
- Due date tracking with overdue warnings

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code
- Google Cloud Console project (for Google Sign-In)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd todo_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Google Sign-In**
   - Create a project in Google Cloud Console
   - Enable Google Sign-In API
   - Add your SHA-1 fingerprint for Android
   - Update the configuration in your project

4. **Configure Sentry (Optional)**
   - Create a Sentry project
   - Replace the DSN in `lib/main.dart`
   - Set `debug = true` for development

5. **Run the app**
   ```bash
   flutter run
   ```

## 📁 Project Structure

```
lib/
├── main.dart              # App entry point with Sentry initialization
├── app.dart               # Main app widget
├── models/
│   └── task.dart          # Task model with enums and JSON serialization
├── services/
│   ├── auth_service.dart  # Google authentication service
│   ├── task_service.dart  # Task management service
│   └── error_service.dart # Error handling and crash reporting
├── screens/
│   ├── login_screen.dart  # Authentication screen
│   └── home_screen.dart   # Main task management screen
└── widgets/
    ├── task_tile.dart     # Individual task display widget
    └── task_form.dart     # Task creation/editing form
```

## 🎯 Hackathon Requirements Met

### ✅ Onboarding & Authentication
- [x] Social login flow using Google provider
- [x] Appropriate error states on login failure
- [x] Loading states and user feedback

### ✅ Task Management
- [x] Full CRUD operations (Create, Read, Update, Delete)
- [x] Task fields: title, description, due date, status
- [x] Local state management for session data

### ✅ User Experience
- [x] Tabs, filters, and search functionality
- [x] No data states when no tasks available
- [x] Floating Action Button for adding tasks
- [x] Smooth animations for list interactions

### ✅ Polish & Extras
- [x] Pull-to-refresh functionality
- [x] Swipe-to-delete for better UX
- [x] Crash reporting with Sentry integration

## 🔧 Configuration

### Google Sign-In Setup
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing one
3. Enable Google Sign-In API
4. Create OAuth 2.0 credentials
5. Add your app's package name and SHA-1 fingerprint

### Sentry Setup
1. Create a project at [Sentry.io](https://sentry.io/)
2. Get your DSN
3. Replace the placeholder DSN in `lib/main.dart`

## 🧪 Testing

The app includes mock data for demonstration purposes. When you first launch the app and sign in, you'll see sample tasks that showcase all the features.

This project is a part of a hackathon run by https://www.katomaran.com
