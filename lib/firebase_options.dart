// lib/firebase_options.dart

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      // 필요한 경우 다른 플랫폼 추가
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not set for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAspFR9RNhf5gQe4t_DyKuh8FX2B3Fe7VT',
    authDomain: 'watersavingchallenge.firebaseapp.com',
    projectId: 'watersavingchallenge',
    storageBucket: 'watersavingchallenge.appspot.com',
    messagingSenderId: '252990048363',
    appId: '1:252990048363:web:3135d3d5972f191de25492e',
    measurementId: 'G-NPDD2BS6WT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAspFR9RNhf5gQe4t_DyKuh8FX2B3Fe7VT',
    appId: '1:252990048363:android:00cb0e518f17762325492e',
    messagingSenderId: '252990048363',
    projectId: 'watersavingchallenge',
    storageBucket: 'watersavingchallenge.appspot.com',
  );
}
