//HOMEPAGE2

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_v1/model/weather_model.dart';
import 'package:weather_app_v1/view/login_page.dart';
import 'package:weather_app_v1/widgets/widtges.dart';

import '../contoroller/ui_controller.dart';
import '../model/geo_location.dart';

String city = '';

class ViewHomePage extends StatefulWidget {
  const ViewHomePage({super.key});

  @override
  State<ViewHomePage> createState() => _ViewHomePageState();
}

class _ViewHomePageState extends State<ViewHomePage> {
  final cityController = TextEditingController();
  // bool gps = true;
  List<FiveDayWeather> weatherData = [];

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.to(LoginPage());
    // navigate to the login screen or perform other actions
  }

  @override
  void initState() {
    super.initState();
    fetchWeatherData().then((data) {
      setState(() {
        weatherData = data;
      });
    });

    GPSallinone();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    //  final weather = weatherData[index];
    // Getlocation();
    // GetGeoData();
    return Scaffold(
      backgroundColor: Color(0xff323B66),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: height,
              width: width,
              child: Image.asset(
                'assets/bg.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 65),
              child: Center(
                child: Positioned(
                  top: height * 0.08,
                  left: width * 0.24,
                  child: Center(
                    child: Obx(
                      () => Text(
                        "${Get.put(MyControler()).city.value}",
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                top: height * 0.11,
                left: width * 0.9,
                // right: width * 0.7,
                child: InkWell(
                  onTap: () async {
                    await _signOut();
                  },
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                )),
            Positioned(
              top: height * 0.14,
              left: width * 0.33,
              child: Obx(
                () => Text(
                  "${Get.put(MyControler()).degree.value.toInt()}°",
                  style: TextStyle(
                      fontSize: 80,
                      color: Colors.white,
                      fontWeight: FontWeight.w200),
                ),
              ),
            ),
            Positioned(
              top: height * 0.27,
              left: width * 0.30,
              child: Obx(
                () => Text(
                  "${Get.put(MyControler()).weatherCondition.value}",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white30,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Positioned(
              top: height * 0.1,
              left: width * 0.05,
              child: IconButton(
                onPressed: () async {
                  await Getlocation();
                  GetGeoData();
                  //alldaydataGps();
                  // alldaydatagps();
                },
                icon: Icon(
                  // Icons.location_disabled_rounded,
                  // color: Colors.white,
                  CupertinoIcons.location,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
                top: height * 0.32,
                // left: width * 0.1,
                child: Image.asset('assets/house.png')),
            Positioned(
                top: height * 0.6,
                // left: width * 0.1,
                child: Container(
                  height: height * 0.5,
                  width: width,
                  decoration: BoxDecoration(
                      color: Color(0xff382E70),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Text(
                        'Daily Forecast',
                        style: TextStyle(
                            color: Colors.white54,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: height * 0.005,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(20)),
                        height: height * 0.005,
                        width: width * 0.9,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      // Expanded(
                      //   child: ListView.builder(
                      //     itemCount: weatherData.length,
                      //     itemBuilder: (context, index) {
                      //       final weather = weatherData[index];
                      //       return ListTile(
                      //         title: Text(weather.date),
                      //         subtitle: Text(
                      //             '${weather.description}, ${weather.temperature}°C'),
                      //         leading: Image.network(
                      //             'https://openweathermap.org/img/w/${weather.icon}.png'),
                      //       );
                      //     },
                      //   ),
                      // ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (int i = 0; i < weatherData.length; i++) ...[
                              monday(
                                  height: height,
                                  width: width,
                                  day: weatherData[i].date,
                                  imgUrl:
                                      'https://openweathermap.org/img/w/${weatherData[i].icon}.png',
                                  degree: (weatherData[i].temperature - 275.0)
                                          .toInt()
                                          .toString() +
                                      '°')
                            ]
                          ],
                        ),
                      ),
                      Container(
                        height: height * 0.1,
                        width: width * 0.9,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 82, 69, 155),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.search,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.1,
                              width: width * 0.6,
                              child: TextField(
                                controller: cityController,
                                onChanged: (value) {
                                  city = value.trim();
                                },

                                style: TextStyle(color: Colors.white),
                                // textInputAction: TextInputAction.none,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        top: height *
                                            0.033), // Adjust padding as needed
                                    //  textAlign: TextAlign.center,
                                    //border: OutlineInputBorder(),
                                    hintText: "Search City ",
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                GetGeoData2();
                                alldaydatasearch().then((data) {
                                  setState(() {
                                    weatherData = data;
                                  });
                                });
                                cityController.clear();
                              },
                              icon: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
