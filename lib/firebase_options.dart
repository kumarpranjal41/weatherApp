// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCTpIpYB_Mwqt074s-6theBUDe9MC3TU_c',
    appId: '1:167195945338:web:f2e95f8d67c6079a38cec3',
    messagingSenderId: '167195945338',
    projectId: 'weather-app-a4ac6',
    authDomain: 'weather-app-a4ac6.firebaseapp.com',
    storageBucket: 'weather-app-a4ac6.appspot.com',
    measurementId: 'G-JK8WT1N9X8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB1FFJnGSOs5vWZ8Nw1O3sXkTz1qcJ5QeE',
    appId: '1:167195945338:android:3ee17c3bdd6e8a3c38cec3',
    messagingSenderId: '167195945338',
    projectId: 'weather-app-a4ac6',
    storageBucket: 'weather-app-a4ac6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAMrZq3_D3iROiH6z0ihzJuFlHF1hh9SA4',
    appId: '1:167195945338:ios:9a2e69e865faed6e38cec3',
    messagingSenderId: '167195945338',
    projectId: 'weather-app-a4ac6',
    storageBucket: 'weather-app-a4ac6.appspot.com',
    iosClientId: '167195945338-fbb23934c4r3252a0fbt3ksi3d5ot1ks.apps.googleusercontent.com',
    iosBundleId: 'com.example.weatherAppV1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAMrZq3_D3iROiH6z0ihzJuFlHF1hh9SA4',
    appId: '1:167195945338:ios:b6ed5dddda3e41b738cec3',
    messagingSenderId: '167195945338',
    projectId: 'weather-app-a4ac6',
    storageBucket: 'weather-app-a4ac6.appspot.com',
    iosClientId: '167195945338-kjian3j1lbjltvctmoltrp2la9tcndqi.apps.googleusercontent.com',
    iosBundleId: 'com.example.weatherAppV1.RunnerTests',
  );
}
