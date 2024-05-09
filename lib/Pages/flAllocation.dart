import 'package:ddbm_application/Utils/Utils.dart';
import 'package:ddbm_application/custom/CustomDropdown.dart';
import 'package:ddbm_application/custom/custom.dart';
import 'package:ddbm_application/helper/home_helper.dart';
import 'package:ddbm_application/widgets/qrcodescanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

const List<String> list = <String>['Select', 'Orderno', 'Bundleno'];
// const List<String> list1 = <String>['Orderno', 'Bundleno'];

class FLA extends ConsumerStatefulWidget {
  const FLA({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FLAState();
}

class _FLAState extends ConsumerState<FLA> {
  String dropdownValue = list.first;
  bool _isHidden = true;
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    final helper = ref.read(homeHelper);

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SingleChildScrollView(
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
              Container(
                child: Column(
                  children: [
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
                      lablename: 'Select Type',
                      listname: 'Select',
                    ),
                    CustomDropdown(
                      dropdown: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: DropdownButton<String>(
                          value: helper.line,
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
                              helper.line = value!;
                            });
                          },
                          items: helper.linelist
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
                      lablename: 'Line',
                      listname: 'Select',
                    ),
                    textFieldbox(false, 'Scan Box'),
                    next('Assign', Customcolor().blacktheme, () {
                      if (helper.line == 'Select' ||
                          helper.TypeData == 'Select') {
                        Utils().toast(msg: 'Please Fill the Fields');
                      } else if (helper.scanName.text.isEmpty) {
                        Utils().toast(msg: 'Please Scan the Data');
                      } else {
                        // print(helper.line);
                        helper.isfinishingSubmit(context);
                      }
                    }),
                    next('Refresh', Customcolor().theam, () {
                      helper.clearall();
                    }),
                  ],
                ),
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
              // keyboardType: TextInputType.number,
              enabled: true,
              // focusNode: _focusNode,
              onChanged: (value) {
                String text = helper.scanName.text;
                List<String> lines = text.split('\n');
                helper.notifyListeners();

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
}
