import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app_v1/contoroller/ui_controller.dart';
import 'package:weather_app_v1/home_page_2.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:weather_app_v1/model/weather_model.dart';

import 'allday_model.dart';

Future<bool> checkInternetConnectivity() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    return false; // No internet connection
  }
  return true; // Internet connection is available
}

Getlocation() async {
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy:
        LocationAccuracy.high, // You can choose the desired accuracy level.
  );

  var latitude = position.latitude;
  var longitude = position.longitude;

  Get.put(MyControler()).lat.value = latitude;
  Get.put(MyControler()).long.value = longitude;
  print(latitude);
  print(longitude);
}

GetGeoData() async {
  var dio = Dio();
  var response = await dio.request(
    'https://api.openweathermap.org/data/2.5/weather?lat=${Get.put(MyControler()).lat.value}&lon=${Get.put(MyControler()).long.value}&appid=8ece94c3dd2701539ffbf001f4aedab7',
    options: Options(
      method: 'GET',
    ),
  );
  print(city);

  if (response.statusCode == 200) {
    print(json.encode(response.data));
    var data = response.data;

    double temp = data['main']['temp'];
    String icon = data['weather'][0]['icon'];
    String main = data['weather'][0]['main'];
    String name = data['name'];
    Get.put(MyControler()).city.value = name;
    Get.put(MyControler()).degree.value = (temp - 275);
    Get.put(MyControler()).weatherCondition.value = main;
    Get.put(MyControler()).icon.value = icon;
    print(Get.put(MyControler()).city.value);

    print('Temperature: $temp');
    print('Icon: $icon');
    print('Main: $main');
    print('Name: $name');
  } else {
    print(response.statusMessage);
  }
}

Future<void> GetGeoData2() async {
  try {
    var dio = Dio();
    var response = await dio.request(
      'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=8ece94c3dd2701539ffbf001f4aedab7',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      // Successfully fetched data
      print(json.encode(response.data));
      var data = response.data;

      double temp = data['main']['temp'];
      String icon = data['weather'][0]['icon'];
      String main = data['weather'][0]['main'];
      String name = data['name'];
      Get.put(MyControler()).city.value = name;
      Get.put(MyControler()).degree.value = (temp - 275);
      Get.put(MyControler()).weatherCondition.value = main;
      Get.put(MyControler()).icon.value = icon;
      print(Get.put(MyControler()).city.value);

      print('Temperature: $temp');
      print('Icon: $icon');
      print('Main: $main');
      print('Name: $name');
    } else {
      // Show a snackbar for the error
      print(response.statusMessage);
      Get.snackbar(
        'Error',
        'Failed to fetch data. Please check your internet connection or try again later.',
        // backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  } catch (e) {
    // Show a snackbar for the exception
    print('Exception: $e');
    Get.snackbar(
      'Error',
      'Please enter correct city name',
      // backgroundColor: Colors.red,
      snackPosition: SnackPosition.TOP,
    );
  }
}

GPSallinone() async {
  await requestLocationPermission();
  // checkInternetConnectivity();
  // if(checkInternetConnectivity()==false){
  //   Get.snackbar(
  //     'Error',
  //     'Please enter correct city name',
  //     // backgroundColor: Colors.red,
  //     snackPosition: SnackPosition.TOP,
  //   );
  // }
  await Getlocation();
  await GetGeoData();
  // await fetchWeatherData();
}

// Future<List<Weather>> fetchWeatherData() async {
//     final apiKey = 'YOUR_API_KEY';
//     final response = await http.get(Uri.parse(
//       'https://api.openweathermap.org/data/2.5/forecast?q=YOUR_CITY_NAME&appid=$apiKey',
//     ));

//     if (response.statusCode == 200) {
//       final jsonData = json.decode(response.body);
//       final List<Weather> weatherList = [];

//       for (var data in jsonData['list']) {
//         weatherList.add(Weather(
//           date: DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000).toString(),
//           description: data['weather'][0]['description'],
//           temperature: data['main']['temp'].toDouble(),
//           icon: data['weather'][0]['icon'],
//         ));
//       }

//       return weatherList;
//     } else {
//       throw Exception('Failed to load weather data');
//     }
//   }

fetchWeatherData() async {
  var dio = Dio();
  var response = await dio.request(
    'http://api.openweathermap.org/data/2.5/forecast?lat=${Get.put(MyControler()).lat.value}&lon=${Get.put(MyControler()).long.value}&appid=8ece94c3dd2701539ffbf001f4aedab7',
    options: Options(
      method: 'GET',
    ),
  );

  if (response.statusCode == 200) {
    log("THIS IS ALL DAY DATA:   ${json.encode(response.data)}");
    final jsonData = response.data;
    final Map<String, FiveDayWeather> weatherMap = {};

    for (var data in jsonData['list']) {
      final date = DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000)
          .toString()
          .substring(0, 10);
      if (!weatherMap.containsKey(date)) {
        weatherMap[date] = FiveDayWeather(
          date: date,
          description: data['weather'][0]['description'],
          temperature: data['main']['temp'].toDouble(),
          icon: data['weather'][0]['icon'],
        );
      }
    }

    return weatherMap.values.toList();
  } else {
    print(response.statusMessage);
    throw Exception('Failed to load weather data');
  }
}

alldaydatasearch() async {
  try {
    var dio = Dio();
    var response = await dio.request(
      'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=8ece94c3dd2701539ffbf001f4aedab7',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      log("THIS IS ALL DAY DATA:   ${json.encode(response.data)}");
      final jsonData = response.data;
      final Map<String, FiveDayWeather> weatherMap = {};

      for (var data in jsonData['list']) {
        final date = DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000)
            .toString()
            .substring(0, 10);
        if (!weatherMap.containsKey(date)) {
          weatherMap[date] = FiveDayWeather(
            date: date,
            description: data['weather'][0]['description'],
            temperature: data['main']['temp'].toDouble(),
            icon: data['weather'][0]['icon'],
          );
        }
      }

      return weatherMap.values.toList();
    } else {
      print(response.statusMessage);
      throw Exception('Failed to load weather data');
    }
  } catch (e) {
    print('Error: $e');
    // Handle the error, show a snackbar, or take appropriate action.
    // You can return an empty list or null to indicate the error.
    return null;
  }
}

// Function to request location permissions
Future<void> requestLocationPermission() async {
  final status = await Permission.location.request();

  if (status.isGranted) {
    // Permission is granted, you can now use location services
    // You may want to call a function to retrieve the user's location here.
  } else if (status.isDenied) {
    openAppSettings();
    Get.snackbar(
      'Error',
      'Please enter correct city name',
      // backgroundColor: Colors.red,
      snackPosition: SnackPosition.TOP,
    );
    // Permission is denied, you can show a message to the user
    // explaining why you need location access.
  } else if (status.isPermanentlyDenied) {
    openAppSettings();
    Get.snackbar(
      'Error',
      'Please enter correct city name',
      // backgroundColor: Colors.red,
      snackPosition: SnackPosition.TOP,
    );
    // Permission is permanently denied, usually, the user has selected "Never ask again"
    // You can open the app settings to allow the user to grant permissions.
    openAppSettings();
  }
}

// String getDayOfWeekFromDateString(String dateString) {
//   try {
//     final inputFormat =
//         DateFormat('yyyy-MM-dd'); // Adjust the format to match your date string
//     final date = inputFormat.parse(dateString);
//     final outputFormat =
//         DateFormat('EEEE'); // 'EEEE' represents the full day of the week
//     return outputFormat.format(date);
//   } catch (e) {
//     return 'Invalid Date';
//   }
// }
