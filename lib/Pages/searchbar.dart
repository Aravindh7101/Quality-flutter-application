import 'package:ddbm_application/custom/custom.dart';
import 'package:ddbm_application/helper/home_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class SearhBarfield extends ConsumerStatefulWidget {
  const SearhBarfield({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearhBarfieldState();
}

class _SearhBarfieldState extends ConsumerState<SearhBarfield> {
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

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: kBackground,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Customcolor().blacktheme,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              // color: Colors.black,
            )),
        title: Text(
          'Search',
          style: TextStyle(
              // color: Color(0xff1A1A1A),
              fontFamily: 'Gilroy',
              fontWeight: FontWeight.w700),
        ),
        // actions: [
        //   GestureDetector(
        //     onTap: (){

        //     },
        //     child: Image.asset("Assets/Images/search.png",
        //        width: 6.w,
        //         ),
        //   ),
        //   SizedBox(width: 4.w,)
        // ],
        elevation: 1,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.only(left: 10, top: 9, right: 8.sp),
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
                    padding:
                        const EdgeInsets.only(top: 5.0, left: 15, right: 0),
                    child: Icon(Icons.search),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: _filterSearchResults,
                      decoration: InputDecoration(
                        // suffix: false == true
                        // ? InkWell(
                        //     onTap: _togglePasswordView,
                        //     child: Icon(
                        //       _isHidden ? Icons.visibility : Icons.visibility_off,
                        //     ),
                        //   )
                        // : null,
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
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    setState(() {
                      // controller.closeView(item);
                      helper.orderselect = filteredItems[index];
                      print(helper.orderselect);
                      helper.isSectionfeatch(context);
                      helper.iscolorfeatch(context);
                      if (helper.orderselect == filteredItems[index]) {
                        Navigator.pop(context);
                      }
                    });
                  },
                  title: Text(filteredItems[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
