import 'dart:ffi';

import 'package:ddbm_application/Pages/homePage.dart';
import 'package:ddbm_application/Service/api.dart';
import 'package:ddbm_application/Service/cache.dart';
import 'package:ddbm_application/Utils/Utils.dart';
import 'package:ddbm_application/Utils/url.dart';
import 'package:ddbm_application/custom/custom.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xml/xml.dart';

final homeHelper = ChangeNotifierProvider((ref) => HomeHelper());

class HomeHelper extends ChangeNotifier {
  TextEditingController opId = TextEditingController();
  TextEditingController opName = TextEditingController();
  TextEditingController scanName = TextEditingController();

  TextEditingController splitopId = TextEditingController();
  TextEditingController splitopName = TextEditingController();
  TextEditingController split = TextEditingController();

  TextEditingController target = TextEditingController();

  TextEditingController production = TextEditingController();
  TextEditingController linesection = TextEditingController();
  TextEditingController grade = TextEditingController();
  TextEditingController oprtype = TextEditingController();

  TextEditingController bundleno = TextEditingController();

  var date;
  var servertime;
  var checkservertime;

  var multipledate;

  String ScanData = '';
  String appversion = 'v-1.1';
  String factoryname = 'AIPL 2';

  //FLN
  String _dropvalue='SLS';
  String TypeData = 'Select';
  String check ='G1.0';
  //String check = 'CHECKERS AUDIT REPORT';
  //String sew = 'SEWING INSPECTION REPORT';
  String end = 'END OF LINE REPORT';
  String line = 'Select';
  String Assemblylineselect = 'Select';
  String sectionselect = 'Select';
  String opselect = 'Select';
  String opcodeselect = 'Select';

  String colorselect = 'Select';
  String orderselect = 'Select';
  String jagaselect = 'Select';
  String scannedcount = '0';
  String one ='1';
  String two = '2';
  String three ='3';
  String four ='4';
  var scanCount;

  bool submitstatus = false;

  List scanlist = [
    // 'N309583', 'N309583', 'N309583', 'N309583'
  ];
  List<String> linelist = <String>[
    'Select',
    'k1',
    'RA',
    'S1',
    'S2',
    'S3',
    'S4',
    'S5',
    'S6',
    'S7',
    'S8',
    'S9',
    'S10',
  ];
  List<String> Assemblyline = <String>[
    'Select',
    'CUFF',
    'S10A',
    'S10B',
    'S1A',
    'S1B',
    'S2A',
    'S2B',
    'S3A',
    'S3B',
    'S4A',
    'S4B',
    'S5A',
    'S5B',
    'S6B',
    'S7A',
    'S8A',
    'S8B',
    'S9A',
    'S9B',
  ];
  List<String> ordernolist = <String>['Select'];
  List<String> sectionlist = <String>['Select'];
  List<String> operationlist = <String>['Select'];
  List<String> opcodelist = <String>['Select'];

  List<String> colorlist = <String>['Select'];
  List<String> jagalist = <String>['Select'];

  void clearall() {
    print('object');
    opId.text = '';
    opName.text = '';
    scanName.text = '';
    // date = '';
    scanlist = [];
    opId.text = '';
    opName.text = '';
    scanName.text = '';
    splitopId.text = '';
    splitopName.text = '';
    split.text = '';
    target.text = '';
    production.text = '';
    linesection.text = '';
    grade.text = '';
    oprtype.text = '';
    bundleno.text = '';
    Hour = '1 Hour';
    OtHour = '1';
    //  scanlist=[]
    //  date='';
    //  multipledate='';

    ScanData = '';
    // String appversion = 'v-1.1';

    //FLN
    TypeData = 'Select';
    //first = '1ST BUNDLE APPROVAL';
    check = 'G1.0';
    //sew ='SEWING INSPECTION REPORT';
    end = 'END OF LINE REPORT';
    line = 'Select';
    Assemblylineselect = 'Select';
    sectionselect = 'Select';
    opselect = 'Select';
    opcodeselect = 'Select';
    colorselect = 'Select';
    orderselect = 'Select';
    jagaselect = 'Select';
    submitstatus = false;
    checkservertime = '';
    one ='1';
    two = '2';
    three ='3';
    four ='4';
    // helper.
    notifyListeners();
    getdata();
    checkonlineoroffline();
    getserverHour();
  }

  void clearfield() {
    print('object');
    // opId.text = '';
    // opName.text = '';
    scanName.text = '';
    // date = '';
    scanlist = [];
    // opId.text = '';
    // opName.text = '';
    scanName.text = '';
    splitopId.text = '';
    splitopName.text = '';
    split.text = '';
    target.text = '';
    production.text = '';
    linesection.text = '';
    grade.text = '';
    oprtype.text = '';

    //  date='';
    //  multipledate='';

    ScanData = '';
    // String appversion = 'v-1.1';

    //FLN
    // TypeData = 'Select';
    // line = 'Select';
    // Assemblylineselect = 'Select';
    // sectionselect = 'Select';
    // opselect = 'Select';
    // opcodeselect = 'Select';
    // colorselect = 'Select';
    // orderselect = 'Select';
    // jagaselect = 'Select';
    // helper.
    // getdata();
  }

  String? getAccessValue;
  getdata() async {
    getAccessValue = await Cache().getAccessValue();
    // print(getAccessValue);
    // setState(() {});
    // date = '';
    notifyListeners();
    if (getAccessValue == 'ot') {
      print('prvot');
      Customcolor().blacktheme = Colors.red;
      print(Customcolor().blacktheme);
      getserverHour();
      checkonlineoroffline();
      // Define the static start time as 10:00 AM
      final DateTime startTime = DateTime.now().add(Duration(hours: 10));
      // Get the current time
      DateTime now = DateTime.now();

      List<String> endTimeParts = servertime.split(":");
      DateTime endTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(endTimeParts[0]),
        int.parse(endTimeParts[1]),
      );

      // Check if the current time is before 10:00 AM or after the dynamic end time
      bool isBefore10AMOrAfterEndTime =
          now.isBefore(startTime) || now.isAfter(endTime);
      // print(isBefore10AMOrAfterEndTime);
      // print(servertime);
      if (isBefore10AMOrAfterEndTime == true) {
        getserverdate();
      } else {
        getpreviousotserverdate();
      }
    } else if (getAccessValue == 'admin') {
      print('prv');

      Future.microtask(() => getpreviousserverdate());
    } else {
      // print('datess');
      print('ss:${getAccessValue}');
      Future.microtask(() => getserverdate());
    }
  }

  final bundleqty = '';
  void isSubmit(BuildContext context, Hour) async {
    notifyListeners();

    submitstatus = true;
    print(submitstatus);

    try {
      // isBundleqty(context);
      notifyListeners();

      final request =
          http.Request('POST', Uri.parse(URL.webServiceUrl + '/Bundleqty'));
      request.bodyFields = {
        'barcode': scanName.text,
        'bundleqty': '',
      };
      print(request.bodyFields);
      final response = await http.Client()
          .send(request)
          .timeout(const Duration(seconds: 10));
      final responseBody = await response.stream.bytesToString();
      print(responseBody);
      final document = XmlDocument.parse(responseBody);
      final toElement = document.getElement('string');
      bundleno.text = toElement!.text;
      // .substring(0, toElement.text.length - 1);
      notifyListeners();
      // Utils().toast(msg: toElement?.text);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // onlineStatus = true;

        print("Status Online");
        if (bundleno.text != '0') {
          print('ok');
          notifyListeners();

          final request =
              http.Request('POST', Uri.parse(URL.webServiceUrl + '/LineScan'));
          request.bodyFields = {
            'name1': opId.text,
            'name2': scanName.text,
            'name3': Hour,
            'name4': date,
            'strversion': appversion
          };
          print(request.bodyFields);
          final response = await http.Client()
              .send(request)
              .timeout(const Duration(seconds: 10));
          final responseBody = await response.stream.bytesToString();
          print(responseBody);
          final document = XmlDocument.parse(responseBody);
          final toElement = document.getElement('string');
          Utils()
              .toast(msg: '${toElement?.text},Bundle qty: ${bundleno.text} ');
          notifyListeners();

          bundleno.text = '';
          submitstatus = false;
          notifyListeners();
          clearall();
        } else {
          print('no');
        }
      } else {
        // onlineStatus = false;
        print("Status Offline");
      }

// if(){

// }
      // isBundleqty(context);
      // if (response.statusCode >= 200 && response.statusCode < 300) {

      //   submitstatus = false;
      //   notifyListeners();
      //   print(submitstatus);

      //   print("Status Online");
      // } else {
      //   submitstatus = false;
      //   print("Status Offline");
      // }
    } catch (e) {
      // Utils().dismissLoader(context);
      // Utils().toast(msg: e.toString());
    }
  }

  void fetchoprname(BuildContext context, oprid) async {
    try {
      final request = http.Request(
          'POST', Uri.parse(URL.webServiceUrl + '/Getoprnamedata'));
      request.bodyFields = {'oprname': "", 'oprid': "${URL.oprprefix}-$oprid"};
      print(request.bodyFields);

      final response = await http.Client()
          .send(request)
          .timeout(const Duration(seconds: 10));
      final responseBody = await response.stream.bytesToString();

      final document = XmlDocument.parse(responseBody);
      final toElement = document.getElement('string');
      // print('kk ${toElement}');
      final element = document.findAllElements('string').first;

      // Extract the text content of the element
      final content = element.text;

      if (content.isEmpty) {
        // Value is empty
        // print('Value is empty.');
        Utils().toast(msg: 'Operator is not present in the database');
      } else {
        // Value is not empty
        print('Value is not empty: $content');
      }

      opName.text = toElement!.text.substring(0, toElement.text.length - 1);
      isgetoperationfeatch(context, multipledate);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // onlineStatus = true;

        print("Status Online");
      } else {
        // onlineStatus = false;
        print("Status Offline");
      }
    } catch (e) {
      // Utils().dismissLoader(context);
      // Utils().toast(msg: e.toString());
    }
  }

  void fetchspltoprname(BuildContext context, oprid) async {
    try {
      final request = http.Request(
          'POST', Uri.parse(URL.webServiceUrl + '/Getoprnamedata'));
      request.bodyFields = {'oprname': "", 'oprid': "${URL.oprprefix}-$oprid"};
      print(request.bodyFields);

      final response = await http.Client()
          .send(request)
          .timeout(const Duration(seconds: 10));
      final responseBody = await response.stream.bytesToString();
      print(responseBody);
      print(request);
      final document = XmlDocument.parse(responseBody);
      final toElement = document.getElement('string');
      final element = document.findAllElements('string').first;

      // Extract the text content of the element
      final content = element.text;

      if (content.isEmpty) {
        // Value is empty
        // print('Value is empty.');
        Utils().toast(msg: 'Operator is not present in the database');
      } else {
        // Value is not empty
        print('Value is not empty: $content');
      }
      splitopName.text =
          toElement!.text.substring(0, toElement.text.length - 1);

      // splitopName.text = toElement!.text;
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // onlineStatus = true;

        print("Status Online");
      } else {
        // onlineStatus = false;
        print("Status Offline");
      }
    } catch (e) {
      // Utils().dismissLoader(context);
      // Utils().toast(msg: e.toString());
    }
  }

  void getserverdate() async {
    try {
      final request = http.Request(
          'POST', Uri.parse(URL.webServiceUrl + '/Getcurrentserverdate'));
      request.bodyFields = {
        'curdate': "",
      };
      // print(request.bodyFields);
      final response = await http.Client()
          .send(request)
          .timeout(const Duration(seconds: 10));
      final responseBody = await response.stream.bytesToString();
      // print(responseBody);
      // print(request);
      final document = XmlDocument.parse(responseBody);
      final toElement = document.getElement('string');
      date = toElement?.text;
      // multipledate = toElement?.text;
      print(toElement?.text);
      notifyListeners();

      // .where((element) => element.isNotEmpty)
      // .toList();
      // print(data);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // onlineStatus = true;

        // print("Status Online");
      } else {
        // onlineStatus = false;
        // print("Status Offline");
      }
    } catch (e) {
      // Utils().dismissLoader(context);
      // Utils().toast(msg: e.toString());
    }
  }

  void getserverHour() async {
    try {
      final request =
          http.Request('POST', Uri.parse(URL.webServiceUrl + '/Getservertime'));
      request.bodyFields = {
        'time': "",
      };
      // print(request.bodyFields);
      final response = await http.Client()
          .send(request)
          .timeout(const Duration(seconds: 10));
      final responseBody = await response.stream.bytesToString();
      // print(responseBody);
      // print(request);
      final document = XmlDocument.parse(responseBody);
      final toElement = document.getElement('string');
      servertime = toElement?.text;

      // checkservertime = toElement?.text;
      // multipledate = toElement?.text;
      print(toElement?.text);
      notifyListeners();
// Define the static start time as 10:00 AM
      final DateTime startTime = DateTime.now().add(Duration(hours: 10));

      // Define the dynamic end time as a string
      // final String endTimeString = "17:00";
      // Get the current time
      DateTime now = DateTime.now();

      // Parse the dynamic end time string into a DateTime object
      if (servertime != null) {
        print(servertime);
        List<String> endTimeParts = servertime.split(":");
        DateTime endTime = DateTime(
          now.year,
          now.month,
          now.day,
          int.parse(endTimeParts[0]),
          int.parse(endTimeParts[1]),
        );

        // Check if the current time is before 10:00 AM or after the dynamic end time
        bool isBefore10AMOrAfterEndTime =
            now.isBefore(startTime) || now.isAfter(endTime);
        // print(isBefore10AMOrAfterEndTime);
        // print(servertime);
        if (isBefore10AMOrAfterEndTime == true) {
          Future.microtask(() => getserverdate());
        } else {
          Future.microtask(() => getpreviousotserverdate());
        }
      }
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // onlineStatus = true;

        // print("Status Online");
      } else {
        // onlineStatus = false;
        // print("Status Offline");
      }
    } catch (e) {
      // Utils().dismissLoader(context);
      // Utils().toast(msg: e.toString());
    }
  }

  void checkonlineoroffline() async {
    try {
      final request =
          http.Request('POST', Uri.parse(URL.webServiceUrl + '/Getservertime'));
      request.bodyFields = {
        'time': "",
      };
      // print(request.bodyFields);
      final response = await http.Client()
          .send(request)
          .timeout(const Duration(seconds: 10));
      final responseBody = await response.stream.bytesToString();
      // print(responseBody);
      // print(request);
      final document = XmlDocument.parse(responseBody);
      final toElement = document.getElement('string');
      // servertime = toElement?.text;

      checkservertime = toElement?.text;
      // multipledate = toElement?.text;
      print(toElement?.text);
      notifyListeners();

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // onlineStatus = true;

        // print("Status Online");
      } else {
        // onlineStatus = false;
        // print("Status Offline");
      }
    } catch (e) {
      // Utils().dismissLoader(context);
      // Utils().toast(msg: e.toString());
    }
  }

  void getpreviousserverdate() async {
    try {
      final request = http.Request(
          'POST', Uri.parse(URL.webServiceUrl + '/Getpreviousserverdate'));
      request.bodyFields = {
        'prvdate': "",
      };
      // print(request.bodyFields);
      final response = await http.Client()
          .send(request)
          .timeout(const Duration(seconds: 10));
      final responseBody = await response.stream.bytesToString();
      // print(responseBody);
      // print(request);
      final document = XmlDocument.parse(responseBody);
      final toElement = document.getElement('string');
      print('prv');

      date = toElement?.text;
      // multipledate = toElement?.text;
      print(toElement?.text);
      notifyListeners();

      // .where((element) => element.isNotEmpty)
      // .toList();
      // print(data);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // onlineStatus = true;

        // print("Status Online");
      } else {
        // onlineStatus = false;
        // print("Status Offline");
      }
    } catch (e) {
      // Utils().dismissLoader(context);
      // Utils().toast(msg: e.toString());
    }
  }

  void getpreviousotserverdate() async {
    try {
      final request = http.Request(
          'POST', Uri.parse(URL.webServiceUrl + '/Getpreviousotserverdate'));
      request.bodyFields = {
        'prvot': "",
      };
      // print(request.bodyFields);
      final response = await http.Client()
          .send(request)
          .timeout(const Duration(seconds: 10));
      final responseBody = await response.stream.bytesToString();
      // print(responseBody);
      // print(request);
      final document = XmlDocument.parse(responseBody);
      final toElement = document.getElement('string');
      print('prvot');
      date = toElement?.text;
      // multipledate = toElement?.text;
      print(toElement?.text);
      notifyListeners();

      // .where((element) => element.isNotEmpty)
      // .toList();
      // print(data);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // onlineStatus = true;

        // print("Status Online");
      } else {
        // onlineStatus = false;
        // print("Status Offline");
      }
    } catch (e) {
      // Utils().dismissLoader(context);
      // Utils().toast(msg: e.toString());
    }
  }

  void isfinishingSubmit(BuildContext context) async {
    try {
      final request = http.Request('POST',
          Uri.parse(URL.webServiceUrl + '/finishing_subline_setion_wise'));
      request.bodyFields = {
        'barcode': scanName.text,
        'line': line,
        'type': TypeData,
      };
      print(request.bodyFields);
      final response = await http.Client()
          .send(request)
          .timeout(const Duration(seconds: 10));
      final responseBody = await response.stream.bytesToString();
      print(responseBody);
      final document = XmlDocument.parse(responseBody);
      final toElement = document.getElement('string');
      // date = toElement?.text;
      Utils().toast(msg: toElement?.text);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // onlineStatus = true;

        print("Status Online");
      } else {
        // onlineStatus = false;
        print("Status Offline");
      }
    } catch (e) {
      // Utils().dismissLoader(context);
      // Utils().toast(msg: e.toString());
    }
  }

  void isStylefeatch(BuildContext context) async {
    try {
      final request =
          http.Request('POST', Uri.parse(URL.webServiceUrl + '/Style'));
      request.bodyFields = {
        'styledata': '',
      };
      print(request.bodyFields);
      final response = await http.Client()
          .send(request)
          .timeout(const Duration(seconds: 10));
      final responseBody = await response.stream.bytesToString();
      final document = XmlDocument.parse(responseBody);
      final toElement = document.getElement('string');
      // date = toElement?.text;
      // final items = document.findAllElements('string');
      // ordernolist = items.map((item) => item.text).toList();
      // final items = toElement?.text.split(',');

      // ordernolist.addAll(items!
      //     .where((item) => item.isNotEmpty)
      //     .map((item) => item.trim())
      //     .toSet());
      // ;
      final items = toElement?.text.split(',');
// ChangeNotifier();
      notifyListeners();

      if (toElement != null) {
        final textContent = toElement.text;
        final cleanedContent = textContent.trim();
        if (cleanedContent.isNotEmpty) {
          final items = cleanedContent.split(',');
          ordernolist = ['Select'];
          ordernolist
              .addAll(items.where((item) => item.isNotEmpty).toSet().toList());
          // print(uniqueNonEmptyItems);
        } else {
          // Handle the case where the response is empty.
          print("Response is empty.");
        }
      } else {
        // Handle the case where 'string' element is not found in the XML response.
        print("'string' element not found in the XML response.");
      }

      // items?.map((item) => item?.trim()).toSet().toList() ?? [];
      orderselect = ordernolist[1];
      print(ordernolist);
      print(orderselect);
      notifyListeners();
      isSectionfeatch(context);
      iscolorfeatch(context);
      // return itemList;
      // Utils().toast(msg: toElement?.text);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // onlineStatus = true;

        print("Status Online");
      } else {
        // onlineStatus = false;
        print("Status Offline");
      }
    } catch (e) {
      // Utils().dismissLoader(context);
      // Utils().toast(msg: e.toString());
    }
  }

  void isAssemblySublineLineScanSubmit(BuildContext context) async {
    try {
      Utils().toast(msg: 'Saved Successfully');

      final request = http.Request(
          'POST', Uri.parse(URL.webServiceUrl + '/AssemblySublineLineScan'));
      request.bodyFields = {
        'barcodestr': scanName.text,
        'strdate': date,
        'strline': Assemblylineselect,
      };

      print(request.bodyFields);
      final response = await http.Client()
          .send(request)
          .timeout(const Duration(seconds: 10));

      final responseBody = await response.stream.bytesToString();
      print(responseBody);

      final document = XmlDocument.parse(responseBody);
      final toElement = document.getElement('string');
      // date = toElement?.text;

      // Utils().toast(msg: toElement?.text);
      Utils().toast(msg: 'Saved Successfully');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // onlineStatus = true;

        print("Status Online");
      } else {
        // onlineStatus = false;
        print("Status Offline");
      }
    } catch (e) {
      // Utils().dismissLoader(context);
      // Utils().toast(msg: e.toString());
    }
  }

  //
  void isSectionfeatch(BuildContext context) async {
    // print('objectss');

    try {
      final request = http.Request(
          'POST', Uri.parse(URL.webServiceUrl + '/GetSectionData'));
      request.bodyFields = {'style': orderselect, 'section': ''};
      // print('objectss');

      print(request.bodyFields);
      final response = await http.Client()
          .send(request)
          .timeout(const Duration(seconds: 10));
      final responseBody = await response.stream.bytesToString();
      final document = XmlDocument.parse(responseBody);
      final toElement = document.getElement('string');

      final items = toElement?.text.split(',');
      notifyListeners();

      if (toElement != null) {
        notifyListeners();

        final textContent = toElement.text;
        final cleanedContent = textContent.trim();
        if (cleanedContent.isNotEmpty) {
          final items = cleanedContent.split(',');
          sectionlist = ['Select'];
          sectionlist
              .addAll(items.where((item) => item.isNotEmpty).toSet().toList());
          // print(uniqueNonEmptyItems);
        } else {
          // Handle the case where the response is empty.
          print("Response is empty.");
          sectionselect = '';
          notifyListeners();
        }
      } else {
        // Handle the case where 'string' element is not found in the XML response.
        print("'string' element not found in the XML response.");
      }

      // items?.map((item) => item?.trim()).toSet().toList() ?? [];
      sectionselect = sectionlist[1];
      isoperationfeatch(context);
      print('object');
      print(sectionlist);

      // return itemList;
      // Utils().toast(msg: toElement?.text);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // onlineStatus = true;

        print("Status Online");
      } else {
        // onlineStatus = false;
        print("Status Offline");
      }
    } catch (e) {
      // Utils().dismissLoader(context);
      // Utils().toast(msg: e.toString());
    }
  }

  void iscolorfeatch(BuildContext context) async {
    try {
      final request =
          http.Request('POST', Uri.parse(URL.webServiceUrl + '/GetColordata'));
      request.bodyFields = {
        'styledata': orderselect,
        'color': '',
      };
      print(request.bodyFields);
      final response = await http.Client()
          .send(request)
          .timeout(const Duration(seconds: 10));
      final responseBody = await response.stream.bytesToString();
      final document = XmlDocument.parse(responseBody);
      final toElement = document.getElement('string');
      notifyListeners();

      // final items = toElement?.text.split(',');

      // // Trim and remove any leading/trailing spaces
      // // colorlist = items!.map((item) => item.trim()).toList();
      // if (toElement!.text.isNotEmpty) {
      //   colorlist.addAll(items!
      //       .map((item) => item.trim())
      //       .where((item) => item.isNotEmpty && item.isNotEmpty)
      //       .toSet());
      //   ;
      // }
      final items = toElement?.text.split(',');

      if (toElement != null) {
        final textContent = toElement.text;
        final cleanedContent = textContent.trim();
        if (cleanedContent.isNotEmpty) {
          final items = cleanedContent.split(',');
          colorlist = ['Select'];
          colorlist
              .addAll(items.where((item) => item.isNotEmpty).toSet().toList());
          // print(uniqueNonEmptyItems);
        } else {
          // Handle the case where the response is empty.
          print("Response is empty.");
        }
      } else {
        // Handle the case where 'string' element is not found in the XML response.
        print("'string' element not found in the XML response.");
      }

      // items?.map((item) => item?.trim()).toSet().toList() ?? [];
      colorselect = colorlist[1];
      // print(colorlist);
      print(colorlist);

      // return itemList;
      // Utils().toast(msg: toElement?.text);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // onlineStatus = true;

        print("Status Online");
      } else {
        // onlineStatus = false;
        print("Status Offline");
      }
    } catch (e) {
      // Utils().dismissLoader(context);
      // Utils().toast(msg: e.toString());
    }
  }

  void isoperationfeatch(BuildContext context) async {
    try {
      final request = http.Request(
          'POST', Uri.parse(URL.webServiceUrl + '/GetoperationData'));
      request.bodyFields = {
        'style': orderselect!,
        'section': sectionselect!,
        'operation': '',
      };
      print(request.bodyFields);
      final response = await http.Client()
          .send(request)
          .timeout(const Duration(seconds: 10));
      final responseBody = await response.stream.bytesToString();
      final document = XmlDocument.parse(responseBody);
      final toElement = document.getElement('string');

      // final items = toElement?.text.split(',');

      // operationlist.addAll(items!
      //     .where((item) => item.isNotEmpty)
      //     .map((item) => item.trim())
      //     .toSet());
      // isgetordernofeatch(context, multipledate);
      notifyListeners();

      // print(ordernolist);
      final items = toElement?.text.split(',');

      if (toElement != null) {
        final textContent = toElement.text;
        final cleanedContent = textContent.trim();
        if (cleanedContent.isNotEmpty) {
          final items = cleanedContent.split(',');
          operationlist = ['Select'];
          operationlist
              .addAll(items.where((item) => item.isNotEmpty).toSet().toList());
          // print(uniqueNonEmptyItems);
        } else {
          // Handle the case where the response is empty.
          print("Response is empty.");
        }
      } else {
        // Handle the case where 'string' element is not found in the XML response.
        print("'string' element not found in the XML response.");
      }

      // items?.map((item) => item?.trim()).toSet().toList() ?? [];
      opselect = operationlist[1];

      // return itemList;
      // Utils().toast(msg: toElement?.text);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // onlineStatus = true;

        print("Status Online");
      } else {
        // onlineStatus = false;
        print("Status Offline");
      }
    } catch (e) {
      // Utils().dismissLoader(context);
      // Utils().toast(msg: e.toString());
    }
  }

  void isgetoperationfeatch(BuildContext context, opdate) async {
    print(multipledate);
    try {
      final request =
          http.Request('POST', Uri.parse(URL.webServiceUrl + '/Getoperation'));
      request.bodyFields = {
        'date': opdate,
        'empid': "${URL.oprprefix}-${opId.text}",
        'opreration': '',
      };
      print(request.bodyFields);
      final response = await http.Client()
          .send(request)
          .timeout(const Duration(seconds: 10));
      final responseBody = await response.stream.bytesToString();
      final document = XmlDocument.parse(responseBody);
      final toElement = document.getElement('string');

      final items = toElement?.text.split(',');
      notifyListeners();

      if (toElement != null) {
        final textContent = toElement.text;
        final cleanedContent = textContent.trim();
        if (cleanedContent.isNotEmpty) {
          final items = cleanedContent.split(',');
          operationlist = ['Select'];
          operationlist
              .addAll(items.where((item) => item.isNotEmpty).toSet().toList());
          // print(uniqueNonEmptyItems);
        } else {
          // Handle the case where the response is empty.
          print("Response is empty.");
        }
      } else {
        // Handle the case where 'string' element is not found in the XML response.
        print("'string' element not found in the XML response.");
      }

      // items?.map((item) => item?.trim()).toSet().toList() ?? [];
      opselect = operationlist[1];
      print('opselect');

      print(opselect);
      isgetordernofeatch(context, multipledate);
      // ref
      //   .watch(homeHelper)
      //   .isgetordernofeatch(context, ref.watch(homeHelper).multipledate);

      // orderselect =ordernolist.first;

      print(opselect);
      print('ordernolist');

      // return itemList;
      // Utils().toast(msg: toElement?.text);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // onlineStatus = true;

        print("Status Online");
      } else {
        // onlineStatus = false;
        print("Status Offline");
      }
    } catch (e) {
      // Utils().dismissLoader(context);
      // Utils().toast(msg: e.toString());
    }
  }

  void isgetordernofeatch(BuildContext context, opdate) async {
    print('isgetordernofeatch');
    try {
      final request =
          http.Request('POST', Uri.parse(URL.webServiceUrl + '/Getorderno'));
      request.bodyFields = {
        'date': opdate,
        'empid': "${URL.oprprefix}-${opId.text}",
        'operation': '$opselect',
        'orderno': '',
      };
      print(request.bodyFields);
      final response = await http.Client()
          .send(request)
          .timeout(const Duration(seconds: 10));

      final responseBody = await response.stream.bytesToString();
      final document = XmlDocument.parse(responseBody);
      final toElement = document.getElement('string');

      print(toElement);
      final items = toElement?.text.split(',');
      print('data:$response');

      // Trim and remove any leading/trailing spaces
      // ordernolist = items!.map((item) => item.trim()).toList();
      // ordernolist.addAll(items!
      //     .where((item) => item.isNotEmpty)
      //     .map((item) => item.trim())
      //     .toSet());
      // Set<String> uniqueSet = Set<String>.from(ordernolist);
      // ordernolist = uniqueSet.toList();
      notifyListeners();

      if (toElement != null) {
        final textContent = toElement.text;
        final cleanedContent = textContent.trim();
        if (cleanedContent.isNotEmpty) {
          final items = cleanedContent.split(',');
          ordernolist = ['Select'];
          ordernolist
              .addAll(items.where((item) => item.isNotEmpty).toSet().toList());
          // print(uniqueNonEmptyItems);
        } else {
          // Handle the case where the response is empty.
          print("Response is empty.");
        }
      } else {
        // Handle the case where 'string' element is not found in the XML response.
        print("'string' element not found in the XML response.");
      }

      print('ordernolist');
      print(ordernolist);

      orderselect = ordernolist[1];
      isgetopCodefeatch(context, opdate);
      isgetsjagafeatch(context, opdate);
      isgetsectiononlinetargetfeatch(context, opdate);

      // return itemList;
      // Utils().toast(msg: toElement?.text);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // onlineStatus = true;

        print("Status Online");
      } else {
        // onlineStatus = false;
        print("Status Offline");
      }
    } catch (e) {
      // Utils().dismissLoader(context);
      // Utils().toast(msg: e.toString());
    }
  }

//
  void isgetsectiononlinetargetfeatch(BuildContext context, opdate) async {
    try {
      final request = http.Request(
          'POST', Uri.parse(URL.webServiceUrl + '/Getsectionlinetarget'));
      request.bodyFields = {
        'date': opdate,
        'empid': "${URL.oprprefix}-${opId.text}",
        'orderno': orderselect,
        'operation': opselect,
        'opcode': opcodeselect,
        'output': ''
      };
      print(request.bodyFields);
      final response = await http.Client()
          .send(request)
          .timeout(const Duration(seconds: 10));
      final responseBody = await response.stream.bytesToString();
      final document = XmlDocument.parse(responseBody);
      final toElement = document.getElement('string');

      //  final document = XmlDocument.parse(xmlString);

      // Get the text content of the <string> element
      final stringValue = document.rootElement.text;

      // Split the string by '@@' to extract values
      final values = stringValue.split('@@');

      if (values.length >= 3) {
        linesection.text = values[0];

        target.text = values[1];
        grade.text = values[2];
        oprtype.text = values[3];

        // Use the extracted values as needed
        // print('number: $number, helo: $helo');
      }
      isSubmitGethourproduction(context, Hour, multipledate);

      // return itemList;
      // Utils().toast(msg: toElement?.text);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // onlineStatus = true;

        print("Status Online");
      } else {
        // onlineStatus = false;
        print("Status Offline");
      }
    } catch (e) {
      // Utils().dismissLoader(context);
      // Utils().toast(msg: e.toString());
    }
  }

  void isgetsjagafeatch(BuildContext context, opdate) async {
    print('datas');
    try {
      final request =
          http.Request('POST', Uri.parse(URL.webServiceUrl + '/jaga'));
      request.bodyFields = {
        'date': opdate,
        'empid': "${URL.oprprefix}-${opId.text}",
        'orderno': orderselect,
        'operation': opselect,
        // 'opcode': '',
        'output': ''
      };
      print(request.bodyFields);
      final response = await http.Client()
          .send(request)
          .timeout(const Duration(seconds: 10));
      final responseBody = await response.stream.bytesToString();
      final document = XmlDocument.parse(responseBody);
      final toElement = document.getElement('string');
      if (toElement != null) {
        // final textContent = toElement.text;
        // final cleanedContent = textContent.trim();
        final textContent = toElement.text;

        // Remove all "@" characters
        final cleanedContent = textContent.replaceAll('@@', ',').split(',');

        if (cleanedContent.isNotEmpty) {
          final items = cleanedContent;
          jagalist = ['Select'];
          jagalist
              .addAll(items.where((item) => item.isNotEmpty).toSet().toList());
          // print(uniqueNonEmptyItems);
        } else {
          // Handle the case where the response is empty.
          print("Response is empty.");
        }
      } else {
        // Handle the case where 'string' element is not found in the XML response.
        print("'string' element not found in the XML response.");
      }

      print('jagalist');
      print(jagalist);

      jagaselect = jagalist[1];
      // print(toElement?.text);
      // final items = toElement?.text.split(',');

      // // Trim and remove any leading/trailing spaces
      // // ordernolist = items!.map((item) => item.trim()).toList();
      // jagalist.addAll(items!
      //     .where((item) => item.isNotEmpty)
      //     .map((item) => item.trim())
      //     .toSet());
      // ;

      // print(ordernolist);

      // return itemList;
      // Utils().toast(msg: toElement?.text);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // onlineStatus = true;

        print("Status Online");
      } else {
        // onlineStatus = false;
        print("Status Offline");
      }
    } catch (e) {
      // Utils().dismissLoader(context);
      // Utils().toast(msg: e.toString());
    }
  }

  void isgetopCodefeatch(BuildContext context, opdate) async {
    print('object11');
    try {
      final request =
          http.Request('POST', Uri.parse(URL.webServiceUrl + '/Getopcode'));
      request.bodyFields = {
        'date': opdate,
        'empid': "${URL.oprprefix}-${opId.text}",
        'orderno': orderselect,
        'operation': '$opselect',
        // 'opcode': '',
        'output': ''
      };
      print(request.bodyFields);
      final response = await http.Client()
          .send(request)
          .timeout(const Duration(seconds: 10));
      final responseBody = await response.stream.bytesToString();
      final document = XmlDocument.parse(responseBody);
      final toElement = document.getElement('string');

      print('toElement?.text');

      print(toElement?.text);
      // final items = toElement?.text.split(',');

      // Trim and remove any leading/trailing spaces
      // ordernolist = items!.map((item) => item.trim()).toList();
      // opcodelist.addAll(items!
      //     .where((item) => item.isNotEmpty)
      //     .map((item) => item.trim())
      //     .toSet());
      if (toElement != null) {
        // final textContent = toElement.text;
        // final cleanedContent = textContent.trim();
        final textContent = toElement.text;
        notifyListeners();

        // Remove all "@" characters
        final cleanedContent = textContent.replaceAll('@@', ',').split(',');
        if (cleanedContent.isNotEmpty) {
          final items = cleanedContent;
          opcodelist = ['Select'];
          opcodelist
              .addAll(items.where((item) => item.isNotEmpty).toSet().toList());
          print(opcodelist);
        } else {
          // Handle the case where the response is empty.
          print("Response is empty.");
        }
      } else {
        // Handle the case where 'string' element is not found in the XML response.
        print("'string' element not found in the XML response.");
      }
      opcodeselect = opcodelist[1];

      print(opcodelist);

      // return itemList;
      // Utils().toast(msg: toElement?.text);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // onlineStatus = true;

        print("Status Online");
      } else {
        // onlineStatus = false;
        print("Status Offline");
      }
    } catch (e) {
      // Utils().dismissLoader(context);
      // Utils().toast(msg: e.toString());
    }
  }

  void fetchorderno(BuildContext context, opdate) async {
    try {
      final request =
          http.Request('POST', Uri.parse(URL.webServiceUrl + '/Getorderno'));
      request.bodyFields = {
        'date': opdate,
        'empid': "${URL.oprprefix}-${opId.text}",
        'orderno': orderselect,
        'opreration': '',
        'opcode': '',
        'output': ''
      };
      print(request.bodyFields);

      final response = await http.Client()
          .send(request)
          .timeout(const Duration(seconds: 10));
      final responseBody = await response.stream.bytesToString();
      print(responseBody);
      print(request);
      final document = XmlDocument.parse(responseBody);
      final toElement = document.getElement('string');
      opName.text = toElement!.text;
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // onlineStatus = true;

        print("Status Online");
      } else {
        // onlineStatus = false;
        print("Status Offline");
      }
    } catch (e) {
      // Utils().dismissLoader(context);
      // Utils().toast(msg: e.toString());
    }
  }

  //Manually
  void isgetbarcode(BuildContext context) async {
    try {
      scanName.text = '';
      final request = http.Request(
          'POST', Uri.parse(URL.webServiceUrl + '/Getbarcodedata'));
      request.bodyFields = {
        'barcode': '',
        'style': orderselect,
        'section': sectionselect,
        'operation': opselect,
        'bundleno': bundleno.text
      };
      print(request.bodyFields);
      final response = await http.Client()
          .send(request)
          .timeout(const Duration(seconds: 10));
      final responseBody = await response.stream.bytesToString();
      print(responseBody);
      final document = XmlDocument.parse(responseBody);
      final toElement = document.getElement('string');

      final element = document.findAllElements('string').first;

      // Extract the text content of the element
      final content = element.text;

      if (content.isEmpty) {
        // Value is empty

        print('Value is empty.');
        Utils().toast(msg: 'Barcode is not present in the database');
      } else {
        scanName.text = toElement!.text.substring(0, toElement.text.length - 1);
        notifyListeners();
        // Value is not empty
        print('Value is not empty: $content');
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // onlineStatus = true;

        print("Status Online");
      } else {
        // onlineStatus = false;
        print("Status Offline");
      }
    } catch (e) {
      // Utils().dismissLoader(context);
      // Utils().toast(msg: e.toString());
    }
  }

//bundelno
  void isBundleqty(BuildContext context) async {
    try {} catch (e) {
      // Utils().dismissLoader(context);
      // Utils().toast(msg: e.toString());
    }
  }

  void isSubmitassemblyproductionfordoubleop(
      BuildContext context, Hour, opdate) async {
    // print('sst');
    notifyListeners();

    submitstatus = true;
    try {
      // print('ss');

      final request = http.Request('POST',
          Uri.parse(URL.webServiceUrl + '/assemblyproductionfordoubleop'));
      request.bodyFields = {
        'date': opdate,
        // 'empid': "${URL.oprprefix}-${opId.text}",
        'orderno': orderselect,
        'operation': '$opselect',
        'section': linesection.text,
        'line': jagaselect,
        'oprtrid': '${URL.oprprefix}-${splitopId.text}',
        'target': target.text,
        'hour': Hour,
        'value': split.text,
        'scannedopid': '${URL.oprprefix}-${opId.text}',
        'opcode': opcodeselect,
        'OperationgGrade': grade.text,
        'Machinist': oprtype.text,
        // 'opcode': '',
      };
      print('hello ${request.bodyFields}');
      final response = await http.Client()
          .send(request)
          .timeout(const Duration(seconds: 10));
      // final responseBody = await response.stream.bytesToString();
      // print(responseBody);
      // final document = XmlDocument.parse(responseBody);
      // final toElement = document.getElement('string');
      // date = toElement?.text;
      // Utils().toast(msg: toElement?.text);
      notifyListeners();

      submitstatus = false;

      Utils().toast(msg: 'Saved Successfully');
      clearall();

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // onlineStatus = true;
        notifyListeners();

        submitstatus = false;
        print("Status Online");
      } else {
        notifyListeners();

        submitstatus = false;
        // onlineStatus = false;
        print("Status Offline");
      }
    } catch (e) {
      // Utils().dismissLoader(context);
      // Utils().toast(msg: e.toString());
    }
  }

  //

  void isSubmitGethourproduction(BuildContext context, Hour, opdate) async {
    try {
      final request = http.Request(
          'POST', Uri.parse(URL.webServiceUrl + '/Gethourproduction'));
      request.bodyFields = {
        'date': opdate,
        'empid': "${URL.oprprefix}-${opId.text}",
        'orderno': orderselect,
        'operation': '$opselect',
        'section': linesection.text,
        'line': jagaselect,
        // 'oprtrid': opId.text,
        'target': target.text,
        'hour': Hour,
        // 'value': production.text,
        'production': '',
        'opcode': opcodeselect,
        'OperationgGrade': grade.text,
        'Machinist': oprtype.text,
        'operationtypeserialno': '',
      };
      print('gethourproduction${request.bodyFields}');
      final response = await http.Client()
          .send(request)
          .timeout(const Duration(seconds: 10));
      final responseBody = await response.stream.bytesToString();
      print(responseBody);
      final document = XmlDocument.parse(responseBody);
      final toElement = document.getElement('string');
      production.text = toElement!.text;
      // Utils().toast(msg: toElement?.text);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // onlineStatus = true;

        print("Status Online");
      } else {
        // onlineStatus = false;
        print("Status Offline");
      }
    } catch (e) {
      // Utils().dismissLoader(context);
      // Utils().toast(msg: e.toString());
    }
  }
}
