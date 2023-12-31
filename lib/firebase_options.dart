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
    apiKey: 'AIzaSyCKkRQmKz3WizV9fM6STT6Zh0fRLjXkMHE',
    appId: '1:992625102853:web:861f161e4305ccaaaf4c6c',
    messagingSenderId: '992625102853',
    projectId: 'rental-porch',
    authDomain: 'rental-porch.firebaseapp.com',
    storageBucket: 'rental-porch.appspot.com',
    measurementId: 'G-WCRG5FRX5M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBwOoTB4MGWTy2wIfxP4GtyT2VIIdlk-PM',
    appId: '1:992625102853:android:3c3fd7f2ed680b83af4c6c',
    messagingSenderId: '992625102853',
    projectId: 'rental-porch',
    storageBucket: 'rental-porch.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD-byEnxSDp-EmI2ouhrTpjtNk4xyZ3wSA',
    appId: '1:992625102853:ios:1409419aebe0deffaf4c6c',
    messagingSenderId: '992625102853',
    projectId: 'rental-porch',
    storageBucket: 'rental-porch.appspot.com',
    iosBundleId: 'com.example.rentalPorchApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD-byEnxSDp-EmI2ouhrTpjtNk4xyZ3wSA',
    appId: '1:992625102853:ios:051c43a27c0122c2af4c6c',
    messagingSenderId: '992625102853',
    projectId: 'rental-porch',
    storageBucket: 'rental-porch.appspot.com',
    iosBundleId: 'com.example.rentalPorchApp.RunnerTests',
  );
}
