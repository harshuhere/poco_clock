import 'package:flutter/material.dart';

class ListAddRingTonesButton extends StatefulWidget {
  ListAddRingTonesButton({Key? key}) : super(key: key);

  @override
  _ListAddRingTonesButtonState createState() => _ListAddRingTonesButtonState();
}

class _ListAddRingTonesButtonState extends State<ListAddRingTonesButton> {
  List<List<dynamic>> listOfRingToneWidget = [];
  bool defaultt = true;
  bool forest = false;
  bool summerNight = false;
  bool summerRain = false;
  bool stoveFire = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildringtoneBtn(Icons.notifications, "Default",
              defaultt ? Colors.blue : Colors.grey, () {
            setState(() {
              defaultt = true;
              forest = false;
              summerNight = false;
              summerRain = false;
              stoveFire = false;
            });
          }),
          _buildringtoneBtn(
              Icons.park, "Forest", forest ? Colors.blue : Colors.grey, () {
            setState(() {
              defaultt = false;
              forest = true;
              summerNight = false;
              summerRain = false;
              stoveFire = false;
            });
          }),
          _buildringtoneBtn(Icons.nightlight, "Summer night",
              summerNight ? Colors.blue : Colors.grey, () {
            setState(() {
              defaultt = false;
              forest = false;
              summerNight = true;
              summerRain = false;
              stoveFire = false;
            });
          }),
          _buildringtoneBtn(Icons.cloud, "Summer rain",
              summerRain ? Colors.blue : Colors.grey, () {
            setState(() {
              defaultt = false;
              forest = false;
              summerNight = false;
              summerRain = true;
              stoveFire = false;
            });
          }),
          _buildringtoneBtn(Icons.local_fire_department_sharp, "Stove fire",
              stoveFire ? Colors.blue : Colors.grey, () {
            setState(() {
              defaultt = false;
              forest = false;
              summerNight = false;
              summerRain = false;
              stoveFire = true;
            });
          }),
        ],
      ),
    );
  }

  Padding _buildringtoneBtn(
      IconData icon, String txt, Color color, Function ontap) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
      child: Container(
        width: 80,
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          onPressed: () {
            ontap();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: color,
                size: 30,
              ),
              Text(txt, style: TextStyle(color: Colors.grey, fontSize: 10)),
            ],
          ),
        ),
      ),
    );
  }
}
