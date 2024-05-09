import 'package:ddbm_application/Pages/homePage.dart';
import 'package:ddbm_application/Service/api.dart';
import 'package:ddbm_application/Service/cache.dart';
import 'package:ddbm_application/Utils/Utils.dart';
import 'package:ddbm_application/Utils/url.dart';
import 'package:ddbm_application/custom/custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Pages/mainpage.dart';

final loginHelper = ChangeNotifierProvider((ref) => LoginHelper());

class LoginHelper extends ChangeNotifier {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  void login(BuildContext context) async {
    try {
      if (username.text.isNotEmpty && password.text.isNotEmpty) {
        if (username.text == 'isss' && password.text == 'isss') {
          print('ot');
          await Cache().setAccessvalue('ot');
          // Customcolor().blacktheme = Colors.red;
          Navigator.pushAndRemoveUntil(
            context,
            // MaterialPageRoute(builder: (_) => MainScreen()),
            MaterialPageRoute(builder: (_) => Mainpage()),
            (route) => false,
          );
        } else if (username.text == 'isss' && password.text == 'isss') {
          print('admin');
          await Cache().setAccessvalue('admin');
          // print(await Cache().getAccessValue());
          /*showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('previous day'),
              content:
                  const Text('Are you sure you want to scan for previous day'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => MainScreen()),
                      (route) => false,
                    )
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );*/
        } else if (username.text == 'admin' && password.text == 'admin@123') {
          print('user');
          await Cache().setAccessvalue('user');
          Navigator.pushAndRemoveUntil(
            context,
            // MaterialPageRoute(builder: (_) => MainScreen()),
            MaterialPageRoute(builder: (_) => Mainpage()),
            (route) => false,
          );
        } else if (username.text == 'admin' && password.text == 'admin@any') {
          print('any');
          await Cache().setAccessvalue('any');
          Navigator.pushAndRemoveUntil(
            context,
            // MaterialPageRoute(builder: (_) => MainScreen()),
            MaterialPageRoute(builder: (_) => Mainpage()),
            (route) => false,
          );
        } else {
          Utils().toast(msg: 'Please fill the required field Correctly');
        }
      } else if (username.text.isEmpty || password.text.isEmpty) {
        Utils().toast(msg: 'Please fill the required field');

        // showToast('Please fill the required field');
      }
      // final request =
      //     http.Request('POST', Uri.parse(URL.webServiceUrl + '/GetLine'));
      // request.bodyFields = {'getmcline': '', 'inputmclocation': ''};

      // final response = await http.Client()
      //     .send(request)
      //     .timeout(const Duration(seconds: 10));
      // final responseBody = await response.stream.bytesToString();

      // if (response.statusCode >= 200 && response.statusCode < 300) {
      //   // onlineStatus = true;

      //   print("Status Online");
      // } else {
      //   // onlineStatus = false;
      //   print("Status Offline");
      // }
      // if (username.text.isEmpty || password.text.isEmpty)
      //   return Utils().toast(msg: 'Please fill all fields');

      // Utils().showLoader(context);

      // String body = 'username=${username.text}&password=${password.text}';
      // String url = URL.login + body;

      // String token = API().createAccessToken(
      //   username: "Admin",
      //   password: "Abcd1234",
      // );

      // await Cache().setAccessToken(token);

      // var response = await API().post(url);

      // Utils().dismissLoader(context);

      // Utils().toast(msg: response['message']);

      // if (response['message'] == "Invalid login") {

      // } else {
      // await Cache().setAccessvalue(true);

      // }
    } catch (e) {
      Utils().dismissLoader(context);
      Utils().toast(msg: e.toString());
    }
  }
}
