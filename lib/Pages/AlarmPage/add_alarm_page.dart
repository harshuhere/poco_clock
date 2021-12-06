import 'package:clock_poco/Norifiction%20Services/notification_api.dart';
import 'package:clock_poco/Pages/AlarmPage/select_ringtone_page.dart';
import 'package:clock_poco/Widgets/bottom_sheet.dart';
import 'package:clock_poco/service/alarm_sql_service.dart';
import 'package:clock_poco/service/sql_service.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class AddAlarmPage extends StatefulWidget {
  const AddAlarmPage({Key? key}) : super(key: key);

  @override
  _AddAlarmPageState createState() => _AddAlarmPageState();
}

class _AddAlarmPageState extends State<AddAlarmPage> {
  bool firsttogglebtnvalue = false;
  bool secondtogglebtnvalue = false;
  int bottomsheetindex = 0;
  int bottomsheetindexcustom = 0;
  String repeatType = "Once";
  String customType = "";
  String lable = "";
  bool weekdayselected = false;
  DateTime? selectedTime;
  final _labelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            size: 30,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              Map<String, Object> data = {
                'time1': selectedTime.toString(),
                'ringtone': 'defualt',
                'isEnable': 'true',
                'repeat': 'once',
                'vibrate': firsttogglebtnvalue ? 'true' : 'false',
                'delete1': secondtogglebtnvalue ? 'true' : 'false',
                'label': lable,
              };
              await SqlAlarmService()
                  .insertNewAlarm(data, SqlModel.tableAlarms);
              final currentTime = DateTime.now();
              int diff_sc =
                  await currentTime.difference(selectedTime!).inSeconds;

              diff_sc = diff_sc.abs();
              print("-----------difffff>>>>>>>$diff_sc");

              //notification method
              // try {
              //   NotificationApi.showFullScreenNotification(
              //     // context: context,
              //     title: "title",
              //     body: "body",
              //     scheduledDate: tz.TZDateTime.now(tz.local)
              //         .add(Duration(seconds: diff_sc)),
              //   );
              // } catch (e) {
              //   print(e.toString());
              // }

              Navigator.pop(context, true);
            },
            icon: Icon(
              Icons.done,
              size: 30,
            ),
          ),
        ],
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Add alarm",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Alarm in 23 hours 59 minutes",
              style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w300,
                  fontSize: 15),
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // time picker
            TimePickerSpinner(
              alignment: Alignment.center,
              is24HourMode: false,
              isShowSeconds: false,
              normalTextStyle: TextStyle(
                  fontSize: 24,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w300),
              highlightedTextStyle: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
              spacing: 50,
              itemHeight: 80,
              itemWidth: MediaQuery.of(context).size.width * 0.17,
              isForce2Digits: true,
              onTimeChange: (time) {
                setState(() {
                  selectedTime = time;
                });
                print(time);
              },
            ),
            Column(
              children: [
                _buildTitleWithoutToggle("Ringtone", "Default ringtone", () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => SelectRingtonePage()));
                }),
                _buildTitleWithoutToggle("Repeat",
                    repeatType == "Custom" ? "$customType" : "$repeatType", () {
                  _buildBottomSheet();
                }),
                _buildTitleWithToggle(
                    "Vibrate when alarm sounds", firsttogglebtnvalue, (value) {
                  setState(() {
                    firsttogglebtnvalue = value;
                  });
                }),
                _buildTitleWithToggle(
                    "Delete after goes off", secondtogglebtnvalue, (value) {
                  setState(() {
                    secondtogglebtnvalue = value;
                  });
                }),
                _buildTitleWithoutToggle("Lable", "", () {
                  _showBottomSheet();
                }),
              ],
            )
          ],
        ),
      ),
    );
  }

  Padding _buildTitleWithoutToggle(
      String mainText, String secondText, VoidCallback ontap) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        onTap: ontap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$mainText",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w300),
            ),
            Row(
              children: [
                Text(
                  "$secondText",
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                      fontWeight: FontWeight.w300),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[700],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildTitleWithToggle(
      String mainText, bool switchValue, Function callBack) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$mainText",
            style: TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.w300),
          ),
          Switch(
              activeColor: Colors.lightBlue[900],
              inactiveTrackColor: Colors.grey[700],
              inactiveThumbColor: Colors.grey[400],
              value: switchValue,
              onChanged: (value) {
                callBack(value);
              }),
        ],
      ),
    );
  }

  _buildBottomSheet() {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.black,
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          ),
          // color: Colors.grey[900],
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBottomSheetTitle(1, "Once", (value) {
                setState(() {
                  bottomsheetindex = value;
                  repeatType = "Once";
                });
                Navigator.pop(context);
              }),
              Divider(
                height: 5,
                color: Colors.black,
              ),
              _buildBottomSheetTitle(2, "Daily", (value) {
                setState(() {
                  bottomsheetindex = value;
                  repeatType = "Daily";
                });
                Navigator.pop(context);
              }),
              Divider(
                height: 5,
                color: Colors.black,
              ),
              _buildBottomSheetTitle(3, "Mon to Fri", (value) {
                setState(() {
                  bottomsheetindex = value;
                  repeatType = "Mon to Fri";
                });
                Navigator.pop(context);
              }),
              Divider(
                height: 5,
                color: Colors.black,
              ),
              _buildBottomSheetTitle(4, "Custom", (value) {
                setState(() {
                  bottomsheetindex = value;
                  repeatType = "Custom";
                });
                _buildBottomSheetofCustom();
              }),
            ],
          ),
        );
      },
    );
  }

  _buildBottomSheetofCustom() async {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.black,
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      ),
      builder: (BuildContext context) {
        return BottomSheet(
            backgroundColor: Colors.transparent,
            onClosing: () {},
            builder: (BuildContext context) {
              return StatefulBuilder(builder: (BuildContext context, setState) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                  ),
                  // color: Colors.grey[900],
                  height: 590,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Repeat",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _buildBottomSheetTitleForCustom(
                        1,
                        "Monday",
                        (value) {
                          setState(() {
                            weekdayselected = value;
                            customType = "Monday";
                          });
                        },
                        weekdayselected,
                      ),
                      Divider(
                        height: 5,
                        color: Colors.black,
                      ),
                      _buildBottomSheetTitleForCustom(
                        2,
                        "Tuesday",
                        (value) {
                          setState(() {
                            weekdayselected = value;
                            customType = "Tuesday";
                          });
                        },
                        weekdayselected,
                      ),
                      Divider(
                        height: 5,
                        color: Colors.black,
                      ),
                      _buildBottomSheetTitleForCustom(
                        3,
                        "Wednesday",
                        (value) {
                          setState(() {
                            weekdayselected = value;
                            customType = "Wednesday";
                          });
                        },
                        weekdayselected,
                      ),
                      Divider(
                        height: 5,
                        color: Colors.black,
                      ),
                      _buildBottomSheetTitleForCustom(
                        4,
                        "Thursday",
                        (value) {
                          setState(() {
                            weekdayselected = value;
                            customType = "Thursday";
                          });
                        },
                        weekdayselected,
                      ),
                      Divider(
                        height: 5,
                        color: Colors.black,
                      ),
                      _buildBottomSheetTitleForCustom(
                        2,
                        "Friday",
                        (value) {
                          setState(() {
                            weekdayselected = value;
                            customType = "Friday";
                          });
                        },
                        weekdayselected,
                      ),
                      Divider(
                        height: 5,
                        color: Colors.black,
                      ),
                      _buildBottomSheetTitleForCustom(
                        2,
                        "Saturday",
                        (value) {
                          setState(() {
                            weekdayselected = value;
                            customType = "Saturday";
                          });
                        },
                        weekdayselected,
                      ),
                      Divider(
                        height: 5,
                        color: Colors.black,
                      ),
                      _buildBottomSheetTitleForCustom(
                        2,
                        "Sunday",
                        (value) {
                          setState(() {
                            weekdayselected = value;
                            customType = "Sunday";
                          });
                        },
                        weekdayselected,
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
                          _buildButtonForBottomSheet("OK", () {}),
                        ],
                      )
                    ],
                  ),
                );
              });
            });
      },
    );
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
            borderRadius: BorderRadius.all(Radius.circular(50))),
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

  BottomSheetWidget _buildBottomSheetTitleForCustom(
    int index,
    String mainText,
    Function ontap,
    bool value,
  ) {
    return BottomSheetWidget(
        value: value,
        index: index,
        mainText: mainText,
        ontap: ontap,
        bottomsheetindexcustom: bottomsheetindexcustom);
  }

  Padding _buildBottomSheetTitle(int index, String mainText, Function ontap) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          ontap(index);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$mainText",
              style: TextStyle(
                  color: bottomsheetindex == index
                      ? Colors.lightBlue
                      : Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w300),
            ),
            Icon(
              Icons.done,
              size: 30,
              color: bottomsheetindex == index
                  ? Colors.lightBlue
                  : Colors.transparent,
            )
          ],
        ),
      ),
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
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
                  child: Text(
                    "Add alarm label",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Container(
                  height: 70,
                  padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: TextFormField(
                    autofocus: false,
                    controller: _labelController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    validator: (value) {},
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFf161616),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Enter label',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
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
                    _buildButtonForBottomSheet("OK", () {
                      setState(() {
                        lable = _labelController.text.toString();
                      });
                      Navigator.pop(context);
                      print("lable is : ------------>$lable");
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
}
