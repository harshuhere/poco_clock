import 'package:flutter/material.dart';

class AdditionalSettings extends StatefulWidget {
  const AdditionalSettings({Key? key}) : super(key: key);

  @override
  _AdditionalSettingsState createState() => _AdditionalSettingsState();
}

class _AdditionalSettingsState extends State<AdditionalSettings> {
  bool firsttogglebtnvalue = false;
  bool secondtogglebtnvalue = false;
  bool thirdtogglebtnvalue = false;
  bool fourthtogglebtnvalue = false;
  String selectedVolumebuttonAction = "Do nothing";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.black,
                expandedHeight: 150.0,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Additional alarm settings",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Column(
            children: [
              _buildRow("Vibrate when alarm goes off", "", firsttogglebtnvalue,
                  (value) {
                setState(() {
                  firsttogglebtnvalue = value;
                });
              }),
              _buildRow(
                  "Shutdown alarm",
                  "Shutdown alarm will go off at least 10\nminutes after you power off your device",
                  secondtogglebtnvalue, (value) {
                setState(() {
                  secondtogglebtnvalue = value;
                });
              }),
              _buildRow("Ascending volume", "Alarm volume rises gradually",
                  thirdtogglebtnvalue, (value) {
                setState(() {
                  thirdtogglebtnvalue = value;
                });
              }),
              _buildRow(
                  "Notification before ringing",
                  "Show notifications before alarm go off",
                  fourthtogglebtnvalue, (value) {
                setState(() {
                  fourthtogglebtnvalue = value;
                });
              }),
              _buildItemsWithRow(
                "Snooze",
                (TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                )),
                "Every 10 mins\nGo off 3 times",
                (TextStyle(
                  color: Colors.grey[600],
                  fontSize: 13,
                )),
                "Snooze",
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
              _buildItemsWithRow(
                "Volume buttons",
                (TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                )),
                "$selectedVolumebuttonAction",
                (TextStyle(
                  color: Colors.grey[600],
                  fontSize: 13,
                )),
                "Assigns functions for the Power and\nVolume +/- buttons",
                (TextStyle(
                  color: Colors.grey[600],
                  fontSize: 13,
                )),
                () {},
                Icon(
                  Icons.access_time,
                  color: Colors.grey[700],
                ),
              )
            ],
          ),
        ));
  }

  Padding _buildRow(
      String maintxt, String subtxt, bool switchValue, Function callBack) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                maintxt,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                subtxt,
                style: TextStyle(
                    color: maintxt == "Vibrate when alarm goes off"
                        ? Colors.transparent
                        : Colors.grey[600],
                    fontSize: maintxt == "Vibrate when alarm goes off" ? 1 : 14,
                    fontWeight: FontWeight.w300),
              ),
            ],
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

  Padding _buildItemsWithRow(
      String maintxt,
      TextStyle txtstyle,
      String sidetxt,
      TextStyle sidetxtstyle,
      String lowertxtx,
      TextStyle lowettextstyle,
      Function onPressed,
      Icon icon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 6, 0, 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$maintxt", style: txtstyle),
              maintxt == "Snooze"
                  ? SizedBox()
                  : Text("$lowertxtx", style: lowettextstyle),
            ],
          ),
          Row(
            children: [
              Text("$sidetxt", style: sidetxtstyle),
              maintxt == "Snooze"
                  ? IconButton(
                      onPressed: () {
                        onPressed();
                      },
                      icon: icon)
                  : PopupMenuButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      padding: EdgeInsets.all(5.0),
                      color: Colors.grey[900],
                      itemBuilder: (context) {
                        var list = <PopupMenuEntry<Object>>[];
                        list.add(PopupMenuItem(
                          child: Text("Do nothing"),
                          textStyle: TextStyle(color: Colors.white),
                          value: 1,
                        ));

                        list.add(PopupMenuItem(
                          child: Text("Snooze"),
                          value: 2,
                          textStyle: TextStyle(color: Colors.white),
                        ));

                        list.add(PopupMenuItem(
                          child: Text("Dismiss"),
                          value: 3,
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
                                selectedVolumebuttonAction = "Do nothing";
                              });
                            }
                            break;
                          case 2:
                            {
                              setState(() {
                                selectedVolumebuttonAction = "Snooze";
                              });
                            }
                            break;
                          case 3:
                            {
                              setState(() {
                                selectedVolumebuttonAction = "Dismiss";
                              });
                            }
                            break;
                        }
                        print("value of popupmenu is - $value");
                      },
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
