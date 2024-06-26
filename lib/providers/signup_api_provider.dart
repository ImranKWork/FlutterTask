import 'package:flutter/material.dart';
import 'package:flutter_task/api_services/api_services.dart';

class SignUpApiProvider extends ChangeNotifier {
  final _service = ApiService();
  bool isLoading = false;
  var _signup_response;
  get signup_response => _signup_response;

  Future<void> signupPostApi(api, peram, context) async {
    isLoading = true;
    notifyListeners();

    final response = await _service.serviceApi(api, "post", peram, context);

    _signup_response = response;
    isLoading = false;
    notifyListeners();
  }
}
