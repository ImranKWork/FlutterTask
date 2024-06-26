import 'package:flutter/material.dart';
import 'package:flutter_task/api_services/api_services.dart';

class HomeApiProvider extends ChangeNotifier {
  final _service = ApiService();
  bool isLoading = false;
  var _home_response;
  get home_response => _home_response;

  Future<void> homePostApi(api, context) async {
    isLoading = true;
    notifyListeners();

    final response = await _service.serviceApi(api, "get", [], context);
    var jsonResponse = response as Map<String, dynamic>;
    _home_response = jsonResponse["userList"];
    isLoading = false;
    notifyListeners();
  }
}
