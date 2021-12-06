import 'package:clock_poco/Pages/ClockPage/choose_country.dart';
import 'package:flutter/material.dart';

class ClockPage extends StatefulWidget {
  ClockPage({Key? key}) : super(key: key);

  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              "Worlds clock List",
              style: TextStyle(color: Colors.amber),
            ),
          ),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: SelectedCity.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       return Padding(
          //         padding: const EdgeInsets.symmetric(
          //             vertical: 1.0, horizontal: 4.0),
          //         child: Card(
          //           child: ListTile(
          //             tileColor: Colors.black,
          //             onTap: () async {
          //               // save world time

          //               Navigator.pop(context, true);
          //             },
          //             title: Text(
          //               "cityName[index]",
          //               style: TextStyle(color: Colors.white, fontSize: 17),
          //             ),
          //             subtitle: Text(
          //               "cityName[index]",
          //               style: TextStyle(color: Colors.grey, fontSize: 12),
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          Expanded(
            flex: 1,
            child: Container(
              height: 60,
              width: 60,
              child: FloatingActionButton(
                backgroundColor: Colors.grey[900],
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => ChooseCountry()));
                },
                child: Icon(
                  Icons.add,
                  color: Colors.lightBlue[900],
                  size: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
