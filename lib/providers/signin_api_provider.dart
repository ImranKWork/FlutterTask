import 'package:flutter/material.dart';
import 'package:flutter_task/api_services/api_services.dart';

class SignInApiProvider extends ChangeNotifier {
  final _service = ApiService();
  bool isLoading = false;
  var _signin_response;
  get signin_response => _signin_response;

  Future<void> signInPostApi(api, peram, context) async {
    isLoading = true;
    notifyListeners();

    final response = await _service.serviceApi(api, "post", peram, context);

    _signin_response = response;
    isLoading = false;
    notifyListeners();
  }
}
