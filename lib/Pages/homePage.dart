import 'package:ddbm_application/Pages/assembly.dart';
import 'package:ddbm_application/Pages/enterManually.dart';
import 'package:ddbm_application/Pages/flAllocation.dart';
import 'package:ddbm_application/Pages/helppdfviewer.dart';
import 'package:ddbm_application/Pages/mainpage.dart';
import 'package:ddbm_application/Pages/multiple.dart';
import 'package:ddbm_application/Pages/partspage.dart';
import 'package:ddbm_application/Service/cache.dart';
import 'package:ddbm_application/Utils/Utils.dart';
import 'package:ddbm_application/custom/CustomDropdown.dart';
import 'package:ddbm_application/custom/custom.dart';
import 'package:ddbm_application/helper/home_helper.dart';
import 'package:ddbm_application/helper/login_helper.dart';
import 'package:ddbm_application/widgets/qrcodescanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import '../custom/custom.dart';
import 'package:flutter_svg/flutter_svg.dart' as svg;
import 'Login.dart';
import 'endline Report.dart';

String? getAccessValue;
String Hour = 'SLS';
String OtHour = 'SLS';
//String _dropvalue = 'SLS';

/*const List<String> listot = <String>[
  // 'Select'
  'SLS',
  'FRS',
  'ASM',
  'CFS',
  'BKS',
  'CLS',
  // '6',
  // '7',
  // '8',
];*/
const List<String> list = <String>[
  'Select', 'SLS', 'FRS','ASM','CFS','BKS','CLS'
];
/*const List<String> list = <String>[
  // 'Select',
  'SLS',
  'FRS',
  'ASM',
  'CFS',
  'BKS',
  'CLS',
];*/

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
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

    // ref.read(homeHelper).getserverdate();
    // String dropdownValue = '1 Hour';
    // print(ref.read(homeHelper).scanlist.join(""));
    // ref.read(homeHelper).scanName.text = ref.read(homeHelper).scanlist.join("");
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('DDBM'),
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: Customcolor().blacktheme,
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
                  MaterialPageRoute(builder: (_) => Partspage()),
                  (route) => false,
                );
                // MainBottomsheet(context);
              },
            ),
          ],
          bottom: TabBar(
            // dragStartBehavior: DragStartBehavior.down,
            onTap: (index) {
              setState(() {
                helper.clearall();
                print('object');
                // _tabController.index = 0;
              });
            },
            isScrollable: true,
            tabs: [
              Tab(
                text: 'Home',
              ),
            /*  Tab(
                text: 'Enter Manually',
              ),
              Tab(
                text: 'Multiple',
              ),
              Tab(
                text: 'FNL',
              ),
              Tab(
                text: 'Assembly',
              ), */
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 0.sp),
                                width: double.infinity,
                                // color: Colors.amber,
                                child: Column(
                                    children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 18.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${helper.factoryname}, Licensed to ISSS',
                                          style: TextStyle(
                                              fontSize: 11,
                                              letterSpacing: 1,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                      CustomDropdown(
                                        dropdown: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 18),
                                          child: DropdownButton<String>(
                                            value: helper.TypeData,
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
                                                helper.TypeData = value!;
                                              });
                                            },
                                            items: list
                                                .map<DropdownMenuItem<String>>((String value) {
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
                                        lablename: 'Section',
                                        listname: 'Select',
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 19, top: 19),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 19, top: 19),
                                            child: Text(
                                              'Operator Info',
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color.fromARGB(
                                                      255, 110, 110, 110)),
                                            ),
                                          ),
                                        ],
                                      ),
                                  textField(false, helper.opId, 'Operator ID',
                                      () {
                                    ref.read(homeHelper).fetchoprname(
                                          context,
                                          helper.opId.text.toString(),
                                        );
                                  }, true, false),
                                  textField(
                                      false, helper.opName, 'Operator Name',
                                      () {
                                    // print('object');
                                  }, false, true),
                                  /*Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 19, top: 9),
                                            child: Text(
                                              'Date',
                                              style: TextStyle(
                                                  fontSize: 11.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color.fromARGB(
                                                      255, 110, 110, 110)),
                                            ),
                                          ),
                                          getAccessValue == 'admin' ||
                                                  getAccessValue == 'ot' &&
                                                      ref
                                                              .watch(homeHelper)
                                                              .checkservertime !=
                                                          null &&
                                                      ref
                                                              .watch(homeHelper)
                                                              .checkservertime !=
                                                          ''
                                              //  || 'ot'
                                              ? InkWell(
                                                  onTap: () {
                                                    print(DateTime.now().day);
                                                    setState(() {});

                                                    if (ref
                                                            .read(homeHelper)
                                                            .date ==
                                                        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}") {
                                                      Future.microtask(() => ref
                                                          .read(homeHelper)
                                                          .getpreviousserverdate());
                                                    } else {
                                                      Future.microtask(() => ref
                                                          .read(homeHelper)
                                                          .getserverdate());
                                                      // ref
                                                      //         .read(homeHelper)
                                                      //         .date =
                                                      //     "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
                                                    }

                                                    // '${DateTime.now().day}';
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 28, top: 19),
                                                    child: Text(
                                                      'Reset',
                                                      style: TextStyle(
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Customcolor()
                                                              .blacktheme),
                                                    ),
                                                  ),
                                                )
                                              : Container()
                                        ],
                                      ),
                                      Container(
                                          width: double.infinity,
                                          margin: EdgeInsets.only(
                                              left: 10, top: 5, right: 8.sp),
                                          // height: 13.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                spreadRadius: 1,
                                                blurRadius: 5,
                                                offset: Offset(2, 2),
                                              ),
                                            ],
                                          ),
                                          child: CupertinoButton(
                                            // borderRadius: BorderRadius.circular(50),
                                            onPressed: () {
                                              getAccessValue == 'any'
                                                  ? _selectDate(context)
                                                  : print('date');
                                            },
                                            child: Text(
                                              // "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                                              ref.watch(homeHelper).date == null
                                                  ? ''
                                                  : ref.watch(homeHelper).date,
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      Customcolor().blacktheme),
                                            ),
                                          )),
                                    ],
                                  ), */
                                  //CustomDropdown(
                                    //dropdown:
                                   /* Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18),
                                      child: DropdownButton<String>(
                                        /*value: getAccessValue == 'ot'
                                            ? OtHour
                                            : Hour,*/
                                        value: Hour,
                                        iconSize: 0,
                                        // icon: const Icon(Icons.arrow_downward),
                                        elevation: 16,
                                        style: TextStyle(
                                            color: Customcolor().blacktheme),
                                        underline: Container(
                                          height: 2,
                                          color: Customcolor().underlinetheme,
                                        ),
                                        onChanged: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            Hour = value!;
                                            //OtHour = value;
                                          });
                                        },
                                        items: /*getAccessValue == 'ot'
                                            ? listot
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList()*/
                                            list
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                      ),
                                    ),*/
                                    /*image: Icon(
                                      Icons.filter_alt,
                                      color: Color.fromARGB(255, 138, 88, 247),
                                    ),
                                    listed: list,
                                    lablename: 'Hour',
                                    listname: 'Select',*/
                                 // ),
                                  //textFieldbox(false, 'Scan Box'),
                                ]),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Text('${helper.submitstatus}'),
                                  ElevatedButton(
                                    helper.submitstatus == true
                                        ? 'Ok...'
                                        : 'Ok',
                                    helper.submitstatus == true
                                        ? Color.fromARGB(200, 255, 62, 48)
                                        : Customcolor().blacktheme,
                                    () {
                                      // ref.read(homeHelper).getserverdate(context);
                                      if (helper.opId.text.isEmpty) {
                                        Utils().toast(
                                            msg: 'Please Fill the Fields');
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
                                         /* ref.read(homeHelper).isSubmit(
                                              context,
                                              getAccessValue == 'ot'
                                                  ? OtHour
                                                  : Hour);*/
                                        }
                                      }
                                    },
                                  ),
                                 /* next('Refresh', Customcolor().theam, () {
                                    ref.read(homeHelper).clearall();
                                  }),*/
                                ],
                              ),
                              SizedBox(
                                height: 200,
                              ),
                              Row(
                                children: [
                                  // svg.SvgPicture.asset('Assets/image/logo.svg'),
                                  // Text('data'),
                                ],
                              )
                              // SingleChildScrollView(child: EntryScreen()),
                            ],
                          ),
                        ),
                        /*Positioned(
                          bottom: 30,
                          child: Column(
                            children: [
                              // Text(
                              //   'Scan',
                              //   style:
                              //       TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                              // ),
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 5, bottom: 5),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => QRCodeScanner()),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.qr_code_scanner_rounded,
                                      size: 39,
                                      color: Customcolor().blacktheme,
                                    ),
                                  ),
                                ),
                              ),
                              // Row(
                              //   children: [
                              //     Text(
                              //       helper.appversion + '© 2023, All Rights Reserved to',
                              //       style: TextStyle(
                              //           fontSize: 12, fontWeight: FontWeight.w400),
                              //     ),
                              //     Container(
                              //         height: 4.h,
                              //         width: 10.w,
                              //         child: Image.asset('Assets/image/issslogo.png')),
                              //   ],
                              // )
                            ],
                          ),
                        )*/
                      ]),
                 // EnterManually(),
                 // Multiple(),
                 // FLA(),
                 // Assembly()
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  helper.appversion + '© 2023, All Rights Reserved to ISSS',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                Container(
                    height: 4.h,
                    width: 10.w,
                    child: Image.asset('Assets/image/issslogo.png')),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget textField(bool secure, TextEditingController controller,
      String placeholder, Function change, bool isNumeric, bool disable) {
    final helper = ref.read(homeHelper);

    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 10, top: 2, right: 8.sp),
          padding: EdgeInsets.only(bottom: 4),
          height: 12.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: TextField(
            readOnly: disable,
            keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
            controller: controller,
            // maxLength: 4,
            onChanged: (String? value) {
              // This is called when the user selects an item.
              print(value);
              setState(() {
                if (helper.opId.text.length == 4) {
                  change();
                } else if (helper.opId.text.length >= 3) {
                  helper.opName.text = '';
                  // helper.clearfield();
                } else {
                  // TextEditingController opName = TextEditingController();

                  helper.opName.text = '';
                }
              });
            },
            obscureText: secure == true ? _isHidden : false,
            decoration: InputDecoration(
              suffix: secure == true
                  ? InkWell(
                      onTap: _togglePasswordView,
                      child: Icon(
                        _isHidden ? Icons.visibility : Icons.visibility_off,
                      ),
                    )
                  : null,
              border: InputBorder.none,
              hintText: placeholder,
              hintStyle: TextStyle(
                color: Color(0xffABB4BD),
                fontFamily: 'Gilroy',
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
              contentPadding: EdgeInsets.only(
                right: 20,
                left: 20,
                top: secure == true ? 7 : 19,
                bottom: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget textFieldbox(bool secure, String placeholder) {
    final helper = ref.read(homeHelper);
    Set<String> scannedSet = Set();
    return Column(
      children: [
        // SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 10, top: 6, right: 8.sp),
          height: 15.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(2, 2), // changes position of shadow
              ),
            ],
          ),
          child: TextField(
              // readOnly: true,
              autofocus: true,
              // keyboardType: TextInputType.,
              // keyboardType: TextInputType.number,
              // textInputAction: TextInputAction.next,
              enabled: true,
              focusNode: _focusNode,
              onChanged: (value) {
                String text = helper.scanName.text;
                List<String> lines = text.split('\n');

                print(lines.length);
                helper.scanlist.length = lines.length - 1;
                setState(() {});
                print(helper.scanlist.length);
              },
              maxLines: 1000,
              controller: helper.scanName,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: placeholder,
                hintStyle: TextStyle(
                    color: Color(0xffABB4BD),
                    fontFamily: 'Gilroy',
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
                contentPadding: EdgeInsets.only(left: 10, top: 18),
                //  suffixIcon:  Image.asset("Assets/Images/searchright.png",
              )),
        ),
      ],
    );
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

  MainBottomsheet(
    BuildContext context,
  ) {
    //  final typestate = ref.watch(getprofileproduct);
    return showModalBottomSheet(
      isScrollControlled: true,
      //   enableDrag: true,
      //   expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          //  margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
              bottomLeft: Radius.zero,
              bottomRight: Radius.zero,
            ),
          ),

          //height: 75.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                      height: 5,
                      width: 10.w,

                      margin: EdgeInsets.symmetric(vertical: 8.sp),
                      //child:
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  // height: 80,
                  //  color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'DDBM',
                        style: TextStyle(
                            letterSpacing: 1,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Gilroy",
                            fontSize: 17.sp,
                            color: Color.fromARGB(255, 65, 10, 82)),
                      )
                      //  Container(
                      //    margin: EdgeInsets.all(10),
                      //    width: 95.w,
                      //    child:
                      //  ),
                    ],
                  ),
                ),
                Divider(),
                GestureDetector(
                  onTap: () async {
                    Navigator.pop(context);
                    await Cache().setLogin(false);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => LoginScreen()),
                      (route) => false,
                    );
                    // Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 11.sp),
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        letterSpacing: 1,
                        fontFamily: 'Gilroy',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff1A1A1A),
                      ),
                    ),
                  ),
                ),
                Divider(thickness: 1),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);

                    // Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 11.sp),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        letterSpacing: 1,
                        fontFamily: 'Gilroy',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff1A1A1A),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10)
              ])
            ],
          ),
        ),
      ),
    );
  }
}
