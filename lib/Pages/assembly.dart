import 'package:ddbm_application/Utils/Utils.dart';
import 'package:ddbm_application/custom/CustomDropdown.dart';
import 'package:ddbm_application/custom/custom.dart';
import 'package:ddbm_application/helper/home_helper.dart';
import 'package:ddbm_application/widgets/qrcodescanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class Assembly extends ConsumerStatefulWidget {
  const Assembly({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AssemblyState();
}

class _AssemblyState extends ConsumerState<Assembly> {
  String dropdownValue = list.first;
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
                ref.read(homeHelper).date =
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

  @override
  Widget build(BuildContext context) {
    final helper = ref.read(homeHelper);

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 19, top: 19),
                        child: Text(
                          'Assembly Date',
                          style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 110, 110, 110)),
                        ),
                      ),
                      // Padding(
                      //   padding:
                      //       const EdgeInsets.only(right: 28, top: 19),
                      //   child: Text(
                      //     'Reset',
                      //     style: TextStyle(
                      //         fontSize: 11.sp,
                      //         fontWeight: FontWeight.w500,
                      //         color:
                      //             Color.fromARGB(255, 10, 46, 204)),
                      //   ),
                      // ),
                    ],
                  ),
                  Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 10, top: 10, right: 8.sp),
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
                          // getAccessValue == 'any'
                          //     ? _selectDate(context)
                          //     : print('date');
                        },
                        child: Text(
                          "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                          // ref.watch(homeHelper).multipledate == null
                          //     ? ''
                          //     : ref.watch(homeHelper).multipledate,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Customcolor().blacktheme),
                        ),
                      )),
                ],
              ),
              CustomDropdown(
                dropdown: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: DropdownButton<String>(
                    value: helper.Assemblylineselect,
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
                        helper.Assemblylineselect = value!;
                      });
                    },
                    items: helper.Assemblyline.map<DropdownMenuItem<String>>(
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
              textFieldbox(false, 'Scan Box'),
              // SizedBox(
              //   height: 200,
              // ),
              next('Submit', Customcolor().blacktheme, () {
                if (helper.Assemblylineselect == 'Select') {
                  Utils().toast(msg: 'Please Fill the Fields');
                } else if (helper.scanName.text.isEmpty) {
                  Utils().toast(msg: 'Please Scan the Data');
                } else {
                  // print(helper.line);
                  helper.isAssemblySublineLineScanSubmit(context);
                }
              }),
              next('Refresh', Customcolor().theam, () {
                helper.clearall();
              }),
              SizedBox(
                height: 200,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 30,
          child: Column(
            children: [
              // Text(
              //   'Scan BarCode',
              //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
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
                  padding: const EdgeInsets.only(right: 5, bottom: 5),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => QRCodeScanner()),
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
            ],
          ),
        )
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
              enabled: true,
              focusNode: _focusNode,
              onChanged: (value) {
                setState(() {
                  String text = helper.scanName.text;
                  List<String> lines = text.split('\n');

                  print(lines.length);
                  helper.scanlist.length = lines.length - 1;
                });
                helper.notifyListeners();
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
          padding: const EdgeInsets.symmetric(vertical: 14),
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
        minWidth: 100.w,
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(50.0)),
        ),
      ),
    );
  }
}
