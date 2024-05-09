import 'package:ddbm_application/Pages/homePage.dart';
import 'package:ddbm_application/Pages/mainpage.dart';
import 'package:ddbm_application/Pages/searchbar.dart';
import 'package:ddbm_application/Pages/sewing%20report.dart';
import 'package:ddbm_application/Utils/Utils.dart';
import 'package:ddbm_application/custom/CustomDropdown.dart';
import 'package:ddbm_application/custom/custom.dart';
import 'package:ddbm_application/helper/login_helper.dart';
import 'package:ddbm_application/widgets/qrcodescanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Service/cache.dart';
import '../helper/home_helper.dart';
import 'Checkers.dart';
import 'Login.dart';
import 'endline Report.dart';
import 'firstbundle.dart';
import 'helppdfviewer.dart';

const List<String> list = <String>[
  'END OF LINE REPORT',
  'SEWING INSPECTION REPORT',
  'CHECKERS AUDIT REPORT',
  '1ST BUNDLE APPROVAL'
];

class Partspage extends ConsumerStatefulWidget {
  const Partspage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Partspage();
}

class _Partspage extends ConsumerState<Partspage> {
  bool _isHidden = true;
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  FocusNode _focusNode = FocusNode();

  DateTime? selectedDate = DateTime.now(); // Declare as nullable

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          height: 210.0,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: selectedDate ?? DateTime.now(),
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                selectedDate = newDate;
                ref.watch(homeHelper).date =
                    "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}";
                // print(ref.watch(homeHelper).date);
              });
            },
          ),
        );
      },
    );

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  getdata() async {
    getAccessValue = await Cache().getAccessValue();
    // print(getAccessValue);
    // setState(() {});
    if (getAccessValue == 'ot') {
      print('prvot');
      Customcolor().blacktheme = Colors.red;
      print(Customcolor().blacktheme);
      Future.microtask(() => ref.read(homeHelper).getserverHour());
      Future.microtask(() => ref.read(homeHelper).checkonlineoroffline());

      // // Define the static start time as 10:00 AM
      // final DateTime startTime = DateTime.now().add(Duration(hours: 10));

      // // Define the dynamic end time as a string
      // // final String endTimeString = "17:00";
      // // Get the current time
      // DateTime now = DateTime.now();

      // // Parse the dynamic end time string into a DateTime object
      // if (ref.read(homeHelper).servertime != null) {
      //   print(ref.read(homeHelper).servertime);
      //   List<String> endTimeParts = ref.read(homeHelper).servertime.split(":");
      //   DateTime endTime = DateTime(
      //     now.year,
      //     now.month,
      //     now.day,
      //     int.parse(endTimeParts[0]),
      //     int.parse(endTimeParts[1]),
      //   );

      //   // Check if the current time is before 10:00 AM or after the dynamic end time
      //   bool isBefore10AMOrAfterEndTime =
      //       now.isBefore(startTime) || now.isAfter(endTime);
      //   // print(isBefore10AMOrAfterEndTime);
      //   // print(ref.read(homeHelper).servertime);
      //   if (isBefore10AMOrAfterEndTime == true) {
      //     Future.microtask(() => ref.read(homeHelper).getserverdate());
      //   } else {
      //     Future.microtask(
      //         () => ref.read(homeHelper).getpreviousotserverdate());
      //   }
      // }
    } else if (getAccessValue == 'admin') {
      print('prv');

      Future.microtask(() => ref.read(homeHelper).getpreviousserverdate());
    } else {
      // print('datess');
      print('ss:${getAccessValue}');
      Future.microtask(() => ref.read(homeHelper).getserverdate());
    }
  }

  @override
  void initState() {
    Future.microtask(() => ref.read(homeHelper).getserverHour());
    Future.microtask(() => ref.read(homeHelper).checkonlineoroffline());

    getdata();
    // ref.read(homeHelper).getserverdate();
    setState(() {});

    // Future.microtask(() => ref.read(homeHelper).getserverdate());
    // Future.microtask(() => ref.read(homeHelper).getpreviousserverdate());
    // Future.microtask(() => ref.read(homeHelper).getpreviousotserverdate());

    // ref.read(homeHelper).ScanData = ref.read(homeHelper).scanlist.toString();
    // print(ref.read(homeHelper).scanlist);
    // await Cache().getAccessValue();
    Future.delayed(const Duration(seconds: 2), () {
      // Your code here - this function will be executed after 2 seconds.
      print("Delayed function executed!");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final helper = ref.read(homeHelper);

    return Scaffold(
      appBar: AppBar(
        title: Text('Parts page'),
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.redAccent,
        actions: [
          ref.watch(homeHelper).checkservertime != null &&
              ref.watch(homeHelper).checkservertime != ''
              ? Row(
            children: [
              Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(100)),
              ),
              Text(' Online')
            ],
          )
              : Row(
            children: [
              Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(100)),
              ),
              Text(' Offline')
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text(
                  helper.scanlist.length == 0
                      ? ''
                      : helper.scanlist.length.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w500),
                )),
          ),
          // IconButton(
          //   icon: Icon(
          //     Icons.refresh,
          //     size: 20,
          //   ),
          //   color: Colors.white,
          //   onPressed: () {
          //     ref.read(homeHelper).clearall();
          //     // .getserverdate();
          //     // await Cache().setLogin(false);
          //     // Navigator.pushAndRemoveUntil(
          //     //   context,
          //     //   MaterialPageRoute(builder: (_) => LoginScreen()),
          //     //   (route) => false,
          //     // );
          //     // MainBottomsheet(context);
          //   },
          // ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => HelpPage()),
                );
              },
              child: Icon(
                Icons.help,
                size: 20,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.logout,
              size: 20,
            ),
            color: Colors.white,
            onPressed: () async {
              await Cache().setLogin(false);
              helper.clearall();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => Mainpage()),
                    (route) => false,
              );
              // MainBottomsheet(context);
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomDropdown(
            dropdown: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: DropdownButton<String>(
                value: helper.end,
                iconSize: 0,
                // icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: TextStyle(color: Customcolor().blacktheme),
                underline: Container(
                  height: 2,
                  color: Customcolor().underlinetheme,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    helper.end = value!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            image: Icon(
              Icons.filter_alt,
              color: Color.fromARGB(255, 138, 88, 247),
            ),
            listed: list,
            lablename: 'Types Of Report',
            listname: 'Select',
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text('${helper.submitstatus}'),
              ElevatedButton(
                helper.submitstatus == true ? 'Ok...' : 'Ok',
                helper.submitstatus == true
                    ? Color.fromARGB(200, 255, 62, 48)
                    : Customcolor().blacktheme,
                () {
                  if (helper.end == 'END OF LINE REPORT') {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MainScreen()));
                  } else if (helper.end == 'SEWING INSPECTION REPORT') {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SewingPage()));
                  } else if (helper.end == 'CHECKERS AUDIT REPORT') {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Checker()));
                  } else if (helper.end == '1ST BUNDLE APPROVAL') {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => First()));
                  }
                  /*if (helper.TypeData == 'Select') {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Partspage()));
                    /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainScreen(),
                        ));*/
                  }*/
                  }
                  // ref.read(homeHelper).getserverdate(context);
                  /*if (helper.opId.text.isEmpty) {
                    Utils().toast(msg: 'Please Fill the Fields');
                    /*else if (helper.scanName.text.isEmpty) {
                                        Utils()
                                            .toast(msg: 'Please Scan the Data'); */
                  } else {
                    if (helper.submitstatus == false) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Endlinereport(),
                          ));
                    }
                  }*/
              ),
            ],
          ),
          /*ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                if (list == 'END OF LINE REPORT') {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MainScreen()));
                } else if (list == 'SEWING INSPECTION REPORT') {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Endlinereport()));
                } else if (list == 'CHECKERS AUDIT REPORT') {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Endlinereport()));
                } else if (list == '1ST BUNDAL APPROVAL') {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Endlinereport()));
                }
              })*/
        ],
      ),
    );
  }
}

Widget ElevatedButton(String txt, Color btnclr, Function ontap) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: MaterialButton(
      onPressed: () => ontap(),
      // () {
      //   ref.read(homeHelper).getserverdate(context);

      //   ref.read(homeHelper).isSubmit(context, Hour);
      // },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        child: Text(
          txt,
          style: TextStyle(
            color: btnclr,
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            // letterSpacing: .5,
          ),
        ),
      ),
      // minWidth: 100.w,
      elevation: 5,
      color: Colors.white,

      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(50.0)),
      ),
    ),
  );
}
