
/// main.dart file for full screen notification

// import 'dart:io';

// import 'package:clock_poco/Norifiction%20Services/received_notification.dart';
// import 'package:clock_poco/Pages/AlarmPage/alarm_ring_page.dart';
// import 'package:clock_poco/Pages/AlarmPage/show_alarm.dart';
// import 'package:clock_poco/Pages/homepage.dart';
// import 'package:clock_poco/service/sql_service.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:rxdart/subjects.dart';
// import 'package:timezone/data/latest.dart' as tz;

// // FlutterLocalNotificationsPlugin localNotificationsPlugin =
// //     FlutterLocalNotificationsPlugin();

// // Future onSelectNotification(String? payload) async {
// //   await Navigator.push(
// //     MyApp.navigatorKey.currentState!.context,
// //     MaterialPageRoute<void>(
// //       builder: (BuildContext context) => AlarmRingPage(payload: payload),
// //     ),
// //   );
// // }
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// String selectedNotificationPayload = "abc.s";
// final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
//     BehaviorSubject<ReceivedNotification>();
// final BehaviorSubject<String?> selectNotificationSubject =
//     BehaviorSubject<String?>();

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final db = SqlModel();
//   await db.initDb();
//   var a = await db.creatingTables();
//   print(a);

//   final NotificationAppLaunchDetails? notificationAppLaunchDetails = !kIsWeb &&
//           Platform.isLinux
//       ? null
//       : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

//   String? initialRoute = HomePage.routeName;
//   if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
//     selectedNotificationPayload = notificationAppLaunchDetails!.payload!;
//     initialRoute = ShowAlarm.routeName;
//   }

//   //notifications initialization

//   try {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('appicon');
//     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();

//     const MacOSInitializationSettings initializationSettingsMacOS =
//         MacOSInitializationSettings(
//       requestAlertPermission: false,
//       requestBadgePermission: false,
//       requestSoundPermission: false,
//     );

//     IOSInitializationSettings initializationSettingsIOS =
//         IOSInitializationSettings(
//             requestAlertPermission: false,
//             requestBadgePermission: false,
//             requestSoundPermission: false,
//             onDidReceiveLocalNotification: (
//               int id,
//               String? title,
//               String? body,
//               String? payload,
//             ) async {
//               didReceiveLocalNotificationSubject.add(
//                 ReceivedNotification(
//                   id: id,
//                   title: title,
//                   body: body,
//                   payload: payload,
//                 ),
//               );
//             });
//     tz.initializeTimeZones();

//     final LinuxInitializationSettings initializationSettingsLinux =
//         LinuxInitializationSettings(
//       defaultActionName: 'Open notification',
//       defaultIcon: AssetsLinuxIcon('icons/appicon.png'),
//     );

//     InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//       macOS: initializationSettingsMacOS,
//       linux: initializationSettingsLinux,
//     );

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: (String? payload) async {
//       if (payload != null) {
//         debugPrint('notification payload: $payload');
//       }
//       selectedNotificationPayload = "$payload";
//       selectNotificationSubject.add(payload);
//     });
//   } catch (e) {
//     print(e.toString());
//   }

//   runApp(
//     MaterialApp(
//       initialRoute: initialRoute,
//       routes: <String, WidgetBuilder>{
//         HomePage.routeName: (context) => HomePage(
//             notificationAppLaunchDetails: notificationAppLaunchDetails),
//         AlarmRingPage.routeName: (context) => AlarmRingPage(),
//         ShowAlarm.routeName: (context) =>
//             ShowAlarm(payload: selectedNotificationPayload),
//       },
//     ),
//   );
//   // await AndroidAlarmManager.periodic(
//   //     Duration(seconds: 5), helloAlarmID, printHello,
//   //     wakeup: true);
// }

// // void runAlarm() {
// //   AndroidAlarmManager.oneShot(
// //     Duration(seconds: 10),
// //     0,
// //     printHello,
// //     wakeup: true,
// //   ).then((val) => print(val));
// // }

// // void printHello() {
// //   final DateTime now = DateTime.now();
// //   final int isolateId = Isolate.current.hashCode;
// //   print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
// //   // ScaffoldMessenger.of(context).clearSnackBars();
// //   // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //   //     content: Text(
// //   //         "[$now] Hello, world! isolate=${isolateId} function='$printHello'")));
// // }

// // class MyApp extends StatelessWidget {
// //   static final navigatorKey = new GlobalKey<NavigatorState>();

// //   MyApp({Key? key, this.initialroute}) : super(key: key);

// //   final String? initialroute;

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         visualDensity: VisualDensity.adaptivePlatformDensity,
// //         primarySwatch: Colors.blue,
// //       ),
// //       // home: HomePage(),
// //       initialRoute: initialroute,
// //       routes: <String, WidgetBuilder>{
// //         HomePage.routeName: (context) => HomePage(),
// //         AlarmRingPage.routeName: (context) => AlarmRingPage(),
// //         ShowAlarm.routeName: (context) => ShowAlarm(),
// //       },
// //       navigatorKey: navigatorKey,
// //     );
// //   }
// // }
