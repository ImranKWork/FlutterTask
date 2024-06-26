import 'package:flutter/material.dart';
import 'package:flutter_task/api_services/api_services.dart';

class LogoutApiProvider extends ChangeNotifier {
  final _service = ApiService();
  bool isLoading = false;
  var _logout_response;
  get logout_response => _logout_response;

  Future<void> logoutPostApi(api, context) async {
    isLoading = true;
    notifyListeners();

    final response = await _service.serviceApi(api, "get", [], context);

    _logout_response = response;
    isLoading = false;
    notifyListeners();
  }
}
