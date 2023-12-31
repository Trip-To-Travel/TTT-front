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
///
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
    apiKey: 'AIzaSyCRVF7_tnAJCdLTfVOUUSQncznYtRONDBU',
    appId: '1:112879024646:web:b036ad3f174c8ac4ba6187',
    messagingSenderId: '112879024646',
    projectId: 'triptotravel-71d2c',
    authDomain: 'triptotravel-71d2c.firebaseapp.com',
    storageBucket: 'triptotravel-71d2c.appspot.com',
    measurementId: 'G-HQEWF3VB68',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCXglawiE-cCHevfzfCLZ2Zi858UWQy_Bk',
    appId: '1:112879024646:android:2de0bb9897c641a9ba6187',
    messagingSenderId: '112879024646',
    projectId: 'triptotravel-71d2c',
    storageBucket: 'triptotravel-71d2c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCXUHKROMMp0-zMZ46HNkaRDfZPZtb7BP4',
    appId: '1:112879024646:ios:6e1f8e07b6ab10d2ba6187',
    messagingSenderId: '112879024646',
    projectId: 'triptotravel-71d2c',
    storageBucket: 'triptotravel-71d2c.appspot.com',
    iosClientId: '112879024646-vj0iv3cioe4s8m4sg99ssklsff3bhkm8.apps.googleusercontent.com',
    iosBundleId: 'com.example.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCXUHKROMMp0-zMZ46HNkaRDfZPZtb7BP4',
    appId: '1:112879024646:ios:ee1fdbdd5d8a1cddba6187',
    messagingSenderId: '112879024646',
    projectId: 'triptotravel-71d2c',
    storageBucket: 'triptotravel-71d2c.appspot.com',
    iosClientId: '112879024646-v94g8512lmgph9hcih88bcg6c8csu229.apps.googleusercontent.com',
    iosBundleId: 'com.example.app.RunnerTests',
  );
}
