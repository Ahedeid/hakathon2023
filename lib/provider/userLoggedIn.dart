import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_model.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  SharedPreferences? _prefs;

  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    final email = _prefs!.getString('email');
    final name = _prefs!.getString('name');
    if (email != null && name != null) {
      _user = User(email: email, name: name);
      notifyListeners();
    }
  }

  Future<bool> login(String email) async {
    const authenticated = true;
    if (authenticated) {
      _user = User(email: email);
      await _prefs!.setString('email', email);
      notifyListeners();
    }
    return authenticated;
  }

  Future<bool> signUp(String email, String name) async {
    const authenticated = true;
    if (authenticated) {
      _user = User(email: email, name: name);
      await _prefs!.setString('email', email);
      await _prefs!.setString('name', name);
      notifyListeners();
    }
    return authenticated;
  }

  void logout() async {
    _user = null;
    await _prefs!.remove('email');
    await _prefs!.remove('name');
    notifyListeners();
  }

  bool get isLoggedIn => _user != null;
  User? get user => _user;
}
