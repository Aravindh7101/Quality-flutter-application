import 'package:ddbm_application/custom/custom.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// void main() {
//   runApp(MaterialApp(
//     title: 'Syncfusion PDF Viewer Demo',
//     home: HelpPage(),
//   ));
// }

/// Represents HelpPage for Navigation
// class HelpPage extends StatefulWidget {
//   @override
//   _HelpPage createState() => _HelpPage();
// }

// class _HelpPage extends State<HelpPage> {
//   final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Syncfusion Flutter PDF Viewer'),
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(
//               Icons.bookmark,
//               color: Colors.white,
//               semanticLabel: 'Bookmark',
//             ),
//             onPressed: () {
//               _pdfViewerKey.currentState?.openBookmarkView();
//             },
//           ),
//         ],
//       ),
//       body: SfPdfViewer.network(
//         'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
//         key: _pdfViewerKey,
//       ),
//     );
//   }
// }

const loremIpsum = 'sdasdasdadsdsds';

class HelpPage extends StatefulWidget {
  final int? id;
  HelpPage({Key? key, this.id}) : super(key: key);

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  void initState() {
    super.initState();
    getHelpPage();
  }

  List<Map<String, String>> HelpPagedata = <Map<String, String>>[
    {"question": "DDMS Application", "answer": "Demo Application"},
    {"question": "DDMS Application", "answer": "Demo Application"},
    {"question": "DDMS Application", "answer": "Demo Application"},
    {"question": "DDMS Application", "answer": "Demo Application"},
    {"question": "DDMS Application", "answer": "Demo Application"},
  ];

  var productList = [];
  getHelpPage() async {
    // Map<String, String> myMap = {"question": "value1", "answer": "value2"};

    // HelpPagedata = myMap.values.toList();
    // final HelpPageResponse = await AuthRepository().getHelpPage();
    // if (HelpPageResponse.data.isNotEmpty) {
    //   HelpPagedata.addAll(HelpPageResponse.data);
    //   HelpPageResponse.data.forEach((element) {
    //     setState(() {
    //       productList.add(element.answer);
    //     });
    //     print('$productList');
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildappbar(context),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            HelpPagelist(),
          ])),

          //  SliverList(delegate: SliverChildListDelegate(
          //   [
          //      profiletop(),
          //   ]
          // )
          // ),
        ],
      ),
    );
  }

  Widget HelpPagelist() {
    return Column(
      children: [
        Container(
          height: HelpPagedata.length + 120.h,
          // height: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: ListView.builder(
              itemCount:
                  // 2,
                  HelpPagedata.length,
              itemBuilder: (context, index) {
                return Expandedlist(
                  title:
                      // 'd',
                      HelpPagedata[index]['question'],
                  content:
                      //'1'
                      HelpPagedata[index]['answer'],
                );
              }),
        ),
      ],
    );
  }

  AppBar buildappbar(context) {
    return AppBar(
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
        'Help',
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
    );
  }
}

class Expandedlist extends StatelessWidget {
  final String? title;
  final String? content;
  Expandedlist({
    Key? key,
    this.title,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
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
      child: Column(
        children: <Widget>[
          ScrollOnExpand(
            scrollOnExpand: true,
            scrollOnCollapse: false,
            child: ExpandablePanel(
              theme: const ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                tapBodyToCollapse: true,
              ),
              header: Padding(
                  padding:
                      EdgeInsets.only(left: 15.sp, top: 8.sp, bottom: 5.sp),
                  child: Text(
                    '$title',
                    style: TextStyle(
                        color: Customcolor().blacktheme,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp),
                  )),
              collapsed: Container(),
              expanded: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  for (var _ in Iterable.generate(1))
                    Padding(
                        padding: EdgeInsets.only(bottom: 10, top: 10),
                        child: Text(
                          '$content',
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        )),
                ],
              ),
              builder: (_, collapsed, expanded) {
                return Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Expandable(
                    collapsed: collapsed,
                    expanded: expanded,
                    theme: const ExpandableThemeData(crossFadePoint: 0),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
