// import 'package:conrev/Utils/Utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../Screen/ReportList.dart';
// import '../Utils/url.dart';
// import '../service/api.dart';
// import '../service/cache.dart';

// final reportHelper = ChangeNotifierProvider((ref) => ReportHelper());

// class ReportHelper extends ChangeNotifier {
//   String? notifi;
//   String? filter;
//   String? kw;
//   String? skw;
//   String? todate;
//   String? fromdate;
//   List reportlist = [];
//   void getreport(BuildContext context) async {
//     try {
//       // if (username.text.isEmpty || password.text.isEmpty)
//       // return Utils().toast(msg: 'Please fill all fields');

//       Utils().showLoader(context);

//       String body =
//           '/api/getreport?opt=&opt2=&from_date=&to_date=&keyword=&subkeyword=';
//       String url = URL.base + body;

//       var response = await API().post(url);

//       Utils().dismissLoader(context);
//       print(response['data']);
//       // Utils().toast(msg: response['message']);

//       if (response['data'] != 0) {
//         reportlist = response['data'];
//         print(reportlist.length);
//         Navigator.push(context, MaterialPageRoute(builder: ((context) {
//           return ReportListed();
//         })));
      
//         //  Navigator.pushAndRemoveUntil(
//         //   context,
//         //   MaterialPageRoute(builder: (_) => MainScreen()),
//         //   (route) => false,
//         // );
//       } else {
//           Utils().toast(msg: 'Empty Report');
//         // await Cache().setLogin(true);
//         // Navigator.pushAndRemoveUntil(
//         //   context,
//         //   MaterialPageRoute(builder: (_) => MainScreen()),
//         //   (route) => false,
//         // );
//       }
//     } catch (e) {
//       Utils().dismissLoader(context);
//       Utils().toast(msg: e.toString());
//     }
//   }
// }
