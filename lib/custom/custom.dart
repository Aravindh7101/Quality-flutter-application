import 'package:ddbm_application/Pages/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Customcolor {
  final Color themecolor = Color.fromARGB(255, 1, 128, 232);
  Color logintheme = Color(0xFF591B4C);
  Color blacktheme = getAccessValue == 'ot'
      ? Color.fromARGB(255, 185, 22, 10)
      : Color(0xFF591B4C);
  final Color underlinetheme =
      // Colors.red;
      getAccessValue == 'ot'
          ? Color.fromARGB(255, 255, 60, 46)
          : Colors.deepPurpleAccent;
  //Colors.black87;
  Color theam = getAccessValue == 'ot'
      ? Color.fromARGB(255, 185, 22, 10)
      : Color(0xFF591B4C);
}
