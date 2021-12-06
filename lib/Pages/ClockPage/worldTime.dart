import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String? location; //location name of ui
  String? time; //the time in that location
  String? url;
  String? offsetdata; // location url for api endpoints
  bool? isDayTime; // true or false if daytime or not

  WorldTime({this.location, this.offsetdata, this.time, this.url});

  Future<void> getTime() async {
    try {
      String url1 = 'http://worldtimeapi.org/api/timezone/$url';

      //make request
      Response response = await get(Uri.parse(url1));
      Map data = jsonDecode(response.body);
      //print(data);
      // get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      offsetdata = data['utc_offset'].substring(1, 3);
      //print(datetime);
      // print(offset);

      //create a date time object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set time property
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Caught Error : $e');
      time = 'could not get time data ';
    }
  }
}
