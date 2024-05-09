import 'package:ddbm_application/Pages/homePage.dart';
import 'package:ddbm_application/Pages/partspage.dart';
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
import 'Login.dart';
import 'helppdfviewer.dart';

class Mainpage extends ConsumerStatefulWidget {
  const Mainpage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Mainpage();
}

class _Mainpage  extends ConsumerState<Mainpage> {
  @override
  Widget build(BuildContext context) {
    final helper = ref.read(homeHelper);

    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
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
                MaterialPageRoute(builder: (_) => LoginScreen()),
                    (route) => false,
              );
              // MainBottomsheet(context);
            },
          ),
        ],
      ),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                transform: GradientRotation(50),
                colors: [
                  Colors.teal.shade400,
                  Colors.tealAccent,
                  Colors.tealAccent,
                  Colors.teal
                ],
              ),
            ),
            padding: EdgeInsets.fromLTRB(0, 150, 0, 0),
            child: Center(
              child: GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.all(5),
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: [
                  buildGridItem(
                    'Assets/partsimage/parts.jpg',
                    'Parts',
                        () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Partspage()));
                    },
                  ),
                  buildGridItem(
                    'Assets/partsimage/assembly-removebg-preview.jpg',
                    'Assembly',
                        () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Partspage()));
                    },
                  ),
                  buildGridItem(
                    'Assets/partsimage/cutting.jpg',
                    'Cutting',
                        () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Partspage()));
                    },
                  ),
                  buildGridItem(
                    'Assets/partsimage/finishing-removebg-preview.jpg',
                    'Finishing',
                        () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Partspage()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  }

}
Widget buildGridItem(String imagePath, String title, void Function()? onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Image(
            fit: BoxFit.cover,
            image: AssetImage(imagePath),
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: GoogleFonts.akronim(
                textStyle:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            // style: TextStyle(.
            //   fontSize: 16,
            //   fontWeight: FontWeight.bold,
            //   ),
            // ),
          )
        ],
      ),
    ),
  );
}