import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  String _name = '';
  String _password = '';
  bool _isLogon = false;

  void logon(String name, String password) {
    _name = name;
    _password = password;
    _isLogon = true;
    notifyListeners();
  }

  bool get isLogon => _isLogon;
  String get name => _name;
  String get password => _password;
}
