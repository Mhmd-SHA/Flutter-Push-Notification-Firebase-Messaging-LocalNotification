import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_push_notification_app_test/firebase_options.dart';
import 'package:firebase_push_notification_app_test/home_page.dart';
import 'package:firebase_push_notification_app_test/services/firebase_notification_service.dart';
import 'package:firebase_push_notification_app_test/services/local_notification_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseNotificationService().initNotification();
  LocalNotificationService().initNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Push Notification Demo',
      home: HomePage(),
    );
  }
}
