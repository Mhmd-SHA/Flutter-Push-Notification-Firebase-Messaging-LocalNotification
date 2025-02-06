import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  // Private constructor
  LocalNotificationService._internal();

  // Singleton instance
  static final LocalNotificationService _instance =
      LocalNotificationService._internal();

  // Factory constructor to return the same instance
  factory LocalNotificationService() => _instance;

  //notification packaghe
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final DarwinInitializationSettings _initializationSettingsIOS =
      DarwinInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: false,
    requestAlertPermission: false,
  );

  void initNotification() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: _initializationSettingsAndroid,
      iOS: _initializationSettingsIOS,
      macOS: null,
    );
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onDidReceiveBackgroundNotificationResponse:
      //     (NotificationResponse response) {
      //   log("payload: ${response.payload.toString()}");

      //   return;
      // },
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        log("payload: ${response.payload.toString()}");
        // try {
        //   log(payload.payload.toString());
        //   handleNotification(
        //       navigatorKey.currentContext!, jsonDecode(payload.payload ?? ""));
        //   log("payload: ${payload.toString()}");
        // } catch (e) {
        //   log("Exception: $e");
        // }
        return;
      },
    );
  }

  // show notification method
  void showNotification({
    required int id,
    required String title,
    required String message,
  }) {
    final AndroidNotificationChannel _channel =
        const AndroidNotificationChannel(
      'high_importance_channel',
      'Hight Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );
    log("Showing notification: $title - $message");

    _flutterLocalNotificationsPlugin.show(
        id,
        title,
        message,
        NotificationDetails(
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            channelDescription: _channel.description,
            icon: '@mipmap/ic_launcher',
          ),
        ));
  }
}
