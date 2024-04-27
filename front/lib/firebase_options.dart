// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyD0Rwz_LOEzXWV6_LWyuwgU5Kp24wnaM0I',
    appId: '1:330392533531:web:5c1f1b9800b051d71856be',
    messagingSenderId: '330392533531',
    projectId: 'unilife-ebad5',
    authDomain: 'unilife-ebad5.firebaseapp.com',
    storageBucket: 'unilife-ebad5.appspot.com',
    measurementId: 'G-9J050B6XP8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAReMqy_FANp6dbslNTv_FIluHxEGL8cRY',
    appId: '1:330392533531:android:b638bafcd0af0a571856be',
    messagingSenderId: '330392533531',
    projectId: 'unilife-ebad5',
    storageBucket: 'unilife-ebad5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDOEFDKK-iJLtBMCg_uyzyGjyip-h12yB8',
    appId: '1:330392533531:ios:dbb995687670284b1856be',
    messagingSenderId: '330392533531',
    projectId: 'unilife-ebad5',
    storageBucket: 'unilife-ebad5.appspot.com',
    iosBundleId: 'com.example.front',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDOEFDKK-iJLtBMCg_uyzyGjyip-h12yB8',
    appId: '1:330392533531:ios:dbb995687670284b1856be',
    messagingSenderId: '330392533531',
    projectId: 'unilife-ebad5',
    storageBucket: 'unilife-ebad5.appspot.com',
    iosBundleId: 'com.example.front',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD0Rwz_LOEzXWV6_LWyuwgU5Kp24wnaM0I',
    appId: '1:330392533531:web:8adefe52bcd331881856be',
    messagingSenderId: '330392533531',
    projectId: 'unilife-ebad5',
    authDomain: 'unilife-ebad5.firebaseapp.com',
    storageBucket: 'unilife-ebad5.appspot.com',
    measurementId: 'G-S70RRE9W60',
  );
}
