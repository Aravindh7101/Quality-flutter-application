import 'package:ddbm_application/Pages/homePage.dart';
import 'package:ddbm_application/Pages/searchbar.dart';
import 'package:ddbm_application/Utils/Utils.dart';
import 'package:ddbm_application/custom/CustomDropdown.dart';
import 'package:ddbm_application/custom/custom.dart';
import 'package:ddbm_application/helper/login_helper.dart';
import 'package:ddbm_application/widgets/qrcodescanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import '../helper/home_helper.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class EnterManually extends ConsumerStatefulWidget {
  const EnterManually({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EnterManuallyState();
}

class _EnterManuallyState extends ConsumerState<EnterManually> {
  String dropdownValue = list.first;
  bool _isHidden = true;
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  String? dropdownValuelist;
  @override
  void initState() {
    final helper = ref.read(homeHelper);
    ref.read(homeHelper).isStylefeatch(context);
    setState(() {});
    filteredItems.addAll(helper.ordernolist);
    // helper.sectionlist = ['Select'];
    // helper.colorlist = ['Select'];
    // helper.operationlist = ['Select'];
    // helper.sectionselect = 'Select';
    // helper.colorselect = 'Select';
    // helper.opselect = 'Select';

    // if (helper.scanName.text.isEmpty) {
    //   ref.read(homeHelper).isStylefeatch(context);
    // }
    super.initState();
    // dropdownValuelist = ref.read(homeHelper).ordernolist.first;
  }

  TextEditingController _searchController = TextEditingController();
  // List<String> items = [
  //   "Apple",
  //   "Banana",
  //   "Cherry",
  //   "Date",
  //   "Grape",
  //   "Kiwi",
  //   "Lemon",
  //   "Mango",
  //   "Orange",
  //   "Peach",
  //   "Pear"
  // ];
  List<String> filteredItems = [];

  @override
  // void initState() {
  //   super.initState();
  //   filteredItems.addAll(items);
  // }

  void _filterSearchResults(String query) {
    List<String> searchResults = [];
    if (query.isNotEmpty) {
      ref.read(homeHelper).ordernolist.forEach((item) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(item);
        }
      });
      setState(() {
        filteredItems.clear();
        filteredItems.addAll(searchResults);
      });
    } else {
      setState(() {
        filteredItems.clear();
        filteredItems.addAll(ref.read(homeHelper).ordernolist);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final helper = ref.read(homeHelper);

    return Stack(
      alignment: Alignment.bottomCenter,
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
              Container(
                margin: EdgeInsets.only(bottom: 50.sp),
                width: double.infinity,
                child: Column(
                  children: [
                    // textField(false, helper.opName, 'Search Order No here', ''),
                    // SizedBox(
                    //   height: 50,
                    // ),

                    // textField(
                    //     false, _searchController, 'Seatch', () {}, true, false),
                    Column(
                      children: [
                        // SizedBox(height: 10),
                        Container(
                          margin:
                              EdgeInsets.only(left: 10, top: 9, right: 8.sp),
                          padding: EdgeInsets.only(bottom: 2),
                          height: 14.w,
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
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, left: 10, right: 0),
                                child: Icon(Icons.search),
                              ),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  readOnly: true,
                                  controller: _searchController,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => SearhBarfield()),
                                    );

                                    // setState(() {});
                                  },
                                  onChanged: (String? value) {
                                    // This is called when the user selects an item.
                                    setState(() {
                                      // change();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => SearhBarfield()),
                                      );
                                    });
                                    setState(() {});
                                  },
                                  // obscureText: secure == true ? _isHidden : false,
                                  decoration: InputDecoration(
                                    suffix: false == true
                                        ? InkWell(
                                            onTap: _togglePasswordView,
                                            child: Icon(
                                              _isHidden
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                            ),
                                          )
                                        : null,
                                    border: InputBorder.none,
                                    hintText: 'Search',
                                    hintStyle: TextStyle(
                                      color: Color(0xffABB4BD),
                                      fontFamily: 'Gilroy',
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    contentPadding: EdgeInsets.only(
                                      right: 20,
                                      left: 10,
                                      top: false == true ? 7 : 19,
                                      bottom: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Container(
                    //   height: 400,
                    //   child: Column(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: TextField(
                    //           controller: _searchController,
                    //           onChanged: _filterSearchResults,
                    //           decoration: InputDecoration(
                    //             labelText: "Search",
                    //             hintText: "Search for fruits",
                    //             prefixIcon: Icon(Icons.search),
                    //           ),
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: ListView.builder(
                    //           itemCount: filteredItems.length,
                    //           itemBuilder: (BuildContext context, int index) {
                    //             return ListTile(
                    //               title: Text(filteredItems[index]),
                    //             );
                    //           },
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomDropdown(
                            dropdown: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: DropdownButton<String>(
                                value: helper.orderselect,
                                iconSize: 0,
                                // icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                isExpanded: true,
                                style:
                                    TextStyle(color: Customcolor().blacktheme),
                                underline: Container(
                                  height: 2,
                                  color: Customcolor().underlinetheme,
                                ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    helper.orderselect = value!;
                                  });
                                  // helper.sectionlist = ['Select'];
                                  // helper.colorlist = ['Select'];
                                  // helper.operationlist = ['Select'];
                                  // helper.sectionselect = 'Select';
                                  // helper.colorselect = 'Select';
                                  // helper.opselect = 'Select';
                                  helper.isSectionfeatch(context);
                                  helper.iscolorfeatch(context);
                                },
                                items: helper.ordernolist
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
                                value: helper.sectionselect,
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
                                    helper.sectionselect = value!;
                                  });
                                  // helper.operationlist = ['Select'];
                                  // helper.opselect = 'Select';

                                  helper.isoperationfeatch(context);
                                },
                                items: helper.sectionlist
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
                            lablename: 'Section',
                            listname: 'Select',
                          ),
                        ),
                        Expanded(
                          child: CustomDropdown(
                            dropdown: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: DropdownButton<String>(
                                value: helper.opselect,
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
                                  helper.opselect = 'Select';
                                  setState(() {
                                    helper.opselect = value!;
                                  });
                                },
                                items: helper.operationlist
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
                                value: helper.colorselect,
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
                                    helper.colorselect = value!;
                                  });
                                },
                                items: helper.colorlist
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
                            lablename: 'Color',
                            listname: 'Select',
                          ),
                        ),
                      ],
                    ),
                    textField(false, helper.bundleno, 'Enter Bundle No', () {},
                        true, false),
                    // textField(
                    //     false, helper.bundleno, 'Enter Bundle No', 'Bundle No',(){},false,false),
                    textFieldbox(false, 'Scan Box'),
                    SizedBox(
                      height: 20,
                    ),
                    next('Get BarCode No', Customcolor().blacktheme, () {
                      helper.isgetbarcode(context);
                    }),
                    next('Send To Scan Box', Customcolor().blacktheme, () {
                      if (helper.scanName.text.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => MainScreen()),
                        );
                      } else {
                        Utils().toast(msg: 'Scan Box is Empty');
                      }
                    }),
                    next('Refresh', Customcolor().theam, () {
                      ref.read(homeHelper).clearall();
                    }),
                    SizedBox(
                      height: 100,
                    ),
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
              // Container(
              //   padding: EdgeInsets.all(4),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(50),
              //     color: Colors.white,
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.black26,
              //         spreadRadius: 1,
              //         blurRadius: 5,
              //         offset: Offset(2, 2),
              //       ),
              //     ],
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.only(right: 5, bottom: 5),
              //     child: IconButton(
              //       onPressed: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(builder: (_) => QRCodeScanner()),
              //         );
              //       },
              //       icon: Icon(
              //         Icons.qr_code_scanner_rounded,
              //         size: 39,
              //         color: Customcolor().blacktheme,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        )
      ],
    );
  }

  Widget textField(bool secure, TextEditingController controller,
      String placeholder, Function change, bool isNumeric, bool readOnlytext) {
    final helper = ref.read(homeHelper);

    return Column(
      children: [
        // SizedBox(height: 10),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 19, top: 19),
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
              // keyboardType: TextInputType.,
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
