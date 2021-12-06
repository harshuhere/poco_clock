import 'package:audioplayers/audioplayers.dart';
import 'package:clock_poco/Widgets/frequent_time_btn.dart';
import 'package:clock_poco/Widgets/listaddringtones.dart';
import 'package:clock_poco/model/timepickedforTimer_model.dart';
import 'package:clock_poco/service/pickedtimebtn_sql_service.dart';
import 'package:clock_poco/service/sql_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';
import 'package:simple_timer/simple_timer.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  bool start = false;
  bool menu = false;
  bool tones = false;
  bool icontoggle = false;
  // late Duration selectedtime;
  int selectedtime = 5;
  int indexofitem = 0;
  // select time variables
  int hour = 0;
  int minute = 10;
  // counter minutes varialble
  int countminutes = 5;
  //timer variables
  late TimerController _timerController;
  TimerStyle _timerStyle = TimerStyle.ring;
  TimerProgressIndicatorDirection _progressIndicatorDirection =
      TimerProgressIndicatorDirection.clockwise;
  TimerProgressTextCountDirection _progressTextCountDirection =
      TimerProgressTextCountDirection.count_down;

  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();

  void onEnd() {
    print('onEnd');
  }

  Future<List<TimepickedforTimerModel>>? _future;

  @override
  void initState() {
    _timerController = TimerController(this);
    _scrollController;
    _future = getallTimes();
    super.initState();
  }

  Future<List<TimepickedforTimerModel>> getallTimes() async {
    final dbClient = await SqlModel().db;
    List<Map<String, Object?>> featureMessagelist = await dbClient
        .rawQuery("""SELECT  * from ${SqlModel.tablePickedTimeForStopwatch}""");
    List<TimepickedforTimerModel> list = [];

    featureMessagelist.forEach((element) {
      list.add(TimepickedforTimerModel.fromJson(element));
    });
    return list;
  }

  List<bool> tempTimeList = [];

  methodToPass() {
    setState(() {
      // getallTimes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        start
            ? Stack(
                children: [
                  Container(
                    height: 250,
                    width: 250,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: SimpleTimer(
                      displayProgressText: true,
                      duration: Duration(minutes: countminutes),
                      controller: _timerController,
                      timerStyle: _timerStyle,
                      onStart: handleTimerOnStart,
                      onEnd: handleTimerOnEnd,
                      valueListener: timerValueChangeListener,
                      backgroundColor: Colors.grey,
                      progressIndicatorColor: Colors.lightBlue,
                      progressIndicatorDirection: _progressIndicatorDirection,
                      progressTextCountDirection: _progressTextCountDirection,
                      progressTextStyle:
                          TextStyle(color: Colors.white, fontSize: 50),
                      strokeWidth: 10,
                    ),
                  ),
                  Positioned(
                    left: 79,
                    top: 160,
                    child: Text(
                      "Total 2 minutes",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              )
            : Container(
                padding: EdgeInsets.only(top: 50),
                child: TimePickerSpinner(
                  alignment: Alignment.center,
                  time: DateTime(0, 0, 0, hour, minute, 0, 0),
                  is24HourMode: true,
                  isShowSeconds: true,
                  normalTextStyle: TextStyle(
                      fontSize: 24,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w300),
                  highlightedTextStyle: TextStyle(
                      fontSize: 38,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                  spacing: 50,
                  itemHeight: 100,
                  itemWidth: MediaQuery.of(context).size.width * 0.17,
                  isForce2Digits: true,
                  onTimeChange: (time) {
                    print(time);
                    // setState(() {
                    //   countminutes = int.parse(time.toString());
                    // });
                    // setState(() {
                    //   selectedtime = time;
                    // });
                    // print("selected time is :${selectedtime}");
                    // ScaffoldMessenger.of(context)
                    //     .showSnackBar(SnackBar(content: Text("$time")));
                  },
                ),
              ),
        Column(
          children: [
            menu
                ? Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10.0),
                            height: 100,
                            child: FutureBuilder(
                              future: getallTimes(),
                              // _future,
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<TimepickedforTimerModel>>
                                      snapshott) {
                                if (snapshott.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshott.hasData) {
                                    print(
                                        "-------------response positive --------");

                                    if (snapshott.data!.length >
                                        tempTimeList.length) {
                                      var tempindex = snapshott.data!.length -
                                          tempTimeList.length;

                                      print("tempindex  $tempindex");
                                      for (int i = 0; i < tempindex; i++) {
                                        tempTimeList.add(false);
                                      }
                                    }

                                    if (snapshott.data!.isEmpty) {
                                      // ScaffoldMessenger.of(context).showSnackBar(
                                      //     SnackBar(
                                      //         content: Text("Data is Empty")));
                                      return Container(
                                        margin: EdgeInsets.all(2),
                                        height: 80,
                                        width: 80,
                                        child: FloatingActionButton(
                                          heroTag: "floatingButton1",
                                          backgroundColor: Colors.grey[900],
                                          onPressed: () async {
                                            _showBottomSheet();
                                          },
                                          child: Text(
                                            "+",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 50,
                                                fontWeight: FontWeight.w200),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Center(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                snapshott.data!.length + 1,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              if (index ==
                                                  snapshott.data!.length) {
                                                return Container(
                                                  margin: EdgeInsets.all(2),
                                                  height: 80,
                                                  width: 80,
                                                  child: FloatingActionButton(
                                                    heroTag: "floatingButton3",
                                                    backgroundColor:
                                                        Colors.grey[900],
                                                    onPressed: () async {
                                                      _showBottomSheet();
                                                    },
                                                    child: Text(
                                                      "+",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 50,
                                                          fontWeight:
                                                              FontWeight.w200),
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                var arrivedData = snapshott
                                                    .data![index].time1;
                                                print(
                                                    "arrivedata is --------------$arrivedData");

                                                snapshott.data!.sort((a, b) {
                                                  var tempa = a.time1;
                                                  var tempb = b.time1;
                                                  if (!tempa!.contains("+") &&
                                                      !tempb!.contains("+")) {
                                                    int x = int.parse("$tempa");
                                                    int y = int.parse("$tempb");
                                                    return x.compareTo(y);
                                                  } else {
                                                    return 0;
                                                  }
                                                });

                                                return FrequentTimeBTN(
                                                  callback: methodToPass,
                                                  ontapoftimebtn: () {
                                                    print(
                                                        "Selected time is ${snapshott.data}");
                                                  },
                                                  timebtnbool:
                                                      tempTimeList[index],
                                                  arrivedData: "$arrivedData",
                                                  datastring: snapshott
                                                      .data![index].time1
                                                      .toString(),
                                                  // selectedtime: selectedtime,
                                                  // setstate: (totalMinutes) {
                                                  //   setState(() {
                                                  //     selectedtime =
                                                  //         totalMinutes;
                                                  //   });
                                                  // },
                                                  // onlongtap: () {
                                                  //   if (snapshott.data![index]
                                                  //           .time1 !=
                                                  //       "+") {
                                                  //     if (tempTimeList[index]) {
                                                  //       setState(() {
                                                  //         tempTimeList[index] =
                                                  //             false;
                                                  //       });
                                                  //     } else {
                                                  //       setState(() {
                                                  //         tempTimeList[index] =
                                                  //             true;
                                                  //       });
                                                  //     }
                                                  //   }
                                                  // },
                                                  data: snapshott
                                                      .data![index].time1,
                                                  // onlongtapp: () {
                                                  //   setState(() {
                                                  //     tempTimeList[index] =
                                                  //         false;
                                                  //   });
                                                  // },
                                                  tempTimeList: [tempTimeList],
                                                );
                                              }
                                            }),
                                      );
                                    }
                                  }
                                  if (snapshott.hasError) {
                                    return Text(snapshott.hasError.toString());
                                  } else {
                                    return Text("Something went Wrong",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ));
                                  }
                                } else {
                                  return Container(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          )),
                    ],
                  )
                // ListAddTimeButton(
                //     timeforselecttimebtn: "10",
                //   )
                : tones
                    ? ListAddRingTonesButton()
                    : SizedBox(),
            start
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 35),
                        height: 60,
                        width: 60,
                        child: FloatingActionButton(
                          heroTag: "floatingButton2",
                          backgroundColor: Colors.grey[900],
                          onPressed: () {
                            setState(() {
                              start = false;
                              _timerController.reset();
                            });
                          },
                          child: Icon(
                            Icons.stop,
                            color: Colors.lightBlue[500],
                            size: 40,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 35),
                        height: 60,
                        width: 60,
                        child: FloatingActionButton(
                          heroTag: "floatingButton4",
                          backgroundColor: Colors.grey[900],
                          onPressed: () {
                            setState(() {
                              icontoggle = !icontoggle;
                            });
                            setState(() {
                              icontoggle
                                  ? _timerController.pause()
                                  : _timerController.start();
                            });
                          },
                          child: Icon(
                            icontoggle ? Icons.play_arrow : Icons.pause,
                            color: Colors.lightBlue[500],
                            size: 40,
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 35),
                        height: 40,
                        width: 40,
                        child: FloatingActionButton(
                          heroTag: "floatingButton5",
                          backgroundColor:
                              tones ? Colors.lightBlue[700] : Colors.grey[900],
                          onPressed: () {
                            setState(() {
                              menu = false;
                              tones = !tones;
                            });
                          },
                          child: Icon(
                            Icons.audiotrack,
                            color: tones ? Colors.white : Colors.grey[700],
                            size: 20,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 35),
                        height: 60,
                        width: 60,
                        child: FloatingActionButton(
                          heroTag: "floatingButton6",
                          backgroundColor: Colors.grey[900],
                          onPressed: () {
                            setState(() {
                              tones = false;
                              menu = false;
                              start = true;

                              Future.delayed(Duration(milliseconds: 23), () {
                                if (!_timerController.isAnimating) {
                                  _timerController.start();
                                }
                              });
                            });
                          },
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.lightBlue[500],
                            size: 40,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 35),
                        height: 40,
                        width: 40,
                        child: FloatingActionButton(
                          heroTag: "floatingButton7",
                          backgroundColor:
                              menu ? Colors.lightBlue[700] : Colors.grey[900],
                          onPressed: () {
                            setState(() {
                              tones = false;
                              menu = !menu;
                            });
                          },
                          child: Icon(
                            Icons.menu,
                            color: menu ? Colors.white : Colors.grey[700],
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ],
    );
  }

  _showBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: false,
        backgroundColor: Colors.grey[900],
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
                  child: Text(
                    "Frequent timer",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  // padding: EdgeInsets.only(top: 50),
                  child: TimePickerSpinner(
                    alignment: Alignment.center,
                    time: DateTime(0, 0, 0, 0, 5, 0, 0),
                    is24HourMode: true,
                    isShowSeconds: false,
                    normalTextStyle: TextStyle(
                        fontSize: 24,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w300),
                    highlightedTextStyle: TextStyle(
                        fontSize: 38,
                        color: Colors.lightBlue[500],
                        fontWeight: FontWeight.w500),
                    spacing: 100,
                    itemHeight: 70,
                    itemWidth: MediaQuery.of(context).size.width * 0.17,
                    isForce2Digits: true,
                    onTimeChange: (time) {
                      String minutesofMinutes = DateFormat.m().format(time);
                      int minutes = int.parse(minutesofMinutes);

                      String minutesofHours = DateFormat.H().format(time);
                      int hours = int.parse(minutesofHours);

                      int finalhours = hours * 60;

                      int totalMinutes = minutes + finalhours;

                      String durationToString(int minutes) {
                        var d = Duration(minutes: minutes);
                        List<String> parts = d.toString().split(':');
                        return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
                      }

                      String selectedtimeinhours =
                          durationToString(totalMinutes);
                      String hourss = selectedtimeinhours.substring(
                          0, selectedtimeinhours.indexOf(':'));
                      String minutess = selectedtimeinhours.substring(
                          selectedtimeinhours.indexOf(':'),
                          selectedtimeinhours.length);
                      minutess = minutess.replaceAll(":", "");

                      setState(() {
                        hour = int.parse(hourss);
                        minute = int.parse(minutess);
                        selectedtime = totalMinutes;
                      });

                      print({"selectedtime is ------>>>>>$selectedtime"});
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButtonForBottomSheet("Cancel", () {
                      Navigator.pop(context);
                    }),
                    _buildButtonForBottomSheet("OK", () async {
                      Map<String, Object> data = {
                        'timee1': selectedtime.toString(),
                      };
                      if (selectedtime != 0) {
                        try {
                          await SqlTimebtnService().insertNewTimebtn(
                              data, SqlModel.tablePickedTimeForStopwatch);
                        } catch (e) {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())));
                        }
                        print(
                            "time1------------------------->>>>>>>>>>>{$data}");
                        Navigator.pop(context, true);
                        setState(() {});
                      }

                      // var temp = tempTimeList.firstWhere(
                      //     (element) => element == "${selectedtime}");

                      // if (temp == selectedtime.toString()) {
                      //   ScaffoldMessenger.of(context).clearSnackBars();
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //       SnackBar(content: Text("already added")));
                      // } else {
                      //   try {
                      //     await SqlTimebtnService().insertNewTimebtn(
                      //         data, SqlModel.tablePickedTimeForStopwatch);
                      //   } catch (e) {
                      //     ScaffoldMessenger.of(context).clearSnackBars();
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //         SnackBar(content: Text(e.toString())));
                      //   }
                      // }
                    }),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        });
  }

  InkWell _buildButtonForBottomSheet(
    String btnname,
    Function ontap,
  ) {
    return InkWell(
      onTap: () {
        ontap();
      },
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
          color: btnname == "OK" ? Colors.lightBlue[500] : Colors.grey[800],
          // border: Border.all(
          //     color: Colors.black87.withOpacity(0.05)),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: Center(
          child: Text(
            '$btnname',
            style: TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }

  void timerValueChangeListener(Duration timeElapsed) {}

  void handleTimerOnStart() {
    print("timer has just started");
  }

  void handleTimerOnEnd() {
    print("timer has ended");
  }

  @override
  void dispose() {
    super.dispose();
    // Need to call dispose function.
    _timerController.dispose();
  }
}
