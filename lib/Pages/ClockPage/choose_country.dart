import 'package:alphabet_list_scroll_view_fix/alphabet_list_scroll_view.dart';
import 'package:clock_poco/Pages/ClockPage/worldTime.dart';
import 'package:clock_poco/service/alarm_sql_service.dart';
import 'package:clock_poco/service/sql_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class ChooseCountry extends StatefulWidget {
  ChooseCountry({Key? key, required this.settime}) : super(key: key);
  Function settime;
  @override
  _ChooseCountryState createState() => _ChooseCountryState();
}

class _ChooseCountryState extends State<ChooseCountry> {
  final _searchbarController = TextEditingController();
  WorldTime wt = WorldTime();
  String? offset;

  /// for Alphabetical Scroll View
  List cityName = [];

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();

    gettime();
  }

  gettime() async {
    var locations = tz.timeZoneDatabase.locations;
    print(locations.length); // 429
    locations.keys.forEach((element) {
      var detroit = tz.getLocation(element);
      var currenttime = tz.TZDateTime.now(detroit);
      var offset = currenttime.timeZoneOffset.toString();
      var utcoffset = currenttime.timeZoneName +
          " " +
          offset.substring(0, offset.indexOf(":") + 3);
      print(utcoffset);

      String temp = element.toString();
      String finalcityname = temp.substring(temp.indexOf("/") + 1, temp.length);
      // print(finalcityname);
      // print(now);
      // if (currenttime.timeZoneName == "GMT") {
      cityName.add([finalcityname, element.toString(), utcoffset]);
      // }
    });
    // print(cityName);
    addTOstrList();
  }

  /// for Alphabetical Scroll View
  List<String> strList = [];
  List<String> strListForAlfaScroll = [];
  List<String> utcoffsetList = [];

  addTOstrList() {
    cityName.forEach((element) {
      // strList.add(element.toString());

      strListForAlfaScroll.add(element[0]);
      strList.add(element[1]);
      utcoffsetList.add(element[2]);
    });
    sortList();
    print(strList);
    print(strListForAlfaScroll);
    print(utcoffsetList);
  }

  sortList() {
    ///for arrangement of Aplphabetical scroll view's title and subtitle
    strList.sort((a, b) {
      dynamic tempa = a.substring(a.indexOf("/") + 1, a.length);
      dynamic tempb = b.substring(b.indexOf("/") + 1, b.length);
      return tempa.compareTo(tempb);
    });
    strListForAlfaScroll.sort((a, b) {
      dynamic tempa = a[0];
      dynamic tempb = b[0];
      return tempa.compareTo(tempb);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Select city",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            Text(
              "Time zones",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 60,
            padding: EdgeInsets.only(left: 15, right: 15, top: 15),
            child: TextFormField(
              controller: _searchbarController,
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
                  borderSide: BorderSide(color: Colors.black.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(50),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(50),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey[400],
                ),
                hintText: 'Search for country or city',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
          ),
          Expanded(
            child: AlphabetListScrollView(
              // itemCount: cityName.length,
              indexedHeight: (int) {
                return 70;
              },
              showPreview: true,
              keyboardUsage: true,
              normalTextStyle: TextStyle(color: Colors.white),
              highlightTextStyle: TextStyle(
                color: Colors.lightBlue,
              ),
              strList: strListForAlfaScroll,
              itemBuilder: (BuildContext context, int index) {
                // var value = strList[index].replaceAll("[", '');
                // value = value.replaceAll(']', '');
                // var title = value.split(",");
                // var title1 = title[1].replaceAll(' ', '');

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
                  child: Card(
                    child: ListTile(
                      tileColor: Colors.black,
                      onTap: () async {
                        // save world time
                        var detroit = tz.getLocation(strList[index]);
                        var currentTimeofSelectedCity =
                            tz.TZDateTime.now(detroit);
                        String dif = currentTimeofSelectedCity.toString();
                        String diff = dif.substring(dif.length - 5, dif.length);

                        print(strListForAlfaScroll[index]);

                        print("--------->>>>>>>>>>$currentTimeofSelectedCity");
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "${strListForAlfaScroll[index]} :- $currentTimeofSelectedCity")));
                        String formattedTime = DateFormat("h:mma")
                            .format(currentTimeofSelectedCity);

                        widget.settime(formattedTime, diff);
                        Map<String, Object> data = {
                          'selectedCityName':
                              strListForAlfaScroll[index].toString(),
                          'timeDifference': diff,
                        };
                        var a = await SqlAlarmService().insertNewAlarm(
                            data, SqlModel.tableWorldclockCityList);
                        print(a);

                        Navigator.pop(context, true);
                      },
                      title: Text(
                        strListForAlfaScroll[index],
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            strList[index],
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            utcoffsetList[index],
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
