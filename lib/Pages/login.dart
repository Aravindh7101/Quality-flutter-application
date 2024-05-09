import 'package:ddbm_application/helper/login_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import '../constant/CustomLottie.dart';
import '../constant/CustomStyle.dart';
import '../custom/custom.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ffi';
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _isHidden = true;
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    final helper = ref.read(loginHelper);

    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent.shade100,
      //backgroundColor: Customcolor().blacktheme,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10.h),
            Text(
              'DDBM',
              style: GoogleFonts.merriweather(textStyle: TextStyle(fontSize: 30),fontWeight: FontWeight.bold),
              //style: CustomFont().Logofontstyle,
            ),
            SizedBox(height: 15.h),
            // LottiesImage().login,
            textField(false, helper.username, 'Username'),
            textField(true, helper.password, 'Password'),
            SizedBox(height: 40),
            next(),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'V-1.1 © 2023, All Rights Reserved to ISSS',
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

  Widget textField(
      bool secure, TextEditingController controller, String placeholder) {
    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 10, top: 10, right: 8.sp),
          height: 15.w,
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
            keyboardType: TextInputType.text,
            controller: controller,
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
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
              contentPadding: EdgeInsets.only(
                right: 20,
                left: 20,
                top: secure == true ? 10 : 19,
                bottom: 7,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget next() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: MaterialButton(
        onPressed: () {
          ref.read(loginHelper).login(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Text(
            'Login',
            style: TextStyle(
              color: Customcolor().theam,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: .5,
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
