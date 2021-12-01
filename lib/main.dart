import 'dart:isolate';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:clock_poco/Pages/AlarmPage/alarm_ring_page.dart';
import 'package:clock_poco/Pages/AlarmPage/show_alarm.dart';
import 'package:clock_poco/Pages/homepage.dart';
import 'package:clock_poco/service/sql_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void printHello() {
  final DateTime now = DateTime.now();
  final int isolateId = Isolate.current.hashCode;
  print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text(
  //         "[$now] Hello, world! isolate=${isolateId} function='$printHello'")));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = SqlModel();
  await db.initDb();
  var a = await db.creatingTables();
  print(a);

  String? initialRoute = HomePage.routeName;

  // alarm manager plus
  await AndroidAlarmManager.initialize();

  runApp(MyApp(initialRoute: initialRoute));

  // await AndroidAlarmManager.periodic(
  //     Duration(seconds: 5), helloAlarmID, printHello,
  //     wakeup: true);
}

class MyApp extends StatefulWidget {
  MyApp({Key? key, required this.initialRoute}) : super(key: key);
  final String initialRoute;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // initializeVariable();
    super.initState();
  }

  // initializeVariable() async {
  //   final int helloAlarmID = 0;
  //   await AndroidAlarmManager.periodic(
  //       Duration(seconds: 5), helloAlarmID, printHello,
  //       wakeup: true);
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: widget.initialRoute,
      routes: <String, WidgetBuilder>{
        HomePage.routeName: (context) => HomePage(),
        AlarmRingPage.routeName: (context) => AlarmRingPage(),
        ShowAlarm.routeName: (context) => ShowAlarm(),
      },
    );
  }
}

// void runAlarm() {
//   AndroidAlarmManager.oneShot(
//     Duration(seconds: 10),
//     0,
//     printHello,
//     wakeup: true,
//   ).then((val) => print(val));
// }

// void printHello() {
//   final DateTime now = DateTime.now();
//   final int isolateId = Isolate.current.hashCode;
//   print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
//   // ScaffoldMessenger.of(context).clearSnackBars();
//   // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//   //     content: Text(
//   //         "[$now] Hello, world! isolate=${isolateId} function='$printHello'")));
// }

// class MyApp extends StatelessWidget {
//   static final navigatorKey = new GlobalKey<NavigatorState>();

//   MyApp({Key? key, this.initialroute}) : super(key: key);

//   final String? initialroute;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//         primarySwatch: Colors.blue,
//       ),
//       // home: HomePage(),
//       initialRoute: initialroute,
//       routes: <String, WidgetBuilder>{
//         HomePage.routeName: (context) => HomePage(),
//         AlarmRingPage.routeName: (context) => AlarmRingPage(),
//         ShowAlarm.routeName: (context) => ShowAlarm(),
//       },
//       navigatorKey: navigatorKey,
//     );
//   }
// }
