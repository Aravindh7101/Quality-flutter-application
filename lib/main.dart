import 'dart:async';
import 'package:ddbm_application/Pages/homePage.dart';
import 'package:ddbm_application/helper/home_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import 'Pages/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var login = false;
  // await Cache().getLogin();
  Timer.periodic(Duration(seconds: 3), (timer) {
    //  Future.microtask(() => ref.read(homeHelper).getserverdate(context));

    // myFunction();
  });
  runApp(MyApp(isLogin: login ?? false));
}

void myFunction(HomeHelper prov) {
  print('Function triggered!');

  prov.getserverdate();
  // Place your code here to execute every 3 seconds.
}

class MyApp extends StatelessWidget {
  final bool? isLogin;
  const MyApp({Key? key, this.isLogin}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            home: isLogin == true ? MainScreen() : LoginScreen(),
          );
        },
      ),
    );
  }
}
