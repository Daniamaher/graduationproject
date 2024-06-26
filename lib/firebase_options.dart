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
    apiKey: 'AIzaSyDO4ffP6lvbQTfckCiDSrHjdp1QeGDCPF4',
    appId: '1:208407512848:web:c0e368141943632d404795',
    messagingSenderId: '208407512848',
    projectId: 'easeyourunilife',
    authDomain: 'easeyourunilife.firebaseapp.com',
    storageBucket: 'easeyourunilife.appspot.com',
    measurementId: 'G-QGHM4XPMV5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCAR2lKBF1dP0NZFHBvf1cE21o2r87GBhQ',
    appId: '1:208407512848:android:17bef8e3e9c0e1ec404795',
    messagingSenderId: '208407512848',
    projectId: 'easeyourunilife',
    storageBucket: 'easeyourunilife.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBLtAmSlHY0FGNDRyaOxakONdjs6gxdEpc',
    appId: '1:208407512848:ios:71dac3a58cc2b82e404795',
    messagingSenderId: '208407512848',
    projectId: 'easeyourunilife',
    storageBucket: 'easeyourunilife.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBLtAmSlHY0FGNDRyaOxakONdjs6gxdEpc',
    appId: '1:208407512848:ios:3ff667146a03b150404795',
    messagingSenderId: '208407512848',
    projectId: 'easeyourunilife',
    storageBucket: 'easeyourunilife.appspot.com',
    iosBundleId: 'com.example.flutterApplication1.RunnerTests',
  );
}
