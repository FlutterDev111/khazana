import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SessionManager {
  static const String _keySession = 'user_session';
  static const String _keyUser = 'user_data';

  // Save session data
  static Future<void> saveSession(Session session) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keySession, jsonEncode({
      'access_token': session.accessToken,
      'refresh_token': session.refreshToken,
      'expires_at': session.expiresAt?.toString(),
    }));
  }

  // Save user data
  static Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUser, jsonEncode({
      'id': user.id,
      'email': user.email,
      'phone': user.phone,
      'created_at': user.createdAt?.toString(),
    }));
  }

  // Get saved session
  static Future<Map<String, dynamic>?> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionStr = prefs.getString(_keySession);
    if (sessionStr != null) {
      final Map<String, dynamic> sessionData = jsonDecode(sessionStr);
      // Convert expires_at string back to DateTime if it exists
      if (sessionData['expires_at'] != null) {
        sessionData['expires_at'] = DateTime.parse(sessionData['expires_at']);
      }
      return sessionData;
    }
    return null;
  }

  // Get saved user
  static Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userStr = prefs.getString(_keyUser);
    if (userStr != null) {
      final Map<String, dynamic> userData = jsonDecode(userStr);
      // Convert created_at string back to DateTime if it exists
      if (userData['created_at'] != null) {
        userData['created_at'] = DateTime.parse(userData['created_at']);
      }
      return userData;
    }
    return null;
  }

  // Clear session data
  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keySession);
    await prefs.remove(_keyUser);
  }

  // Check if session exists
  static Future<bool> hasSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_keySession);
  }
} 