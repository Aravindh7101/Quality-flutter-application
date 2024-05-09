import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  void toast({String? msg}) {
    Fluttertoast.showToast(msg: msg ?? "");
  }

  showLoader(context) {
    showDialog(
      barrierDismissible: false,
      useRootNavigator: false,
      context: context,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 50),
            Text("Please wait ...."),
          ],
        ),
      ),
    );
  }

  dismissLoader(context) => Navigator.of(context).pop();
}
