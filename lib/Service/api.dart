import 'dart:convert';
import 'package:ddbm_application/Service/cache.dart';
import 'package:http/http.dart' as http;

class API {
  String createAccessToken({String? username, String? password}) {
    String basicAuth = base64.encode(utf8.encode('$username:$password'));
    return 'Basic $basicAuth';
  }

  Future get(String url) async {
    try {
      Uri uri = Uri.parse(url);
      String? basicAuth = await Cache().getAccessToken();

      Map<String, String> headers = {"Authorization": "$basicAuth"};

      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        throw Exception('Invalid Authurization');
      } else {
        throw Exception('Failed to get Data');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future post(String url) async {
    try {
      Uri uri = Uri.parse(url);
      String? basicAuth = await Cache().getAccessToken();
      Map<String, String> headers = {"Authorization": "$basicAuth"};
      var response = await http.post(uri, headers: headers);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        throw Exception('Invalid Authurization');
      } else {
        throw Exception('Failed to get Data');
      }
    } catch (e) {
      rethrow;
    }
  }
}
