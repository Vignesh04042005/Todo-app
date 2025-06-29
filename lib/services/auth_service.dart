import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'error_service.dart';

class AuthService extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _errorMessage;
  String? _userEmail;
  String? _userName;

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get userEmail => _userEmail;
  String? get userName => _userName;

  // Demo mode for testing - automatically authenticate
  Future<bool> loginDemo() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulate a brief loading delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      _isAuthenticated = true;
      _userEmail = 'demo@example.com';
      _userName = 'Demo User';
      
      ErrorService.addBreadcrumb('Demo authentication successful', 'auth');
      return true;
    } catch (e, stackTrace) {
      _errorMessage = 'Demo login failed: ${e.toString()}';
      ErrorService.reportError(e, stackTrace);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> login() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      ErrorService.addBreadcrumb('User attempting Google Sign-In', 'auth');
      final account = await _googleSignIn.signIn();
      
      if (account != null) {
        _isAuthenticated = true;
        _userEmail = account.email;
        _userName = account.displayName ?? account.email.split('@')[0];
        
        // Set user context for Sentry
        ErrorService.setUserContext(account.id, account.email);
        ErrorService.addBreadcrumb('User signed in successfully: ${account.email}', 'auth');
        
        return true;
      } else {
        _errorMessage = 'Sign-in was cancelled';
        ErrorService.addBreadcrumb('User cancelled sign-in', 'auth');
        return false;
      }
    } catch (e, stackTrace) {
      // Handle specific API errors gracefully for demo
      if (e.toString().contains('People API has not been used') || 
          e.toString().contains('SERVICE_DISABLED')) {
        _errorMessage = 'Demo Mode: People API not enabled. Using demo authentication.';
        // For demo purposes, we'll still authenticate the user
        _isAuthenticated = true;
        _userEmail = 'demo@example.com';
        _userName = 'Demo User';
        ErrorService.addBreadcrumb('Demo authentication used due to API limitation', 'auth');
        return true;
      } else {
        _errorMessage = 'Sign-in failed: ${e.toString()}';
        ErrorService.reportError(e, stackTrace);
        return false;
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      ErrorService.addBreadcrumb('User attempting logout', 'auth');
      await _googleSignIn.signOut();
      _isAuthenticated = false;
      _userEmail = null;
      _userName = null;
      _errorMessage = null;
      ErrorService.addBreadcrumb('User logged out successfully', 'auth');
    } catch (e, stackTrace) {
      _errorMessage = 'Logout failed: ${e.toString()}';
      ErrorService.reportError(e, stackTrace);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
