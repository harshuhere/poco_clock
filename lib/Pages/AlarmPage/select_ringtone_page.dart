import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';

class SelectRingtonePage extends StatefulWidget {
  const SelectRingtonePage({Key? key}) : super(key: key);

  @override
  _SelectRingtonePageState createState() => _SelectRingtonePageState();
}

class _SelectRingtonePageState extends State<SelectRingtonePage> {
  int griditemindex = 1;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 1.5;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
          child: Column(
        children: [
          Text(
            "Alarms",
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.w300),
          ),
          Expanded(
            child: GridView.count(
              primary: false,
              padding: EdgeInsets.all(10),
              childAspectRatio: (itemWidth / itemHeight),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              crossAxisCount: 2,
              children: <Widget>[
                _buildTitleWithToggle("Weather alarm", (value) {
                  setState(() {
                    griditemindex = value;
                  });
                }, "assets/weatherbg.jpg", 1),
                _buildTitleWithToggle("Nature alarm", (value) {
                  setState(() {
                    griditemindex = value;
                  });
                }, "assets/naturebg.jpg", 2),
                _buildTitleWithToggle("Morning dew", (value) {
                  setState(() {
                    griditemindex = value;
                  });
                }, "assets/morningdew.jpg", 3),
                _buildTitleWithToggle("Fireflies", (value) {
                  setState(() {
                    griditemindex = value;
                  });
                }, "assets/fireflies.jpg", 4),
                _buildTitleWithToggle("DayDream", (value) {
                  setState(() {
                    griditemindex = value;
                  });
                }, "assets/daydreambg.jpg", 5),
                _buildTitleWithToggle("Allringtones", (value) {
                  setState(() {
                    griditemindex = value;
                  });
                  AppSettings.openSoundSettings();
                }, "assets/weatherbg.jpg", 6),
              ],
            ),
          )
        ],
      )),
    );
  }

  InkWell _buildTitleWithToggle(
      String ringtoneName, Function ontap, String bgimgpath, int index) {
    return InkWell(
      onTap: () {
        ontap(index);
      },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          border: Border.all(
              color: griditemindex == index
                  ? Colors.lightBlue
                  : Colors.transparent,
              width: 3),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: ringtoneName == "Allringtones"
                ? Colors.blue
                : Colors.transparent,
            image: ringtoneName != "Allringtones"
                ? DecorationImage(
                    image: AssetImage("$bgimgpath"), fit: BoxFit.fill)
                : null,
            borderRadius: BorderRadius.all(Radius.circular(17)),
          ),
          padding: EdgeInsets.all(25),
          child: ringtoneName != "Allringtones"
              ? Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "$ringtoneName",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.notifications, color: Colors.white, size: 50),
                    Text(
                      "All ringtones",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
