// import 'package:flutter/material.dart';
// import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
// import 'package:intl/intl.dart';

// class FrequentTimerButton extends StatefulWidget {
//    FrequentTimerButton({ Key? key,this.tempList,this.arrivedata,this.arriveData }) : super(key: key);

// List<dynamic>? tempList;
// var arrivedata ;
// String? arriveData;
//   @override
//   _FrequentTimerButtonState createState() => _FrequentTimerButtonState();
// }

// class _FrequentTimerButtonState extends State<FrequentTimerButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: tempTimeList[index]
//                                                   ? Text("data",
//                                                       style: TextStyle(
//                                                         color: Colors.white,
//                                                         fontWeight:
//                                                             FontWeight.w300,
//                                                       ))
//                                                   : InkWell(
//                                                       onLongPress: () {
//                                                         if (snapshott
//                                                                 .data![index]
//                                                                 .time1 !=
//                                                             "+") {
//                                                           if (tempTimeList[
//                                                               index]) {
//                                                             setState(() {
//                                                               tempTimeList[
//                                                                       index] =
//                                                                   false;
//                                                             });
//                                                           } else {
//                                                             setState(() {
//                                                               tempTimeList[
//                                                                   index] = true;
//                                                             });
//                                                           }
//                                                         }
//                                                       },
//                                                       child: Container(
//                                                         margin:
//                                                             EdgeInsets.all(2),
//                                                         height: 80,
//                                                         width: 80,
//                                                         child:
//                                                             FloatingActionButton(
//                                                           backgroundColor:
//                                                               Colors.grey[900],
//                                                           onPressed: () {
//                                                             if (arrivedData ==
//                                                                 "+") {
//                                                               _showBottomSheet();
//                                                             }
//                                                           },
//                                                           child: Column(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .center,
//                                                             children: [
//                                                               Text(
//                                                                 snapshott
//                                                                     .data![
//                                                                         index]
//                                                                     .time1
//                                                                     .toString(),
//                                                                 style: TextStyle(
//                                                                     color: arrivedData ==
//                                                                             "+"
//                                                                         ? Colors.grey[
//                                                                             500]
//                                                                         : Colors
//                                                                             .white,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w300,
//                                                                     fontSize:
//                                                                         arrivedData ==
//                                                                                 "+"
//                                                                             ? 50
//                                                                             : 25),
//                                                               ),
//                                                               arrivedData == "+"
//                                                                   ? SizedBox()
//                                                                   : Text(
//                                                                       "mins",
//                                                                       style: TextStyle(
//                                                                           color: Colors.grey[
//                                                                               500],
//                                                                           fontWeight: FontWeight
//                                                                               .w300,
//                                                                           fontSize:
//                                                                               10),
//                                                                     ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     );,
//     );
//   }
//    _showBottomSheet() {
//     showModalBottomSheet(
//         isScrollControlled: true,
//         enableDrag: false,
//         backgroundColor: Colors.grey[900],
//         context: context,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             top: Radius.circular(20),
//           ),
//         ),
//         builder: (context) {
//           return Padding(
//             padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
//                   child: Text(
//                     "Frequent timer",
//                     style: TextStyle(color: Colors.white, fontSize: 20),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   // padding: EdgeInsets.only(top: 50),
//                   child: TimePickerSpinner(
//                     alignment: Alignment.center,
//                     time: DateTime(0, 0, 0, 0, 5, 0, 0),
//                     is24HourMode: true,
//                     isShowSeconds: false,
//                     normalTextStyle: TextStyle(
//                         fontSize: 24,
//                         color: Colors.grey[700],
//                         fontWeight: FontWeight.w300),
//                     highlightedTextStyle: TextStyle(
//                         fontSize: 38,
//                         color: Colors.lightBlue[500],
//                         fontWeight: FontWeight.w500),
//                     spacing: 100,
//                     itemHeight: 70,
//                     isForce2Digits: true,
//                     onTimeChange: (time) {
//                       String minutesofMinutes = DateFormat.m().format(time);
//                       int minutes = int.parse(minutesofMinutes);

//                       String minutesofHours = DateFormat.H().format(time);
//                       int hours = int.parse(minutesofHours);

//                       int finalhours = hours * 60;

//                       int totalMinutes = minutes + finalhours;

//                       setState(() {
//                         selectedtime = totalMinutes;
//                       });

//                       print({"selectedtime is ------>>>>>$selectedtime"});
//                     },
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     _buildButtonForBottomSheet("Cancel", () {
//                       Navigator.pop(context);
//                     }),
//                     _buildButtonForBottomSheet("OK", () async {
//                       Map<String, Object> data = {
//                         'timee1': selectedtime.toString(),
//                       };
//                       if (selectedtime != 0) {
//                         try {
//                           await SqlTimebtnService().insertNewTimebtn(
//                               data, SqlModel.tablePickedTimeForStopwatch);
//                         } catch (e) {
//                           ScaffoldMessenger.of(context).clearSnackBars();
//                           ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text(e.toString())));
//                         }
//                         print(
//                             "time1------------------------->>>>>>>>>>>{$data}");
//                         Navigator.pop(context, true);
//                         setState(() {});
//                       }

//                       // var temp = tempTimeList.firstWhere(
//                       //     (element) => element == "${selectedtime}");

//                       // if (temp == selectedtime.toString()) {
//                       //   ScaffoldMessenger.of(context).clearSnackBars();
//                       //   ScaffoldMessenger.of(context).showSnackBar(
//                       //       SnackBar(content: Text("already added")));
//                       // } else {
//                       //   try {
//                       //     await SqlTimebtnService().insertNewTimebtn(
//                       //         data, SqlModel.tablePickedTimeForStopwatch);
//                       //   } catch (e) {
//                       //     ScaffoldMessenger.of(context).clearSnackBars();
//                       //     ScaffoldMessenger.of(context).showSnackBar(
//                       //         SnackBar(content: Text(e.toString())));
//                       //   }
//                       // }
//                     }),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//               ],
//             ),
//           );
//         });
//   }

//   InkWell _buildButtonForBottomSheet(
//     String btnname,
//     Function ontap,
//   ) {
//     return InkWell(
//       onTap: () {
//         ontap();
//       },
//       child: Container(
//         height: 50,
//         width: 150,
//         decoration: BoxDecoration(
//           color: btnname == "OK" ? Colors.lightBlue[500] : Colors.grey[800],
//           // border: Border.all(
//           //     color: Colors.black87.withOpacity(0.05)),
//           borderRadius: BorderRadius.all(Radius.circular(50)),
//         ),
//         child: Center(
//           child: Text(
//             '$btnname',
//             style: TextStyle(
//                 color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),
//           ),
//         ),
//       ),
//     );
//   }
// }