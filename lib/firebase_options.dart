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
    apiKey: 'AIzaSyAM4baXYqH0pfhkKLKiiaaKVdLDJFFOX_A',
    appId: '1:315255166207:web:bffa9f4e001b9ae89fe8ca',
    messagingSenderId: '315255166207',
    projectId: 'flutter-mal',
    authDomain: 'flutter-mal.firebaseapp.com',
    storageBucket: 'flutter-mal.appspot.com',
    measurementId: 'G-3MLTKE0F6Z',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBXBHhl9J-bUaUip9eXmWAmgRAdcO7jmuY',
    appId: '1:315255166207:android:4ca957ca113907379fe8ca',
    messagingSenderId: '315255166207',
    projectId: 'flutter-mal',
    storageBucket: 'flutter-mal.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAcLUTSFl5cpIw-1z3uGrt3ofShNT_-Wms',
    appId: '1:315255166207:ios:3c7e9f758823f06b9fe8ca',
    messagingSenderId: '315255166207',
    projectId: 'flutter-mal',
    storageBucket: 'flutter-mal.appspot.com',
    iosBundleId: 'com.example.flutterMal',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAcLUTSFl5cpIw-1z3uGrt3ofShNT_-Wms',
    appId: '1:315255166207:ios:ef8486a7bd18c6589fe8ca',
    messagingSenderId: '315255166207',
    projectId: 'flutter-mal',
    storageBucket: 'flutter-mal.appspot.com',
    iosBundleId: 'com.example.flutterMal.RunnerTests',
  );
}