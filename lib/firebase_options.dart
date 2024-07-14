import 'package:firebase_core/firebase_core.dart';

class DefaultafirebaseOptions{
  static FirebaseOptions get currentPlatform{
    return andriod;
  }

  static const FirebaseOptions andriod = FirebaseOptions(
    apiKey: "AIzaSyDN_RPLGENd291rDcD5dHsf080YeP09U_4",
    appId: "1:333018249688:android:6ef8cbab1c31f991ba5aad",
    messagingSenderId: "333018249688",
    projectId:  "chat-b7775",
    storageBucket: "chat-b7775.appspot.com"
  );
}