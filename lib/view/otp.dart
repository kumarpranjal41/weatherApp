import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:sizer/sizer.dart';
import 'package:weather_app_v1/view/phone.dart';

// import '../home_page.dart';
import 'view_home_page.dart';

// import 'package:varta2/phone.dart';

class Myotp extends StatefulWidget {
  const Myotp({super.key});

  @override
  State<Myotp> createState() => _MyotpState();
}

class _MyotpState extends State<Myotp> {
  //defining auth variable for otp verification
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isloading = true;
  @override
  Widget build(BuildContext context) {
    var code = ""; //creating variable for smscode google wala code mae

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
          margin: EdgeInsets.only(left: 25, right: 25),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 40.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Image.asset(
                        'assets/bg.png',
                        height: 60.h,
                        width: 80.w,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'phone verification',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'welcome to InternLinker application please login to access InternLinker application',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),

                //phone number entry box

                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder
                                  .none), //for removing the bottom unnesser line in phone box
                        ),
                      ),
                      Expanded(
                          child: TextField(
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {
                          code = value;
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                "Enter Otp"), //for removing the bottom unnesser line in phone box
                      )),
                    ],
                  ),
                ),

                SizedBox(
                  height: 15,
                ),

                SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isloading = false;
                      });

                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                              verificationId: Myphone.verify, smsCode: code);

                      // Sign the user in (or link) with the credential
                      await auth.signInWithCredential(credential);
                      GetStorage().write("isLoginDone", true);

                      Get.to(ViewHomePage());
                    },
                    child: isloading
                        ? Text('Verify Phone Number')
                        : CircularProgressIndicator(
                            color: Colors.white,
                          ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'phone', (route) => false);
                      },
                      child: Text('VERIFY PHONE NUMBER?'),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
