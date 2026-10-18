import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Generated template and project config for HabitPulse daily habit tracker.
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
          'you can reconfigure this by running the FlutterFire CLI.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA_habit_pulse_web_demo_key_987654',
    appId: '1:987654321012:web:9876543210abcdef',
    messagingSenderId: '987654321012',
    projectId: 'daily-habit-tracker-app',
    authDomain: 'daily-habit-tracker-app.firebaseapp.com',
    storageBucket: 'daily-habit-tracker-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA_habit_pulse_android_demo_key_987654',
    appId: '1:987654321012:android:9876543210abcdef',
    messagingSenderId: '987654321012',
    projectId: 'daily-habit-tracker-app',
    storageBucket: 'daily-habit-tracker-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA_habit_pulse_ios_demo_key_987654',
    appId: '1:987654321012:ios:9876543210abcdef',
    messagingSenderId: '987654321012',
    projectId: 'daily-habit-tracker-app',
    storageBucket: 'daily-habit-tracker-app.appspot.com',
    iosBundleId: 'com.example.dailyHabitTracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA_habit_pulse_macos_demo_key_987654',
    appId: '1:987654321012:ios:9876543210abcdef',
    messagingSenderId: '987654321012',
    projectId: 'daily-habit-tracker-app',
    storageBucket: 'daily-habit-tracker-app.appspot.com',
    iosBundleId: 'com.example.dailyHabitTracker',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA_habit_pulse_windows_demo_key_987654',
    appId: '1:987654321012:web:9876543210abcdef',
    messagingSenderId: '987654321012',
    projectId: 'daily-habit-tracker-app',
    storageBucket: 'daily-habit-tracker-app.appspot.com',
  );
}
