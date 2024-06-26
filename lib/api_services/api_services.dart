import 'dart:convert';
import 'package:flutter_task/comman/widgets.dart';
import 'package:flutter_task/constants/strings.dart';
import 'package:flutter_task/utils/app_preference.dart';
import 'package:flutter_task/utils/prefrence_constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  Future<dynamic> serviceApi(api, type, perams, context) async {
    var token = AppPreference.prefs.getString(pref_accesstoken);

    Map<String, String> headers = {};
    if (token != null && token != "") {
      headers["Authorization"] ="Bearer $token";
    }
    
    headers["Content-Type"] = "application/json";

    var url = "${AppStrings.baseurl}$api";
    final uri = Uri.parse(url);
    var response;
    if (type == "post") {
      var bodyperam = json.encode(perams);
      response = await http.post(uri, body: bodyperam, headers: headers);
    }

    if (type == "get") {
      response = await http.get(uri, headers: headers);
    }
    if (type == "put") {
      response = await http.put(uri, headers: headers);
    }

    if (response.statusCode == 201 || response.statusCode == 200) {
      final json = jsonDecode(response.body);
      var jsonResponse = json as Map<String, dynamic>;

      if (jsonResponse["status"]) {
        return json;
      } else {
        errorbox(context, jsonResponse["message"]);
        return [];
      }
    }
    return [];
  }
}
