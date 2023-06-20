import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  String _token = '';

  String get token => _token;

  set token(String value) {
    _token = value;
    notifyListeners();
  }
}
