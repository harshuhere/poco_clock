import 'package:clock_poco/Pages/TimerPage/lap_card.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(isLapHours: false);
  bool start = false;
  bool pause = false;
  bool reset = false;
  bool visibility = false;
  bool iconflagreset = false;
  final _scrollController = ScrollController();
  double widtH = 0;
  bool ispadding = false;

  @override
  void initState() {
    super.initState();
    _scrollController;
  }

  starTimer() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    setState(() {
      widtH = 60;
      iconflagreset = !iconflagreset;
    });
  }

  stopTimer() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    setState(() {
      iconflagreset = !iconflagreset;
    });
  }

  resetTimer() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    setState(() {
      ispadding = false;
      reset = !reset;
      start = false;
      visibility = false;
      iconflagreset = false;
      widtH = 0;
    });
  }

  lapTimer() {
    setState(() {
      ispadding = true;
    });
    _stopWatchTimer.onExecute.add(StopWatchExecute.lap);
    _stopWatchTimer.records.listen((value) {
      value.forEach((element) {
        print("------------------> ${element.displayTime}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding:
              ispadding ? EdgeInsets.only(top: 0) : EdgeInsets.only(top: 50),
          child: StreamBuilder<int>(
            stream: _stopWatchTimer.rawTime,
            initialData: 0,
            builder: (context, snap) {
              int value = snap.data!;
              final displayTime = StopWatchTimer.getDisplayTime(value);

              return Column(
                children: <Widget>[
                  Text(
                    displayTime,
                    style: TextStyle(
                        fontSize: 60,
                        color: Colors.white,
                        fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "Current timing",
                    style: TextStyle(
                        fontSize: 15,
                        color: start ? Colors.white : Colors.transparent,
                        fontWeight: FontWeight.w300),
                  ),
                  Container(
                    // color: Colors.red,
                    height: ispadding ? 370 : 290,
                    margin: EdgeInsets.all(2),
                    child: StreamBuilder<List<StopWatchRecord>>(
                      stream: _stopWatchTimer.records,
                      initialData: _stopWatchTimer.records.value,
                      builder: (context, snapshot) {
                        final value = snapshot.data;
                        if (value!.isEmpty) {
                          return Container();
                        }
                        Future.delayed(Duration(microseconds: 200), () {
                          _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: Duration(milliseconds: 100),
                              curve: Curves.easeOut);
                        });
                        return SingleChildScrollView(
                          child: ListView.builder(
                              shrinkWrap: true,
                              reverse: true,
                              physics: NeverScrollableScrollPhysics(),
                              controller: _scrollController,
                              itemBuilder: (context, index) {
                                final data = value[index];
                                // final differenceTime = data.displayTime -
                                //     data.displayTime.[index - 1];

                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 3, right: 3),
                                  child: LapCard(
                                    lapTime: data.displayTime,
                                    index: index + 1,
                                    differenceTime: data.displayTime,
                                  ),
                                );
                              },
                              itemCount: value.length),
                        );
                      },
                    ),
                  )
                ],
              );
            },
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            visibility
                ? Container(
                    margin: EdgeInsets.only(bottom: 35),
                    height: 60,
                    width: 60,
                    child: FloatingActionButton(
                      backgroundColor: Colors.grey[900],
                      onPressed: () {
                        setState(() {
                          reset = true;
                        });

                        iconflagreset ? lapTimer() : resetTimer();
                      },
                      child: Icon(
                        iconflagreset ? Icons.flag : Icons.stop,
                        color: Colors.lightBlue[700],
                        size: 40,
                      ),
                    ),
                  )
                : SizedBox(),
            SizedBox(
              width: widtH,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 35),
              height: 60,
              width: 60,
              child: FloatingActionButton(
                backgroundColor: Colors.grey[900],
                onPressed: () {
                  setState(() {
                    start = !start;
                    visibility = true;
                  });
                  start ? starTimer() : stopTimer();
                },
                child: Icon(
                  start ? Icons.pause : Icons.play_arrow,
                  color: Colors.lightBlue[700],
                  size: 40,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
    // Need to call dispose function.
  }
}
