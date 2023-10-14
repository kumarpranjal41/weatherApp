import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

import 'otp.dart';

class Myphone extends StatefulWidget {
  const Myphone({super.key});

  static String verify = "";

  @override
  State<Myphone> createState() => _MyphoneState();
}

class _MyphoneState extends State<Myphone> {
  TextEditingController countrycode =
      TextEditingController(); // +91 kae leye editing

  var phone = "";
  bool isloading = false;

  @override
  void initState() {
    // TODO: implement initState
    countrycode.text = "  +91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        height: 900,
                        width: 900,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Text(
                  'PHONE VERIFICATION',
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
                    border: Border.all(
                      width: 1,
                      color: Color(0xFFFA8E0F),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: TextField(
                          controller: countrycode,
                          decoration: InputDecoration(
                              border: InputBorder
                                  .none), //for removing the bottom unnesser line in phone box
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "|",
                        style: TextStyle(fontSize: 33, color: Colors.grey),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: TextField(
                        keyboardType: TextInputType.phone,
                        onChanged: ((value) {
                          phone = value;
                        }),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                "Phone Number"), //for removing the bottom unnesser line in phone box
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
                      //code for loader animation ahe......

                      setState(() {
                        isloading = true;
                      });
                      Future.delayed(Duration(seconds: 30), (() {
                        setState(() {
                          isloading = false;
                        });
                      }));

                      //code for firebase hae...........
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: '${countrycode.text + phone}',
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          Myphone.verify = verificationId;
                          Get.to(Myotp());
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    },
                    child: isloading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text('Send the Code'),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFA8E0F),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
