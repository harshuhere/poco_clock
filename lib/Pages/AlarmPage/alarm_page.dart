import 'package:clock_poco/Norifiction%20Services/notification_api.dart';
import 'package:clock_poco/Pages/AlarmPage/add_alarm_page.dart';
import 'package:clock_poco/model/alarm_model.dart';
import 'package:clock_poco/service/sql_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  bool switchValue = false;
  Future<List<AlarmModel>> getAllAlarm() async {
    final dbClient = await SqlModel().db;
    List<Map<String, Object?>> featureMessagelist =
        await dbClient.rawQuery("""SELECT  * from ${SqlModel.tableAlarms}""");
    List<AlarmModel> list = [];

    featureMessagelist.forEach((element) {
      list.add(AlarmModel.fromJson(element));
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: FutureBuilder(
                future: getAllAlarm(),
                builder: (context, AsyncSnapshot<List<AlarmModel>> snapshot) {
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
                              var arriveData =
                                  snapshot.data![index].time1.toString();

                              DateTime tempDate =
                                  new DateFormat("yyyy-MM-dd hh:mm:ss")
                                      .parse(arriveData);

                              final DateFormat formatter = DateFormat('hh:mm');
                              final String formatted =
                                  formatter.format(tempDate).toString();
                              final DateFormat formatterampm = DateFormat('a');
                              final String formattedwithampm =
                                  formatterampm.format(tempDate).toString();
                              final lable =
                                  snapshot.data![index].label.toString();
                              //
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  onLongPress: () {
                                    _showBottomSheet(
                                        snapshot.data![index].autoId);
                                  },
                                  title: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        formatted,
                                        style: TextStyle(
                                            color: snapshot.data![index]
                                                        .isEnable ==
                                                    "true"
                                                ? Colors.white
                                                : Colors.grey[700],
                                            fontSize: 35,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Text(
                                          formattedwithampm.toLowerCase(),
                                          style: TextStyle(
                                              color: snapshot.data![index]
                                                          .isEnable ==
                                                      "true"
                                                  ? Colors.white
                                                  : Colors.grey[700],
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      lable.isEmpty
                                          ? SizedBox()
                                          : Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 5),
                                              child: Container(
                                                width: 124,
                                                child: Text(
                                                  "  |  $lable",
                                                  style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: snapshot
                                                                  .data![index]
                                                                  .isEnable ==
                                                              "true"
                                                          ? Colors.white
                                                          : Colors.grey[700],
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                  subtitle: Text(
                                    " ${snapshot.data![index].repeat.toString()}",
                                    style: TextStyle(
                                        color: snapshot.data![index].isEnable ==
                                                "true"
                                            ? Colors.white
                                            : Colors.grey[700],
                                        fontWeight: FontWeight.w300),
                                  ),
                                  trailing: Switch(
                                      activeColor: Colors.lightBlue[900],
                                      inactiveTrackColor: Colors.grey[900],
                                      inactiveThumbColor: Colors.grey[700],
                                      value: snapshot.data![index].isEnable ==
                                              "true"
                                          ? true
                                          : false,
                                      onChanged: (value) {
                                        var tmp = value ? "true" : "false";
                                        updateAlarm(
                                            tmp, snapshot.data![index].autoId);
                                        // setState(() {
                                        //   switchValue = value;
                                        // });
                                      }),
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
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 60,
              width: 60,
              child: FloatingActionButton(
                backgroundColor: Colors.grey[900],
                onPressed: () async {
                  // NotificationApi.showNotification(
                  //     title: 'hello ',
                  //     body: 'test notification....',
                  //     payload: 'test.t');
                  //
                  // NotificationApi.showInsistentNotification(
                  //     body: 'What are you waiting for? cjb',
                  //     title: 'cjb',
                  //     payload: 'ex.e');
                  //
                  // try {
                  //   NotificationApi.showFullScreenNotification(
                  //     context: context,
                  //     title: "title",
                  //     body: "body",
                  //     scheduledDate: tz.TZDateTime.now(tz.local)
                  //         .add(const Duration(seconds: 10)),
                  //   );
                  // } catch (e) {
                  //   print(e.toString());
                  // }

                  var result = await Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => AddAlarmPage()));

                  if (result != null) {
                    setState(() {
                      getAllAlarm();
                    });
                  }
                },
                child: Icon(
                  Icons.add,
                  color: Colors.lightBlue[700],
                  size: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showBottomSheet(int? id) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: new Icon(Icons.delete),
                title: new Text('Delete'),
                onTap: () async {
                  final dbClient = await SqlModel().db;
                  List<
                      Map<String,
                          Object?>> featureMessagelist = await dbClient.rawQuery(
                      """DELETE from ${SqlModel.tableAlarms} WHERE auto_id = $id""");
                  setState(() {
                    getAllAlarm();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: new Icon(Icons.edit),
                title: new Text('Edit'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  updateAlarm(String data, int? id) async {
    final dbClient = await SqlModel().db;
    List<Map<String, Object?>> featureMessagelist = await dbClient.rawQuery(
        """UPDATE ${SqlModel.tableAlarms} SET isEnable = '$data' WHERE auto_id = $id""");
    setState(() {
      getAllAlarm();
    });
  }
}
