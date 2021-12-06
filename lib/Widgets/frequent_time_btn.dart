import 'package:clock_poco/service/sql_service.dart';
import 'package:clock_poco/service/sqlserviceforselectedtime.dart';
import 'package:flutter/material.dart';

class FrequentTimeBTN extends StatefulWidget {
  const FrequentTimeBTN({
    Key? key,
    required this.callback,
    required this.datastring,
    required this.arrivedData,
    // required this.onlongtap,
    required this.data,
    required this.ontapoftimebtn,
    // required this.onlongtapp,
    required this.tempTimeList,
    required this.timebtnbool,
  }) : super(key: key);

  final String arrivedData;
  final dynamic datastring;
  // final Function onlongtap;
  final Function ontapoftimebtn;
  final Function callback;
  final dynamic data;
  final List<dynamic> tempTimeList;
  // final Function onlongtapp;
  final bool timebtnbool;

  @override
  _FrequentTimeBTNState createState() => _FrequentTimeBTNState();
}

class _FrequentTimeBTNState extends State<FrequentTimeBTN> {
  bool timebtnbool = false;
  @override
  void initState() {
    super.initState();
    timebtnbool = widget.timebtnbool;
  }

  bool a = false;
  @override
  Widget build(BuildContext context) {
    return timebtnbool
        ? InkWell(
            onLongPress: () {
              // widget.onlongtapp();
              setState(() {
                timebtnbool = false;
              });
            },
            child: Container(
              margin: EdgeInsets.all(2),
              height: 80,
              width: 80,
              child: FloatingActionButton(
                backgroundColor: Colors.grey[900],
                onPressed: () async {
                  await DeleteSelectedTime()
                      .deleteSelectedTime(
                          widget.data, SqlModel.tablePickedTimeForStopwatch)
                      .whenComplete(() {
                    widget.callback();
                    setState(() {
                      for (int i = 0; i < widget.tempTimeList.length; i++) {
                        widget.tempTimeList[i] = false;
                      }
                    });
                  });
                },
                child: Text(
                  "Delete",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
          )
        : InkWell(
            onLongPress: () {
              // widget.onlongtap();
              if (widget.datastring != "+") {
                if (timebtnbool) {
                  setState(() {
                    timebtnbool = false;
                  });
                } else {
                  setState(() {
                    timebtnbool = true;
                  });
                }
              }
            },
            child: Container(
              margin: EdgeInsets.all(2),
              height: 80,
              width: 80,
              child: FloatingActionButton(
                backgroundColor: Colors.grey[900],
                onPressed: () {
                  // if (widget.arrivedData == "+") {
                  //   _showBottomSheet();
                  // }
                  widget.ontapoftimebtn();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.datastring,
                      style: TextStyle(
                          color: widget.arrivedData == "+"
                              ? Colors.grey[500]
                              : Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: widget.arrivedData == "+" ? 50 : 25),
                    ),
                    widget.arrivedData == "+"
                        ? SizedBox()
                        : Text(
                            "mins",
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w300,
                                fontSize: 10),
                          ),
                  ],
                ),
              ),
            ),
          );
  }

  // _showBottomSheet() {
  //   showModalBottomSheet(
  //       isScrollControlled: true,
  //       enableDrag: false,
  //       backgroundColor: Colors.grey[900],
  //       context: context,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(
  //           top: Radius.circular(20),
  //         ),
  //       ),
  //       builder: (context) {
  //         return Padding(
  //           padding: EdgeInsets.only(
  //               bottom: MediaQuery.of(context).viewInsets.bottom),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             mainAxisSize: MainAxisSize.min,
  //             children: <Widget>[
  //               Padding(
  //                 padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
  //                 child: Text(
  //                   "Frequent timer",
  //                   style: TextStyle(color: Colors.white, fontSize: 20),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 20,
  //               ),
  //               Container(
  //                 // padding: EdgeInsets.only(top: 50),
  //                 child: TimePickerSpinner(
  //                   alignment: Alignment.center,
  //                   time: DateTime(0, 0, 0, 0, 5, 0, 0),
  //                   is24HourMode: true,
  //                   isShowSeconds: false,
  //                   normalTextStyle: TextStyle(
  //                       fontSize: 24,
  //                       color: Colors.grey[700],
  //                       fontWeight: FontWeight.w300),
  //                   highlightedTextStyle: TextStyle(
  //                       fontSize: 38,
  //                       color: Colors.lightBlue[500],
  //                       fontWeight: FontWeight.w500),
  //                   spacing: 100,
  //                   itemHeight: 70,
  //                   isForce2Digits: true,
  //                   onTimeChange: (time) async {
  //                     String minutesofMinutes = DateFormat.m().format(time);
  //                     int minutes = int.parse(minutesofMinutes);

  //                     String minutesofHours = DateFormat.H().format(time);
  //                     int hours = int.parse(minutesofHours);

  //                     int finalhours = hours * 60;

  //                     int totalMinutes = minutes + finalhours;

  //                     print({
  //                       "selectedtime is ------>>>>>${widget.selectedtime}"
  //                     });
  //                   },
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 20,
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   _buildButtonForBottomSheet("Cancel", () {
  //                     Navigator.pop(context);
  //                   }),
  //                   _buildButtonForBottomSheet("OK", () async {
  //                     Map<String, Object> data = {
  //                       'timee1': widget.selectedtime.toString(),
  //                     };
  //                     if (widget.selectedtime != 0) {
  //                       try {
  //                         await SqlTimebtnService().insertNewTimebtn(
  //                             data, SqlModel.tablePickedTimeForStopwatch);
  //                       } catch (e) {
  //                         ScaffoldMessenger.of(context).clearSnackBars();
  //                         ScaffoldMessenger.of(context).showSnackBar(
  //                             SnackBar(content: Text(e.toString())));
  //                       }
  //                       print(
  //                           "time1------------------------->>>>>>>>>>>{$data}");
  //                       Navigator.pop(context, true);
  //                     }
  //                   }),
  //                 ],
  //               ),
  //               SizedBox(
  //                 height: 20,
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }

  // InkWell _buildButtonForBottomSheet(
  //   String btnname,
  //   Function ontap,
  // ) {
  //   return InkWell(
  //     onTap: () {
  //       ontap();
  //     },
  //     child: Container(
  //       height: 50,
  //       width: 150,
  //       decoration: BoxDecoration(
  //         color: btnname == "OK" ? Colors.lightBlue[500] : Colors.grey[800],
  //         // border: Border.all(
  //         //     color: Colors.black87.withOpacity(0.05)),
  //         borderRadius: BorderRadius.all(Radius.circular(50)),
  //       ),
  //       child: Center(
  //         child: Text(
  //           '$btnname',
  //           style: TextStyle(
  //               color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
