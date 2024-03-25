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
    apiKey: 'AIzaSyCAfJMO3SFajzUPuEJfvpNDHcEY0wnMtx8',
    appId: '1:6674549621:web:0fc0481c7bc74d71ae613c',
    messagingSenderId: '6674549621',
    projectId: 'coralcart-cadc7',
    authDomain: 'coralcart-cadc7.firebaseapp.com',
    storageBucket: 'coralcart-cadc7.appspot.com',
    measurementId: 'G-RCPLMRVK9J',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJirW83oi8Bj2JeTIbBBKS6ZCQBKX9Tzg',
    appId: '1:6674549621:android:5388e0896e403164ae613c',
    messagingSenderId: '6674549621',
    projectId: 'coralcart-cadc7',
    storageBucket: 'coralcart-cadc7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAdddONy8iFei2JrFY9ndTJ4bymBuWSYZA',
    appId: '1:6674549621:ios:8a863d1b8af9f818ae613c',
    messagingSenderId: '6674549621',
    projectId: 'coralcart-cadc7',
    storageBucket: 'coralcart-cadc7.appspot.com',
    iosBundleId: 'com.example.coralcartseller',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAdddONy8iFei2JrFY9ndTJ4bymBuWSYZA',
    appId: '1:6674549621:ios:618bf998b3565a8cae613c',
    messagingSenderId: '6674549621',
    projectId: 'coralcart-cadc7',
    storageBucket: 'coralcart-cadc7.appspot.com',
    iosBundleId: 'com.example.coralcartseller.RunnerTests',
  );
}