import 'package:ddbm_application/Model/display.model.dart';
import 'package:ddbm_application/Utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Utils/url.dart';
import '../service/api.dart';

final displaytHelper = ChangeNotifierProvider((ref) => DisplayHelper());

class DisplayHelper extends ChangeNotifier {
  DisplayModel? model;

  late TextEditingController description;
  late TextEditingController head;
  late TextEditingController subHead;
  late TextEditingController kName;

  void getdisplay(BuildContext context) async {
    try {
      // if (username.text.isEmpty || password.text.isEmpty)
      // return Utils().toast(msg: 'Please fill all fields');

      Utils().showLoader(context);

      String body = '/api/display';
      String url = URL.base + body;

      var response = await API().get(url);

      // print(_response);

      Utils().dismissLoader(context);

      List l = [];
      List f = [];
      List s = [];
      List p = [];
      List t = [];
      List c = [];

      for (var item in response['data'] ?? []) {
        switch (item["strip"]) {
          case "L":
            l.add(item);
            break;
          case "F":
            f.add(item);
            break;
          case "S":
            s.add(item);
            break;
          case "P":
            p.add(item);
            break;
          case "T":
            t.add(item);
            break;
          case "C":
            c.add(item);
            break;

          default:
        }
      }

      Map<String, dynamic> data = {};

      data['l'] = l;
      data['f'] = f;
      data['s'] = s;
      data['p'] = p;
      data['t'] = t;
      data['c'] = c;

      model = DisplayModel.fromJson(data);

      notifyListeners();

      //  for (var i = 0; i < response['data'].length; i++) {
      //      if ( response['data'][i]['strip']=="P") {
      //        print(response['data'][i]['strip'][i].length);
      //      }
      //   else if(response['data'][i]['strip']=="P") {

      //  }
      //   if () {

      //  } else if() {
      //  } if () {

      //  } else if() {
      //  }
      //   print( response['data'].length);
      //   }
      // Utils().toast(msg: response['data'].length);

      // if (response['message'] == "Entry updated") {
      //   //  Navigator.pushAndRemoveUntil(
      //   //   context,
      //   //   MaterialPageRoute(builder: (_) => MainScreen()),
      //   //   (route) => false,
      //   // );
      // } else {
      //  // await Cache().setLogin(true);
      //   // Navigator.pushAndRemoveUntil(
      //   //   context,
      //   //   MaterialPageRoute(builder: (_) => MainScreen()),
      //   //   (route) => false,
      //   // );
      // }
    } catch (e) {
      Utils().dismissLoader(context);
      Utils().toast(msg: e.toString());
    }
  }

  String getPriorityString(int? priority) {
    switch (priority) {
      case 1:
        return "High";
      case 2:
        return "Medium";
      case 3:
        return "Low";
      default:
        return "No Priority";
    }
  }

  Color getPriorityColor(int? priority) {
    switch (priority) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.yellow.shade900;
      case 3:
        return Colors.green;
      default:
        return Colors.grey.shade600;
    }
  }

  Future<void> deleteEntry(var id, BuildContext context) async {
    try {
      Utils().showLoader(context);

      String body = 'api/delete?e_id=$id';
      String url = URL.base + body;

      var response = await API().post(url);

      // print(_response);

      Utils().dismissLoader(context);
      Utils().toast(msg: 'Deleted');
    } catch (e) {
      Utils().dismissLoader(context);
      Utils().toast(msg: e.toString());
    }
  }

  Future<void> uopdateEntry(var id, BuildContext context) async {
    try {
      Utils().showLoader(context);
      Utils().dismissLoader(context);
    } catch (e) {
      Utils().dismissLoader(context);
      Utils().toast(msg: e.toString());
    }
  }

  Map<String, dynamic> _response = {
    'data': [
      {
        "ent_id": 67,
        "head_id": 33,
        "subhead_id": 35,
        "description": "<p>ok</p>",
        "file": "i56VbbnAJsScreenShot-2022-6-2_22-37-16.png,",
        "name": "abhi",
        "k_id": 1,
        "sk_id": 1,
        "frequency": "D",
        "strip": "P",
        "priority": 2,
        "reminder_stamp": null,
        "insert_date": "2022-09-07",
        "reminder_date": "2022-09-05",
        "status": 1,
        "archive": 0,
        "newdata": "1",
        "datetime": "2022-07-29 04:55:58",
        "h_id": 33,
        "head_name": "sss",
        "sh_id": 35,
        "subhead_name": "hhh",
        "cm_id": null,
        "msg": null,
        "e_id": null,
        "cm_datetime": null,
        "k_name": "nations",
        "sk_name": "sssssssss",
        "sk_datetime": "2022-07-29 06:05:44"
      },
      {
        "ent_id": 67,
        "head_id": 33,
        "subhead_id": 35,
        "description": "<p>ok</p>",
        "file": "i56VbbnAJsScreenShot-2022-6-2_22-37-16.png,",
        "name": "abhi",
        "k_id": 1,
        "sk_id": 1,
        "frequency": "D",
        "strip": "P",
        "priority": 2,
        "reminder_stamp": null,
        "insert_date": "2022-09-07",
        "reminder_date": "2022-09-05",
        "status": 1,
        "archive": 0,
        "newdata": "1",
        "datetime": "2022-07-29 04:55:58",
        "h_id": 33,
        "head_name": "sss",
        "sh_id": 35,
        "subhead_name": "hhh",
        "cm_id": null,
        "msg": null,
        "e_id": null,
        "cm_datetime": null,
        "k_name": "nations",
        "sk_name": "sssssssss",
        "sk_datetime": "2022-07-29 06:05:44"
      },
      {
        "ent_id": 67,
        "head_id": 33,
        "subhead_id": 35,
        "description": "<p>ok</p>",
        "file": "i56VbbnAJsScreenShot-2022-6-2_22-37-16.png,",
        "name": "abhi",
        "k_id": 1,
        "sk_id": 1,
        "frequency": "D",
        "strip": "F",
        "priority": 2,
        "reminder_stamp": null,
        "insert_date": "2022-09-07",
        "reminder_date": "2022-09-05",
        "status": 1,
        "archive": 0,
        "newdata": "1",
        "datetime": "2022-07-29 04:55:58",
        "h_id": 33,
        "head_name": "sss",
        "sh_id": 35,
        "subhead_name": "hhh",
        "cm_id": null,
        "msg": null,
        "e_id": null,
        "cm_datetime": null,
        "k_name": "nations",
        "sk_name": "sssssssss",
        "sk_datetime": "2022-07-29 06:05:44"
      },
      {
        "ent_id": 67,
        "head_id": 33,
        "subhead_id": 35,
        "description": "<p>ok</p>",
        "file": "i56VbbnAJsScreenShot-2022-6-2_22-37-16.png,",
        "name": "abhi",
        "k_id": 1,
        "sk_id": 1,
        "frequency": "D",
        "strip": "F",
        "priority": 2,
        "reminder_stamp": null,
        "insert_date": "2022-09-07",
        "reminder_date": "2022-09-05",
        "status": 1,
        "archive": 0,
        "newdata": "1",
        "datetime": "2022-07-29 04:55:58",
        "h_id": 33,
        "head_name": "sss",
        "sh_id": 35,
        "subhead_name": "hhh",
        "cm_id": null,
        "msg": null,
        "e_id": null,
        "cm_datetime": null,
        "k_name": "nations",
        "sk_name": "sssssssss",
        "sk_datetime": "2022-07-29 06:05:44"
      },
      {
        "ent_id": 67,
        "head_id": 33,
        "subhead_id": 35,
        "description": "<p>ok</p>",
        "file": "i56VbbnAJsScreenShot-2022-6-2_22-37-16.png,",
        "name": "abhi",
        "k_id": 1,
        "sk_id": 1,
        "frequency": "D",
        "strip": "C",
        "priority": 2,
        "reminder_stamp": null,
        "insert_date": "2022-09-07",
        "reminder_date": "2022-09-05",
        "status": 1,
        "archive": 0,
        "newdata": "1",
        "datetime": "2022-07-29 04:55:58",
        "h_id": 33,
        "head_name": "sss",
        "sh_id": 35,
        "subhead_name": "hhh",
        "cm_id": null,
        "msg": null,
        "e_id": null,
        "cm_datetime": null,
        "k_name": "nations",
        "sk_name": "sssssssss",
        "sk_datetime": "2022-07-29 06:05:44"
      },
      {
        "ent_id": 67,
        "head_id": 33,
        "subhead_id": 35,
        "description": "<p>ok</p>",
        "file": "i56VbbnAJsScreenShot-2022-6-2_22-37-16.png,",
        "name": "abhi",
        "k_id": 1,
        "sk_id": 1,
        "frequency": "D",
        "strip": "P",
        "priority": 2,
        "reminder_stamp": null,
        "insert_date": "2022-09-07",
        "reminder_date": "2022-09-05",
        "status": 1,
        "archive": 0,
        "newdata": "1",
        "datetime": "2022-07-29 04:55:58",
        "h_id": 33,
        "head_name": "sss",
        "sh_id": 35,
        "subhead_name": "hhh",
        "cm_id": null,
        "msg": null,
        "e_id": null,
        "cm_datetime": null,
        "k_name": "nations",
        "sk_name": "sssssssss",
        "sk_datetime": "2022-07-29 06:05:44"
      },
      {
        "ent_id": 67,
        "head_id": 33,
        "subhead_id": 35,
        "description": "<p>ok</p>",
        "file": "i56VbbnAJsScreenShot-2022-6-2_22-37-16.png,",
        "name": "abhi",
        "k_id": 1,
        "sk_id": 1,
        "frequency": "D",
        "strip": "T",
        "priority": 2,
        "reminder_stamp": null,
        "insert_date": "2022-09-07",
        "reminder_date": "2022-09-05",
        "status": 1,
        "archive": 0,
        "newdata": "1",
        "datetime": "2022-07-29 04:55:58",
        "h_id": 33,
        "head_name": "sss",
        "sh_id": 35,
        "subhead_name": "hhh",
        "cm_id": null,
        "msg": null,
        "e_id": null,
        "cm_datetime": null,
        "k_name": "nations",
        "sk_name": "sssssssss",
        "sk_datetime": "2022-07-29 06:05:44"
      },
    ],
  };
}
