import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class ClockView extends StatefulWidget {
  ClockView({
    Key? key,
    required this.hour,
  }) : super(key: key);

  double hour;

  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    // _load();
    Timer.periodic(Duration(seconds: 1), (timer) {
      // playLocal();
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  AudioPlayer audioPlayer = AudioPlayer();
  // String? mp3Uri;
  // Future _load() async {
  //   final ByteData data = await rootBundle.load('assets/ticktock.wav');
  //   Directory tempDir = await getTemporaryDirectory();
  //   File tempFile = File('${tempDir.path}/ticktock.wav');
  //   await tempFile.writeAsBytes(data.buffer.asUint8List(), flush: true);
  //   mp3Uri = tempFile.uri.toString();
  //   print('finished loading, uri=$mp3Uri');
  // }

  // playLocal() async {
  //   var result = await audioPlayer.play("$mp3Uri", isLocal: true, volume: 0.01);
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(hour: widget.hour, minute: 00),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  ClockPainter({required this.hour, required this.minute});

  var datetime = DateTime.now();
  double hour = double.parse("${DateTime.now().hour}");
  double minute = double.parse("${DateTime.now().minute}");
  var second = DateTime.now().second;
  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);
    //brushes
    var fillBrush = Paint()..color = Colors.white;
    // var outlineBrush = Paint()
    //   ..color = Colors.black
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 1;
    var centerdotBrush = Paint()..color = Colors.black;
    var hourBrush = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    var minuteBrush = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    var secondBrush = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    //canvases
    canvas.drawCircle(center, radius, fillBrush);
    // canvas.drawCircle(center, radius, outlineBrush);

    var hourhandX = centerX + 15 * cos((hour * 30 + hour * 0.5) * pi / 180);
    var hourhandY = centerX + 15 * sin((hour * 30 + hour * 0.5) * pi / 180);
    if (hour == 3 || hour == 15) {
      print("xhand :-$hourhandX,yhand :-$hourhandY");
    }
    canvas.drawLine(center, Offset(hourhandX, hourhandY), hourBrush);

    var minutehandX = centerX + 20 * cos(minute * 6 * pi / 180);
    var minutehandY = centerX + 20 * sin(minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minutehandX, minutehandY), minuteBrush);

    var secondhandX = centerX + 22 * cos(second * 6 * pi / 180);
    var secondhandY = centerX + 22 * sin(second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secondhandX, secondhandY), secondBrush);

    canvas.drawCircle(center, 4, centerdotBrush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
