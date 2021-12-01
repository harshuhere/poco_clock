import 'package:flutter/material.dart';

class ShowAlarm extends StatefulWidget {
  const ShowAlarm({Key? key, this.payload}) : super(key: key);

  static const String routeName = '/showalarmpage';
  final String? payload;

  @override
  _ShowAlarmState createState() => _ShowAlarmState();
}

class _ShowAlarmState extends State<ShowAlarm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Text(
          "Alarm Page",
          style: TextStyle(
              color: Colors.black, fontSize: 50, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
