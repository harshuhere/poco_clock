import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final notifications = FlutterLocalNotificationsPlugin();

  static Future notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails('channel id', 'channel name',
          channelDescription: 'channel description',
          priority: Priority.high,
          importance: Importance.high,
          fullScreenIntent: true),
      iOS: IOSNotificationDetails(),
    );
  }

  static void showFullScreenNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    // required BuildContext context,
    required DateTime scheduledDate,
  }) async =>
      notifications.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(scheduledDate, tz.local),
          await notificationDetails(),
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true);
}
