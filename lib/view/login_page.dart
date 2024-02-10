import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:sizer/sizer.dart';
import 'package:weather_app_v1/view/view_home_page.dart';
import 'package:weather_app_v1/view/phone.dart';

// import '../home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  ///////

  // Future<void> logout() async {
  //   await GoogleSignIn().disconnect();
  //   FirebaseAuth.instance.signOut();
  // }
  ///////

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String displayName;
  late String email;
  late String photoUrl;
  final loginDetector = GetStorage();

  googleLogin() async {
    print("googleLogin method Called");
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      var result = await _googleSignIn.signIn();
      if (result == null) {
        return;
      }

      final userData = await result.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: userData.accessToken, idToken: userData.idToken);
      var finalResult = await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        // GetStorage().write("googlelogin", 0);
        GetStorage().write('isLoginDone', true);

// dhasgfg

        try {
          // Reference to the Firestore collection and document

          DocumentReference documentReference = await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser?.uid);

          // Fetch the document snapshot
          DocumentSnapshot snapshot = await documentReference.get();

          // Check if the document exists
          if (snapshot.exists) {
            // Access the specific field in the document
            var fieldValue = snapshot.get('signup');

            // Do something with the field value
            // await FirebaseFirestore.instance.collection('feeds').doc(uuid).update(
            //   {
            //     'profileUrl': fieldValue,
            //   },
            // );
            Get.to(ViewHomePage());

            //print('Field Value: $fieldValue');
          } else {
            print('Document does not exis ssd t');
            Get.to(ViewHomePage());
          }
        } catch (e) {
          vaibhav = false;
          //return false;
          print('Error fetching data: $e');
          Get.to(ViewHomePage());
        }
//asdnsd

        //   Get.to(nextRoute);
      });
      print("Result $result");
      print(result.displayName);
      displayName = "${result.displayName}";
      GetStorage().write("displayName", displayName);
      print(result.email);
      email = "${result.email}";
      GetStorage().write("email", email);
      print(result.photoUrl);
      photoUrl = "${result.photoUrl}";
      GetStorage().write("photourl", photoUrl);
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  late bool vaibhav;
  //////////////////////condition//////////////////////
  Future<bool> fetchData() async {
    try {
      // Reference to the Firestore collection and document

      DocumentReference documentReference = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid);

      // Fetch the document snapshot
      DocumentSnapshot snapshot = await documentReference.get();

      // Check if the document exists
      if (snapshot.exists) {
        print("vainbhav");
        // Access the specific field in the document
        var fieldValue = snapshot.get('signup');

        // Do something with the field value
        // await FirebaseFirestore.instance.collection('feeds').doc(uuid).update(
        //   {
        //     'profileUrl': fieldValue,
        //   },
        // );
        vaibhav = true;
        return true;
        //print('Field Value: $fieldValue');
      } else {
        print('Document does not exis ssd t');
        vaibhav = false;
        return false;
      }
    } catch (e) {
      vaibhav = false;
      return false;
      print('Error fetching data: $e');
    }
  }
  /////////////////////condition/////////////////

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 0.5 * height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: Stack(
              children: [
                Container(
                  height: height * 0.5,
                  width: width,
                  child: Image.asset(
                    'assets/bg.png',
                    fit: BoxFit.cover,
                    opacity: const AlwaysStoppedAnimation(.8),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: SlideInUp(
                      delay: Duration(milliseconds: 1000),
                      child: Text(
                        'Welcome to WeatherApp 🎉',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: height * 0.23,
                  left: width * 0.5,
                  child: SlideInUp(
                    delay: Duration(milliseconds: 1000),
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Weather',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'App',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: height * 0.3,
                  left: width * 0.05,
                  child: SlideInUp(
                    delay: Duration(milliseconds: 1000),
                    child: Text(
                      "Better to check \nthe weather before going out'",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                  ),
                ),
                Positioned(
                  top: height * 0.42,
                  left: width * 0.05,
                  child: SlideInUp(
                    delay: Duration(milliseconds: 800),
                    child: Text(
                      "Knowing the weather forecast helps \nyou dress appropriately.",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 0.45 * height,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.04,
                ),
                SlideInRight(
                  child: InkWell(
                    onTap: () {
                      Get.to(Myphone());
                    },
                    child: Container(
                      height: height * 0.07,
                      width: width * 0.8,
                      decoration: BoxDecoration(
                        color: Color(0xFFFA8E0F),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.phone_android),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Text(
                              'Continue with number',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Container(
                        height: height * 0.002,
                        width: width * 0.35,
                        color: Colors.black54,
                      ),
                    ),
                    Text('Or login with'),
                    Container(
                      height: height * 0.002,
                      width: width * 0.35,
                      color: Colors.black54,
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.08,
                ),
                InkWell(
                  onTap: () async {
                    //fetchData();
                    await googleLogin();
                  },
                  child: SlideInLeft(
                    child: Container(
                      height: height * 0.07,
                      width: width * 0.55,
                      decoration: BoxDecoration(
                          //color: Colors.black,
                          //border: Border.all(),
                          // borderRadius: BorderRadius.all(
                          //   Radius.circular(20),
                          // ),
                          ),
                      child: Image.asset(
                        'assets/googlelogin.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
