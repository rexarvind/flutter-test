import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';

class AuthService {
  final StreamController<bool> _userStreamController = StreamController<bool>.broadcast();
  Stream<bool> get userStream => _userStreamController.stream;

  final String baseUrl = kApiBase;

  // Store the user's authentication token
  String? authToken;

  // Initialize the AuthService
  AuthService() {
    // Check if the user is initially authenticated (e.g., from a stored token)
    // You can implement token-based authentication as needed
    // Example:
    // authToken = getStoredToken();
    // _userStreamController.add(authToken != null);
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        authToken = responseData['token']; // Store the authentication token
        _userStreamController.add(true); // User is authenticated
      } else {
        throw Exception('Login failed');
      }
    } catch (error) {
      print('Error during login: $error');
      throw error;
    }
  }

  Future<void> logout() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken', // Include the token for authentication
        },
      );

      if (response.statusCode == 200) {
        authToken = null; // Clear the authentication token
        _userStreamController.add(false); // User is not authenticated
      } else {
        throw Exception('Logout failed');
      }
    } catch (error) {
      print('Error during logout: $error');
      throw error;
    }
  }

  // Add other authentication-related methods as needed (e.g., registration)

  // Cleanup: Close the userStreamController when no longer needed
  void dispose() {
    _userStreamController.close();
  }
}
