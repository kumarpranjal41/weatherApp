import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:sizer/sizer.dart';
import 'package:weather_app_v1/view/view_home_page.dart';

import 'login_page.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/splash';

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.35,
          ),
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 12.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: Image.asset(
                  'assets/bg.png',
                  height: 900,
                  width: 900,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Center(
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'Weather',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'App',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * 0.20,
          ),
          Icon(Icons.search),
          SizedBox(
            height: height * 0.02,
          ),
          Text(
            'Looking for a Weather, \ncheck live using our app with Live data ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      floatingActionButton: SlideInLeft(
        child: FloatingActionButton(
          backgroundColor: Color(0xFFFEE8D3),
          onPressed: () {
            GetStorage().read('isLoginDone') == true
                ? Get.to(ViewHomePage())
                : Get.to(LoginPage());
          },
          child: Icon(
            Icons.arrow_forward,
            color: Color(0xFFFA8E0F),
          ),
        ),
      ),
    );
  }
}
