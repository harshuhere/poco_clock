import 'dart:async';

import 'package:clock_poco/Pages/ClockPage/choose_country.dart';
import 'package:clock_poco/Pages/ClockPage/currenttime_widget.dart';
import 'package:clock_poco/Pages/ClockPage/custom%20widgets/clock_view.dart';
import 'package:clock_poco/model/worldclock_model.dart';
import 'package:clock_poco/service/sql_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockPage extends StatefulWidget {
  ClockPage({Key? key, required this.cityNames}) : super(key: key);
  List cityNames = [];
  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  Future<List<SelectedCityModel>> getAllCityNames() async {
    final dbClient = await SqlModel().db;
    List<Map<String, Object?>> featureMessagelist = await dbClient
        .rawQuery("""SELECT  * from ${SqlModel.tableWorldclockCityList}""");
    List<SelectedCityModel> list = [];

    featureMessagelist.forEach((element) {
      list.add(SelectedCityModel.fromJson(element));
    });
    return list;
  }

  String? timeofcity;
  String? timediff;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CurrentTimeWidget(),
          Expanded(
            child: FutureBuilder(
                future: getAllCityNames(),
                builder:
                    (context, AsyncSnapshot<List<SelectedCityModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      // isSelectedList = [];
                      // snapshot.data!.images!.forEach((element) {
                      //   isSelectedList.add([false, element.id, element.path]);
                      // });
                      print("--------------------response--------------");
                      // print(snapshot.data.isEmpty);
                      if (snapshot.data!.isEmpty) {
                        return Center(
                            child: Text(
                          "There is no alarms",
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w300,
                              fontSize: 20),
                        ));
                      } else {
                        return Center(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              var cityName = snapshot
                                  .data![index].selectedCityName
                                  .toString();
                              var timedif =
                                  snapshot.data![index].timeDifference;

                              //
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  onLongPress: () {},
                                  leading: ClockView(hour: 6),
                                  title: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        cityName,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(
                                    "$timedif",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  trailing: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "$timeofcity",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 27,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Text(
                                        "10 Dec pm",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    }
                    if (snapshot.hasError) {
                      return Text(snapshot.hasError.toString());
                    } else {
                      return Text("Something went wrong");
                    }
                  } else {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }),
            // ListView.builder(
            //   itemCount: widget.cityNames.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     return Padding(
            //       padding: const EdgeInsets.symmetric(
            //           vertical: 1.0, horizontal: 4.0),
            //       child: Card(
            //         child: ListTile(
            //           tileColor: Colors.black,
            //           onTap: () async {
            //             // save world time

            //             Navigator.pop(context, true);
            //           },
            //           leading: ClockView(hour: 10),
            //           title: Text(
            //             "${widget.cityNames[index]}",
            //             style: TextStyle(color: Colors.white, fontSize: 17),
            //           ),
            //           subtitle: Text(
            //             "${widget.cityNames[index]}",
            //             style: TextStyle(color: Colors.grey, fontSize: 12),
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // ),
          ),
          Container(
            height: 60,
            width: 60,
            child: FloatingActionButton(
              backgroundColor: Colors.grey[900],
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => ChooseCountry(settime: setTime)));
              },
              child: Icon(
                Icons.add,
                color: Colors.lightBlue[900],
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }

  setTime(String timeofCity, String timeDiff) {
    if (mounted) {
      setState(() {
        timeofcity = timeofCity;
        timediff = timeDiff;
      });
    }
  }
}
