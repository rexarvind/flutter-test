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
    apiKey: 'AIzaSyC0Ya02B345ngAvH6bkpW2Dr1MDIkt7BBU',
    appId: '1:1053702216845:web:480764af63312c9b6f96c4',
    messagingSenderId: '1053702216845',
    projectId: 'rexwebmedia',
    databaseURL: 'https://rexwebmedia.firebaseio.com',
    storageBucket: 'rexwebmedia.appspot.com',
    authDomain: 'rexwebmedia.firebaseapp.com',
    measurementId: 'G-9TETJ7LCD7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC0Ya02B345ngAvH6bkpW2Dr1MDIkt7BBU',
    appId: '1:1053702216845:android:08e3d485a8e77dd66f96c4',
    messagingSenderId: '1053702216845',
    projectId: 'rexwebmedia',
    databaseURL: 'https://rexwebmedia.firebaseio.com',
    storageBucket: 'rexwebmedia.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: '',
    databaseURL: '',
    storageBucket: '',
    androidClientId: '',
    iosClientId: '',
    iosBundleId: '',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: '',
    databaseURL: '',
    storageBucket: '',
    androidClientId: '',
    iosClientId: '',
    iosBundleId: '',
  );
}
