// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:path/path.dart';

// import '../Utils/url.dart';
// import '../service/api.dart';
// import '../service/cache.dart';

// final entryHelper = ChangeNotifierProvider((ref) => EntryHelper());

// class EntryHelper extends ChangeNotifier {
//   TextEditingController head = TextEditingController();
//   TextEditingController sub = TextEditingController();
//   TextEditingController name = TextEditingController();
//   TextEditingController Kw = TextEditingController();
//   TextEditingController Swk = TextEditingController();
//   TextEditingController Description = TextEditingController();
//   validation(context) {
//     if (head.text.isEmpty ||
//         sub.text.isEmpty ||
//         Description.text.isEmpty ||
//         name.text.isEmpty)
//       return Utils().toast(msg: 'Please fill all fields');
//     else {
//       // Navigator.push(context, MaterialPageRoute(builder: ((context) {
//       //   return EntryNextScreen(restorationId: 'main');
//       // })));
//     }
//   }

//   String? date = DateTime.now().toString();
//   List file = [];
//   String? Strip = 'P';
//   String? freq = 'D';
//   String? notif = 'M';
//   String? priority;
//   void getEntry(BuildContext context) async {
//     String url = 'https://conrev.in/CRV/api/insert';

//     final List added = [];
//     var image;

//     for (var i = 0; i < file.length; i++) {
//       //     String filename0= basename(ref.read( productupload).tumbnail!.path);
//       //  image = MultipartFile.fromFile(ref.read(productupload).tumbnail!.path, filename: filename0);
//       added.add(
//         await MultipartFile.fromFile(file[i].path,
//             filename: basename(file[i].path)),
//       );
//     }
//     try {
//       var formData = FormData.fromMap({
//         "head": head.text,
//         "subhead": sub.text,
//         "stamp": notif.toString(),
//         "entry": Description.text,
//         "strip": Strip.toString(),
//         "freq": freq.toString(),
//         "s_date": date.toString(),
//         "priority": priority.toString(),
//         "esubkeyword": Swk.text,
//         "ekeyword%5B%5D": Kw.text,
//         "file": added,
//         "name": name.text
//       });
// // print(formData.files);
// // print('object');
// // print(formData.fields);
//       var response = await Dio().post(url, data: formData);
//       print('object');
//       print('hello${response.statusCode}');
//       // ignore: unused_local_variable

//       if (response.statusCode == 200) {
//         Utils().toast(msg: response.data['message']);
//         // Navigator.pop(context);
//         head.text = '';
//         sub.text = '';
//         Description.text = '';
//         name.text = '';
//         Kw.text = '';
//         Swk.text = '';
//         file = [];
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (_) => MainScreen()),
//           (route) => false,
//         );
//       } else {
//         print('could not be uploaded');
//       }
//     } catch (e) {
//       Utils().toast(msg: e.toString());
//       print(e);
//     }

// //     try {
// //       // if (username.text.isEmpty || password.text.isEmpty)
// //         // return Utils().toast(msg: 'Please fill all fields');
// // print('/api/insert?head=${head.text}&subhead=${sub.text}&stamp=${notif}&entry=${Description.text}&strip=${Strip}&freq=${freq}&s_date=$date&priority=${priority}&esubkeyword=${Swk.text}&ekeyword%5B%5D=${Kw.text}&file=${file}');
// //    //   Utils().showLoader(context);

// //       // String body = '/api/insert?head=${head.text}&subhead=${sub.text}&stamp=${notif}&entry=${Description.text}&strip=${Strip}&freq=${freq}&s_date=$date&priority=${priority}&esubkeyword=${Swk.text}&ekeyword%5B%5D=${Kw.text}&file=${file}';
// //       // String url = URL.base + body;

// //       // String token = API().createAccessToken(
// //       //   username: "Admin",
// //       //   password: "Abcd1234",
// //       // );

// //       // await Cache().setAccessToken(token);

// //       // var response = await API().post(url);

// //       // Utils().dismissLoader(context);

// //       //  Utils().toast(msg: response['message']);

// //       // if (response['message'] == "Entry inserted") {
// //       //   head.text ='';
// //       //   sub.text='';
// //       //    Description.text ='';
// //       //     name.text='';
// //       //     Kw.text='';
// //       //     Swk.text='';
// //       //             Navigator.pop(context);
// //       //   //  Navigator.pushAndRemoveUntil(
// //       //   //   context,
// //       //   //   MaterialPageRoute(builder: (_) => MainScreen()),
// //       //   //   (route) => false,
// //       //   // );
// //       // } else {
// //       //  // await Cache().setLogin(true);
// //       //   // Navigator.pushAndRemoveUntil(
// //       //   //   context,
// //       //   //   MaterialPageRoute(builder: (_) => MainScreen()),
// //       //   //   (route) => false,
// //       //   // );
// //       // }
// //     } catch (e) {
// //       Utils().dismissLoader(context);
// //       Utils().toast(msg: e.toString());
// //     }
//   }
// }
