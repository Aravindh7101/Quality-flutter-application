import 'package:ddbm_application/Pages/homePage.dart';
import 'package:ddbm_application/Pages/searchbar.dart';
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
import 'endline Report.dart';

const List<String> list = <String>[
  'G1.0',
  'G1.5',
  'G2.5',
  'G4.0',
  'S1.0',
  'S1.5'
];

class Checker extends ConsumerStatefulWidget {
  const Checker({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Checker();
}

class _Checker extends ConsumerState<Checker> {
  DateTime currentDate = DateTime.now();
  String formatedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  bool _isHidden = true;
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  DateTime? selectedDate = DateTime.now();

  String? dropdownValuelist;
  @override
  void initState() {
    setLandscapeOrientation();
    final helper = ref.read(homeHelper);
    ref.read(homeHelper).isStylefeatch(context);
    setState(() {});
    filteredItems.addAll(helper.ordernolist);
    super.initState();
  }

  TextEditingController _searchController = TextEditingController();
  List<String> filteredItems = [];

  @override
  void dispose() {
    // Remember to clear the preferred orientation when this page is disposed
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  void setLandscapeOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
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

    return Scaffold(
        appBar: AppBar(
          title: Text('Checker Report'),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    textField(
                        false, helper.linesection, 'OC.NO', () {}, false, false),
                    textField(
                        false, helper.linesection, 'Customer', () {}, true, true),
                    textField(
                        false, helper.linesection, 'Patten', () {}, false, true),
                    textField(
                        false, helper.linesection, 'Audit', () {}, false, true),
                    Container(
                        margin: EdgeInsets.only(left: 15, top: 20, right: 8.sp),
                        //padding: EdgeInsets.all(15),
                        child: Text('Date $formatedDate',
                            style: GoogleFonts.gabriela(
                                textStyle: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                )))),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    textField(false, helper.linesection, 'Check ID', () {}, false,
                        false),
                    textField(false, helper.linesection, 'Check Name', () {}, false,
                        false),
                    textField(
                        false, helper.linesection, 'Lot Size', () {}, false, true),
                    textField(
                        false, helper.linesection, 'Sample Size', () {}, false, true),
                    /*CustomDropdown(
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
                    ),*/
                    textField(
                        false, helper.linesection, 'Dropdown', () {}, false, true),
                    textField(
                        false, helper.linesection, 'Section', () {}, false, true),

                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    textField(false, helper.linesection, 'Defect Code', () {},
                        false, true),
                    textField(false, helper.linesection, 'Defect Name', () {},
                        false, true),
                    textField(false, helper.linesection, 'Defect Qty', () {}, false,
                        true),
                    textField(false, helper.linesection, 'Total Qty', () {}, false,
                        true),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              /*Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    textField(false, helper.linesection, 'Defect',
                            () {}, false, false),
                    textField(false, helper.linesection, 'Defect Name',
                            () {}, false, true),
                    textField(false, helper.linesection, 'Defect Qty',
                            () {}, false, true),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),*/
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red)),
                    child: Text('ADD'),
                    onPressed: () {},
                  ),
                  SizedBox(width: 25),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green)),
                    child: Text('SUBMIT'),
                    onPressed: () {},
                  )
                ],
              ),
              Container(
                child: Row(
                  children: [
                    textField(
                        false, helper.linesection, 'Audit1', () {}, false, true),
                    textField(
                        false, helper.linesection, '.....', () {}, false, true),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    textField(
                        false, helper.linesection, 'Audit1', () {}, false, true),
                    textField(
                        false, helper.linesection, '.....', () {}, false, true),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    textField(
                        false, helper.linesection, 'Audit1', () {}, false, true),
                    textField(
                        false, helper.linesection, '.....', () {}, false, true),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    textField(
                        false, helper.linesection, 'Audit1', () {}, false, true),
                    textField(
                        false, helper.linesection, '.....', () {}, false, true),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    textField(
                        false, helper.linesection, 'Audit1', () {}, false, true),
                    textField(
                        false, helper.linesection, '.....', () {}, false, true),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    textField(
                        false, helper.linesection, 'Audit1', () {}, false, true),
                    textField(
                        false, helper.linesection, '.....', () {}, false, true),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    textField(
                        false, helper.linesection, 'Audit1', () {}, false, true),
                    textField(
                        false, helper.linesection, '.....', () {}, false, true),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    textField(
                        false, helper.linesection, 'Audit1', () {}, false, true),
                    textField(
                        false, helper.linesection, '.....', () {}, false, true),
                  ],
                ),
              ),
            ])));
  }

  Widget textField(bool secure, TextEditingController controller,
      String placeholder, Function change, bool isNumeric, bool readOnlytext) {
    final helper = ref.read(homeHelper);

    return Column(
      children: [
        // SizedBox(height: 19),
        Row(
          children: [
            /*Padding(
              padding: const EdgeInsets.only(left: 5, top: 5),
              child: Text(
                placeholder,
                style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 110, 110, 110)),
              ),
            ),*/
          ],
        ),
        Container(
          //margin: EdgeInsets.all(15),
          height: 35,
          width: 100,
          margin: EdgeInsets.only(left: 10, top: 9, right: 8.sp),
          //padding: EdgeInsets.only(bottom: 2),
          //height: 11.w,
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
            controller: controller, ///it used for auto fill textfield
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                change();
              });
              setState(() {});
            },
            // obscureText: secure == true ? _isHidden : false,
            decoration: InputDecoration(
              /*suffix: secure == true
                  ? InkWell(
                      onTap: _togglePasswordView,
                      child: Icon(
                        _isHidden ? Icons.visibility : Icons.visibility_off,
                      ),
                    )
                  : null,*/
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
