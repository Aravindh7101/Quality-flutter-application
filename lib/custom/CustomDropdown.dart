import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class CustomDropdown extends ConsumerStatefulWidget {
  final Widget image;
  final List listed;
  final Widget dropdown;
  final String? listname;
  final String? lablename;

  CustomDropdown(
      {Key? key,
      required this.dropdown,
      required this.image,
      required this.listed,
      this.listname,
      this.lablename})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends ConsumerState<CustomDropdown> {
  String _listName = "";

  @override
  void initState() {
    _listName = widget.listname ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 19, top: 9),
              child: Text(
                widget.lablename!,
                style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 110, 110, 110)),
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.only(left: 10, top: 10, right: 8.sp),
            // width: 51.w,
            // height: 12.w,
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
            child: Row(
              children: [
                // Container(
                //     height: double.infinity,
                //     width: 50,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.only(
                //           topLeft: Radius.circular(9),
                //           bottomLeft: Radius.circular(9)),
                //       color: Colors.grey[400],
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.black12,
                //           spreadRadius: 1,
                //           blurRadius: 5,
                //           offset: Offset(2, 2), // changes position of shadow
                //         ),
                //       ],
                //     ),
                //     child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: widget.image)),
                // SizedBox(width: 10),
                Expanded(child: widget.dropdown),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
