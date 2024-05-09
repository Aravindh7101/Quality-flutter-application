import 'package:ddbm_application/Pages/homePage.dart';
import 'package:ddbm_application/Utils/Utils.dart';
import 'package:ddbm_application/custom/CustomDropdown.dart';
import 'package:ddbm_application/custom/custom.dart';
import 'package:ddbm_application/helper/home_helper.dart';
import 'package:ddbm_application/helper/login_helper.dart';
import 'package:ddbm_application/widgets/qrcodescanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:sizer/sizer.dart';

import '../Service/cache.dart';

const List<String> listedot = <String>[
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
];
const List<String> listed = <String>[
  'Hour1',
  'Hour2',
  'Hour3',
  'Hour4',
  'Hour5',
  'Hour6',
  'Hour7',
  'Hour8',
  'Hour9',
];
// String Hour = 'Hour1';

class Multiple extends ConsumerStatefulWidget {
  const Multiple({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MultipleState();
}

class _MultipleState extends ConsumerState<Multiple> {
  bool _isHidden = true;
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  void initState() {
    getdata();
    ref.read(homeHelper).getserverdate();
    setState(() {});
    Future.microtask(() => ref.read(homeHelper).getserverdate());
    // ref.read(homeHelper).ScanData = ref.read(homeHelper).scanlist.toString();
    // print(ref.read(homeHelper).scanlist);
    // await Cache().mgetAccessValue();
    super.initState();
  }

  // String dropdownValue = list.first;
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
                ref.read(homeHelper).multipledate =
                    "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}";
                print(ref.watch(homeHelper).multipledate);

                //  selectedDate = newDate;
                // ref.watch(homeHelper).date = newDate;
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

  String? mgetAccessValue;
  getdata() async {
    mgetAccessValue = await Cache().getAccessValue();
    // print(mgetAccessValue);
    // setState(() {});
  }

  Widget build(BuildContext context) {
    final helper = ref.read(homeHelper);
    getdata();
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                // margin: EdgeInsets.only(bottom: 30.sp),
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 19, top: 19),
                                      child: Text(
                                        'Date',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w500,
                                            color: const Color.fromARGB(
                                                255, 110, 110, 110)),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(
                                        left: 10, top: 10, right: 8.sp),
                                    // height: 13.w,
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
                                    child: CupertinoButton(
                                      // borderRadius: BorderRadius.circular(50),
                                      onPressed: () {
                                        _selectDate(context);
                                      },
                                      child: Text(
                                        "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Customcolor().blacktheme),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: CustomDropdown(
                            dropdown: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: DropdownButton<String>(
                                value: mgetAccessValue == 'ot' ? OtHour : Hour,
                                iconSize: 0,
                                // icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                style:
                                    TextStyle(color: Customcolor().blacktheme),
                                underline: Container(
                                  height: 2,
                                  color: Customcolor().underlinetheme,
                                ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    Hour = value!;
                                    OtHour = value!;
                                    ref.read(homeHelper).isgetoperationfeatch(
                                        context,
                                        ref.watch(homeHelper).multipledate);
                                  });
                                },
                                items: mgetAccessValue == 'ot'
                                    ? listedot.map<DropdownMenuItem<String>>(
                                        (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList()
                                    : list.map<DropdownMenuItem<String>>(
                                        (String value) {
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
                            lablename: 'Hour',
                            listname: 'Select',
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 19, top: 19),
                    //       child: Text(
                    //         'Operator Info',
                    //         style: TextStyle(
                    //             fontSize: 11.sp,
                    //             fontWeight: FontWeight.w500,
                    //             color:
                    //                 const Color.fromARGB(255, 110, 110, 110)),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    textField(false, helper.opId, 'Operator ID', () {
                      if (helper.opId.text.length == 4) {
                        ref
                            .read(homeHelper)
                            .fetchoprname(context, helper.opId.text.toString());
                        ref.read(homeHelper).isgetoperationfeatch(
                            context, ref.read(homeHelper).multipledate);
                      } else if (helper.opId.text.isEmpty) {
                        helper.opName.text = '';
                        helper.clearfield();
                      } else if (helper.opId.text.length >= 3) {
                        helper.opName.text = '';
                        helper.clearfield();
                      }
                    }, true, false),
                    textField(false, helper.opName, 'Operator Name', () {
                      // print('object');
                    }, false, true),

                    Row(
                      children: [
                        Expanded(
                          child: CustomDropdown(
                            dropdown: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: DropdownButton<String>(
                                value: helper.opcodeselect,
                                iconSize: 0,
                                // icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                style:
                                    TextStyle(color: Customcolor().blacktheme),
                                underline: Container(
                                  height: 2,
                                  color: Customcolor().underlinetheme,
                                ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    helper.opcodeselect = value!;
                                  });
                                },
                                items: helper.opcodelist
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
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
                            lablename: '',
                            listname: 'Select',
                          ),
                        ),
                        Expanded(
                          child: CustomDropdown(
                            dropdown: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: DropdownButton<String>(
                                value: ref.watch(homeHelper).opselect,
                                iconSize: 0,
                                // icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                style:
                                    TextStyle(color: Customcolor().blacktheme),
                                underline: Container(
                                  height: 2,
                                  color: Customcolor().underlinetheme,
                                ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    ref.watch(homeHelper).opselect = value!;
                                    ref.watch(homeHelper).isgetordernofeatch(
                                        context,
                                        ref.watch(homeHelper).multipledate);
                                    // ref
                                    //     .watch(homeHelper)
                                    //     .isSubmitGethourproduction(
                                    //         context,
                                    //         Hour,
                                    //         ref.watch(homeHelper).multipledate);
                                    // print('test');
                                  });
                                },
                                items: ref
                                    .watch(homeHelper)
                                    .operationlist
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
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
                            lablename: 'Operation',
                            listname: 'Select',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomDropdown(
                            dropdown: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: DropdownButton<String>(
                                value: ref.watch(homeHelper).orderselect,
                                iconSize: 0,
                                isExpanded: true,
                                // icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                style:
                                    TextStyle(color: Customcolor().blacktheme),
                                underline: Container(
                                  height: 2,
                                  color: Customcolor().underlinetheme,
                                ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    ref.watch(homeHelper).orderselect = value!;
                                    //  ref.read(homeHelper).isgetoperationfeatch(
                                    //     context,
                                    //     ref.watch(homeHelper).multipledate);
                                    // ref
                                    //     .read(homeHelper)
                                    //     .isSectionfeatch(context);
                                    ref.read(homeHelper).isgetopCodefeatch(
                                        context,
                                        ref.watch(homeHelper).multipledate);
                                    ref.read(homeHelper).isgetsjagafeatch(
                                        context,
                                        ref.watch(homeHelper).multipledate);
                                    ref
                                        .read(homeHelper)
                                        .isgetsectiononlinetargetfeatch(context,
                                            ref.watch(homeHelper).multipledate);
                                    // ref
                                    //     .watch(homeHelper)
                                    //     .iscolorfeatch(context);
                                  });
                                },
                                items: ref
                                    .watch(homeHelper)
                                    .ordernolist
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
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
                            lablename: 'Order No',
                            listname: 'Select',
                          ),
                        ),
                        // Expanded(
                        //     child: Padding(
                        //   padding: const EdgeInsets.only(top: 20.0),
                        //   child:
                        //       textField(false, helper.opName, 'Section', () {}),
                        // )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: textField(false, helper.linesection, 'Section',
                              () {}, false, true),
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: CustomDropdown(
                              dropdown: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 18),
                                child: DropdownButton<String>(
                                  value: helper.jagaselect,
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
                                      helper.jagaselect = value!;
                                    });
                                  },
                                  items: helper.jagalist
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
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
                              lablename: 'Line',
                              listname: 'Select',
                            ),
                          ),
                        ),
                        // Expanded(
                        //     child:
                        //         textField(false, helper.opName, 'Section')),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: textField(false, helper.target, 'Target',
                              () {}, false, true),
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: textField(false, helper.production,
                              'Production', () {}, false, true),
                        ),
                        Expanded(
                            child: textField(false, helper.grade, 'Grade',
                                () {}, false, true)),
                      ],
                    ),
                    Row(
                      children: [
                        // Expanded(
                        //     child:
                        //         textField(false, helper.opName, 'Section')),
                        Expanded(
                            child: textField(false, helper.oprtype, 'Opt Type',
                                () {}, false, true)),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Row(
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 19, top: 19),
                    //       child: Text(
                    //         'Operator Info',
                    //         style: TextStyle(
                    //             fontSize: 11.sp,
                    //             fontWeight: FontWeight.w500,
                    //             color:
                    //                 const Color.fromARGB(255, 110, 110, 110)),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Row(
                      children: [
                        Expanded(
                            child: textField(
                                false, helper.splitopId, 'Operator ID', () {
                          if (helper.splitopId.text.length == 4) {
                            ref.read(homeHelper).fetchspltoprname(
                                context, helper.splitopId.text.toString());
                          } else if (helper.splitopId.text.length >= 3) {
                            helper.splitopName.text = '';
                            // helper.clearfield();
                          } else {
                            // TextEditingController opName = TextEditingController();

                            helper.splitopName.text = '';
                          }
                        }, true, false)),
                        Expanded(child: Builder(builder: (context) {
                          return textField(false, helper.splitopName,
                              'Operator Name', () {}, false, true);
                        })),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: textField(
                                false,
                                helper.split,
                                'Split Production',
                                () {},
                                true,
                                // helper.production.text.isNotEmpty
                                //     ? false
                                //     : true
                                false)),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        next(
                          helper.submitstatus == true
                              ? 'Updating...'
                              : 'Submit',
                          helper.submitstatus == true
                              ? Color.fromARGB(200, 255, 62, 48)
                              : Customcolor().blacktheme,
                          () {
                            if (helper.splitopId.text.isNotEmpty &&
                                helper.splitopName.text.isNotEmpty &&
                                helper.split.text.isNotEmpty &&
                                helper.production.text.isNotEmpty) {
                              helper.isSubmitassemblyproductionfordoubleop(
                                  context,
                                  mgetAccessValue == 'ot' ? OtHour : Hour,
                                  ref.watch(homeHelper).multipledate);
                              selectedDate = DateTime.now();
                            } else {
                              Utils().toast(msg: 'Please Fill the Fields');
                              // print('object');
                            }
                          },
                        ),
                        // next('Submit', Customcolor().blacktheme, () {
                        //   helper.isSubmitassemblyproductionfordoubleop(
                        //       context,
                        //       mgetAccessValue == 'ot' ? OtHour : Hour,
                        //       ref.watch(homeHelper).multipledate);
                        // }),
                        next('Refresh', Customcolor().theam, () {
                          ref.read(homeHelper).clearall();
                          selectedDate = DateTime.now();
                          // ref.read(homeHelper).multipledate =
                          //     "${selectedDate!.day}${selectedDate!.month}/${selectedDate!.year}";
                          setState(() {});
                        }),
                        SizedBox(
                          height: 100,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        // Positioned(
        //   bottom: 30,
        //   child: Column(
        //     children: [
        //       // Text(
        //       //   'Scan BarCode',
        //       //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        //       // ),
        //       Container(
        //         padding: EdgeInsets.all(4),
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(50),
        //           color: Colors.white,
        //           boxShadow: [
        //             BoxShadow(
        //               color: Colors.black26,
        //               spreadRadius: 1,
        //               blurRadius: 5,
        //               offset: Offset(2, 2),
        //             ),
        //           ],
        //         ),
        //         child: Padding(
        //           padding: const EdgeInsets.only(right: 5, bottom: 5),
        //           child: IconButton(
        //             onPressed: () {
        //               Navigator.push(
        //                 context,
        //                 MaterialPageRoute(builder: (_) => QRCodeScanner()),
        //               );
        //             },
        //             icon: Icon(
        //               Icons.qr_code_scanner_rounded,
        //               size: 39,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // )
      ],
    );
  }

  // int.parse(helper.production.text) < 0
  Widget textField(bool secure, TextEditingController controller,
      String placeholder, Function change, bool isNumeric, bool readOnlytext) {
    final helper = ref.read(homeHelper);

    return Column(
      children: [
        // SizedBox(height: 19),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 19, top: 15),
              child: Text(
                placeholder,
                style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 110, 110, 110)),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: 10, top: 9, right: 8.sp),
          padding: EdgeInsets.only(bottom: 2),
          height: 11.w,
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
            keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
            readOnly: readOnlytext,
            controller: controller,
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                change();
              });
              setState(() {});
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

  Widget next(String txt, Color btnclr, Function ontap) {
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
}
