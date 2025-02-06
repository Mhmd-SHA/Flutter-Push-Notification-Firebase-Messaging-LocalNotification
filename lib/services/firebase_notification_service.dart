import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_push_notification_app_test/services/local_notification_service.dart';

class FirebaseNotificationService {
  //instance of firebase cloud messaging
  final firebaseMessaging = FirebaseMessaging.instance;
  final LocalNotificationService notificationService =
      LocalNotificationService();

  //init function to initialize cloud messaging
  Future<void> initNotification() async {
    //request notification permission
    NotificationSettings settings = await firebaseMessaging.requestPermission();

    // notification access granted
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
      //fetch FCM token for this device
      final fcmTOKEN = await firebaseMessaging.getToken();
      log(fcmTOKEN.toString());
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        log('Message data: ${message.data}');
        if (message.notification != null) {
          notificationService.showNotification(
              id: message.notification.hashCode,
              title: message.notification?.title ?? "",
              message: message.notification?.body ?? "");
          log('Message also contained a notification: ${message.notification!.title}');
        }
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        log('Message clicked! ${message.messageId}');
      });

      //background message handler
      FirebaseMessaging.onBackgroundMessage(messageHandler);
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User denied permission');
    }
  }

  @pragma('vm:entry-point')
  static Future<void> messageHandler(RemoteMessage message) async {
    log('background message ${message.notification!.body}');
    //  Fluttertoast.showToast(
    //       msg:  message.notification!.title.toString() + "\n" + message.notification!.body.toString(),
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       timeInSecForIosWeb: 1,
    //        backgroundColor: Colors.greenAccent,
    //       textColor: Colors.white,
    //       fontSize: 16.0
    //   );
  }
}
