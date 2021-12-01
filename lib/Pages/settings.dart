import 'package:app_settings/app_settings.dart';
import 'package:clock_poco/Pages/AlarmPage/select_ringtone_page.dart';
import 'package:clock_poco/Pages/additionalsetting.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String selectedSilenceTime = "Never";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.black,
              expandedHeight: 120.0,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  "Settings",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ];
        },
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildItems(
                  "CLOCK SETTINGS",
                  (TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                      fontWeight: FontWeight.w300)),
                ),
                _buildItemsWithRow(
                  "Edit system time",
                  (TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )),
                  "Privacy Policy",
                  (TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )),
                  () {
                    AppSettings.openDateSettings();
                  },
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[700],
                  ),
                ),
                Divider(
                  height: 50,
                  color: Colors.grey[900],
                ),
                _buildItems(
                  "GENERAL SETTINGS",
                  (TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                      fontWeight: FontWeight.w300)),
                ),
                _buildItemsWithRow(
                  "Alarm ringtone",
                  (TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )),
                  "Weather alarm",
                  (TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                  )),
                  () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => SelectRingtonePage()));
                  },
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[700],
                  ),
                ),
                _buildItemsWithRow(
                  "Timer ringtone",
                  (TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )),
                  "Timer",
                  (TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                  )),
                  () {},
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[700],
                  ),
                ),
                _buildItemsWithRowAndColumn(
                  "Ringtone volume",
                  (TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )),
                  "Set ringtone volume for alarms and timers",
                  (TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  )),
                  "Timer",
                  (TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                  )),
                  () {
                    _showBottomSheet();
                  },
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[700],
                  ),
                ),
                _buildItemsWithRowAndColumn(
                  "Auto-silence",
                  (TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )),
                  "Set time after which alarms and \ntimers will be silenced",
                  (TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  )),
                  "$selectedSilenceTime",
                  (TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                  )),
                  () {
                    // _buildDropDown();
                  },
                  Icon(
                    Icons.access_time,
                    color: Colors.grey[700],
                  ),
                ),
                _buildItemsWithRow(
                  "Additional alarm settings",
                  (TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )),
                  "Privacy Policy",
                  (TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )),
                  () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => AdditionalSettings()));
                  },
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[700],
                  ),
                ),
                Divider(
                  height: 50,
                  color: Colors.grey[900],
                ),
                _buildItems(
                  "ADDITIONAL SETTINGS",
                  (TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                      fontWeight: FontWeight.w300)),
                ),
                _buildItemsWithRow(
                  "Privacy Policy",
                  (TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )),
                  "Privacy Policy",
                  (TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )),
                  () {},
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildItems(String maintxt, TextStyle txtstyle) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),
      child: Text("$maintxt", style: txtstyle),
    );
  }

  Padding _buildItemsWithRow(String maintxt, TextStyle txtstyle, String sidetxt,
      TextStyle sidetxtstyle, Function onPressed, Icon icon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 6, 0, 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$maintxt", style: txtstyle),
          Row(
            children: [
              sidetxt == "Additional alarm settings" ||
                      sidetxt == "Privacy Policy"
                  ? SizedBox()
                  : Text("$sidetxt", style: sidetxtstyle),
              IconButton(
                  onPressed: () {
                    onPressed();
                  },
                  icon: icon),
            ],
          ),
        ],
      ),
    );
  }

  Padding _buildItemsWithRowAndColumn(
      String maintxt,
      TextStyle txtstyle,
      String lowertxt,
      TextStyle lowertxtstyle,
      String sidetxt,
      TextStyle sidetxtstyle,
      Function onPressed,
      Icon icon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 0, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$maintxt", style: txtstyle),
              SizedBox(
                height: 4,
              ),
              Text("$lowertxt", style: lowertxtstyle),
            ],
          ),
          Row(
            children: [
              maintxt == "Auto-silence"
                  ? Text("$sidetxt", style: sidetxtstyle)
                  : SizedBox(),
              maintxt == "Auto-silence"
                  ? PopupMenuButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      padding: EdgeInsets.all(5.0),
                      color: Colors.grey[900],
                      itemBuilder: (context) {
                        var list = <PopupMenuEntry<Object>>[];
                        list.add(PopupMenuItem(
                          child: Text("Never"),
                          textStyle: TextStyle(color: Colors.white),
                          value: 1,
                        ));

                        list.add(PopupMenuItem(
                          child: Text("1 minute"),
                          value: 2,
                          textStyle: TextStyle(color: Colors.white),
                        ));

                        list.add(PopupMenuItem(
                          child: Text("5 minutes"),
                          value: 3,
                          textStyle: TextStyle(color: Colors.white),
                        ));

                        list.add(PopupMenuItem(
                          child: Text("10 minutes"),
                          value: 4,
                          textStyle: TextStyle(color: Colors.white),
                        ));

                        list.add(PopupMenuItem(
                          child: Text("15 minutes"),
                          value: 5,
                          textStyle: TextStyle(color: Colors.white),
                        ));

                        list.add(PopupMenuItem(
                          child: Text("20 minutes"),
                          value: 6,
                          textStyle: TextStyle(color: Colors.white),
                        ));

                        list.add(PopupMenuItem(
                          child: Text("25 minutes"),
                          value: 7,
                          textStyle: TextStyle(color: Colors.white),
                        ));

                        list.add(PopupMenuItem(
                          child: Text("30 minutes"),
                          value: 8,
                          textStyle: TextStyle(color: Colors.white),
                        ));

                        return list;
                      },
                      icon: Icon(
                        Icons.timer_sharp,
                        size: 20,
                        color: Colors.grey,
                      ),
                      onSelected: (value) {
                        switch (value) {
                          case 1:
                            {
                              setState(() {
                                selectedSilenceTime = "Never";
                              });
                            }
                            break;
                          case 2:
                            {
                              setState(() {
                                selectedSilenceTime = "1 minute";
                              });
                            }
                            break;
                          case 3:
                            {
                              setState(() {
                                selectedSilenceTime = "5 minutes";
                              });
                            }
                            break;
                          case 4:
                            {
                              setState(() {
                                selectedSilenceTime = "10 minutes";
                              });
                            }
                            break;
                          case 5:
                            {
                              setState(() {
                                selectedSilenceTime = "15 minutes";
                              });
                            }
                            break;
                          case 6:
                            {
                              setState(() {
                                selectedSilenceTime = "20 minutes";
                              });
                            }
                            break;
                          case 7:
                            {
                              setState(() {
                                selectedSilenceTime = "25 minutes";
                              });
                            }
                            break;
                          case 8:
                            {
                              setState(() {
                                selectedSilenceTime = "30 minutes";
                              });
                            }
                            break;
                        }

                        print("value of popupmenu is - $value");
                      },
                    )
                  : IconButton(
                      onPressed: () {
                        onPressed();
                      },
                      icon: icon),
            ],
          )
        ],
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
          return BottomSheetWidget();
        });
  }
}

class BottomSheetWidget extends StatefulWidget {
  BottomSheetWidget({Key? key}) : super(key: key);

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  double _value = 80;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
            child: Text(
              "Ringtone volume",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Container(
            height: 70,
            padding: EdgeInsets.only(left: 15, right: 15, top: 15),
            child: SfSlider(
              min: 0.0,
              max: 100.0,
              value: _value,
              interval: 20,
              showTicks: false,
              showLabels: false,
              enableTooltip: false,
              minorTicksPerInterval: 1,
              onChanged: (dynamic value) {
                setState(() {
                  _value = value;
                });
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
              _buildButtonForBottomSheet("OK", () {
                setState(() {});
                Navigator.pop(context);
                print("lable is : ------------>");
              }),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
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
}
