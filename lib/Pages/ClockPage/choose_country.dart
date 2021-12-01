import 'package:clock_poco/Pages/ClockPage/worldTime.dart';
import 'package:clock_poco/service/alarm_sql_service.dart';
import 'package:clock_poco/service/sql_service.dart';
import 'package:flutter/material.dart';

class ChooseCountry extends StatefulWidget {
  const ChooseCountry({Key? key}) : super(key: key);

  @override
  _ChooseCountryState createState() => _ChooseCountryState();
}

class _ChooseCountryState extends State<ChooseCountry> {
  final _searchbarController = TextEditingController();
  WorldTime wt = WorldTime();
  String? offset;
  List<WorldTime> locations = [
    WorldTime(url: 'Europe/Vienna', location: 'Vienna', offsetdata: '+05:30'),
    WorldTime(url: 'Europe/Moscow', location: 'Moscow', offsetdata: '+05:30'),
    WorldTime(url: 'Indian/Cocos', location: 'Cocos', offsetdata: '+05:30'),
    WorldTime(
        url: 'ndian/Maldives', location: 'Maldives', offsetdata: '+05:30'),
    WorldTime(url: 'Pacific/Majuro', location: 'Majuro', offsetdata: '+05:30'),
    WorldTime(url: 'Asia/Karachi', location: 'Karachi', offsetdata: '+05:30'),
    WorldTime(
        url: 'Asia/Kuala_Lumpur',
        location: 'Kuala_Lumpur',
        offsetdata: '+05:30'),
    WorldTime(
        url: 'America/Yakutat', location: 'Yakutat', offsetdata: '+05:30'),
    WorldTime(
        url: 'America/Mexico_City',
        location: 'Mexico_City',
        offsetdata: '+05:30'),
    WorldTime(url: 'Asia/Kolkata', location: 'Kolkata', offsetdata: '+05:30'),
    WorldTime(url: 'Europe/London', location: 'London', offsetdata: '+05:30'),
    WorldTime(url: 'Europe/Berlin', location: 'Athens', offsetdata: '+05:30'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', offsetdata: '+05:30'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', offsetdata: '+05:30'),
    WorldTime(
        url: 'America/Chicago', location: 'Chicago', offsetdata: '+05:30'),
    WorldTime(
        url: 'America/New_York', location: 'New York', offsetdata: '+05:30'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', offsetdata: '+05:30'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', offsetdata: '+05:30'),
    WorldTime(url: 'America/Denver', location: 'Denver', offsetdata: '+05:30'),
    WorldTime(
        url: 'America/Metlakatla',
        location: 'Metlakatla',
        offsetdata: '+05:30'),
    WorldTime(
        url: 'America/Moncton', location: 'Moncton', offsetdata: '+05:30'),
    WorldTime(
        url: 'America/Phoenix', location: 'Phoenix', offsetdata: '+05:30'),
    WorldTime(url: 'Pacific/Tahiti', location: 'Tahiti', offsetdata: '+05:30'),
    WorldTime(url: 'Pacific/Wake', location: 'Wake', offsetdata: '+05:30'),
    WorldTime(
        url: 'Pacific/Honolulu', location: 'Honolulu', offsetdata: '+05:30'),
    WorldTime(url: 'Pacific/Chuuk', location: 'Chuuk', offsetdata: '+05:30'),
    WorldTime(url: 'Europe/Rome', location: 'Rome', offsetdata: '+05:30'),
    WorldTime(url: 'Europe/Oslo', location: 'Oslo', offsetdata: '+05:30'),
  ];

  Future<void> updateTime(index) async {
    Navigator.pop(context, index);
  }

  @override
  void initState() {
    super.initState();
    // setOffst();

    sortList();
  }

  sortList() {
    locations.sort((a, b) {
      dynamic tempa = a.location;
      dynamic tempb = b.location;
      return tempa.compareTo(tempb);
    });
  }

  // setOffset() async {
  //   String url1 = 'http://worldtimeapi.org/api/timezone/${wt.url}';
  //   Response response = await get(Uri.parse(url1));
  //   Map data = jsonDecode(response.body);
  //   offset = data['utc_offset'];
  // }

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
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 1.0, horizontal: 4.0),
                  child: Card(
                    child: ListTile(
                      tileColor: Colors.black,
                      onTap: () async {
                        // save world time
                        String cityName = locations[index].url.toString();
                        Map<String, Object> data = {'cityName': '$cityName'};
                        await SqlAlarmService()
                            .insertNewAlarm(data, SqlModel.tableWorldTime);

                        Navigator.pop(context, true);
                      },
                      title: Text(
                        locations[index].location!,
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      subtitle: Text(
                        "${locations[index].location!} GMT ${locations[index].offsetdata}",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ),
                );
              },
              itemCount: locations.length,
            ),
          ),
        ],
      ),
    );
  }
}
