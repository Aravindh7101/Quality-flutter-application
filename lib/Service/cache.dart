import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  // Constants

  static const String TOKEN = 'access_token';
  static const String LOGIN = "login";
  static const String loginvalue = "loginvalue";

  // static const String? emailId = "EMAILID";

  // Set Cache

  Future<void> setLogin(bool? value) async {
    SharedPreferences? shared = await SharedPreferences.getInstance();
    shared.setBool(LOGIN, value!);
  }

  Future<void> setAccessToken(String? value) async {
    SharedPreferences? shared = await SharedPreferences.getInstance();
    shared.setString(TOKEN, value!);
  }

  Future<void> setAccessvalue(String? value) async {
    SharedPreferences? shared = await SharedPreferences.getInstance();
    shared.setString(loginvalue, value!);
  }

  // Get Cache

  Future<bool?> getLogin() async {
    SharedPreferences? shared = await SharedPreferences.getInstance();
    return shared.getBool(LOGIN);
  }

  Future<String?> getAccessToken() async {
    SharedPreferences? shared = await SharedPreferences.getInstance();
    var token = shared.getString(TOKEN);
    return token;
  }

  Future<String?> getAccessValue() async {
    SharedPreferences? shared = await SharedPreferences.getInstance();
    var logval = shared.getString(loginvalue);
    print(loginvalue + 'ss');

    return logval;
  }
}
