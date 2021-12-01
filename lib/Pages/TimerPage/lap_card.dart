import 'package:flutter/material.dart';

class LapCard extends StatelessWidget {
  LapCard({Key? key, this.lapTime, this.differenceTime, this.index})
      : super(key: key);

  final String? lapTime;
  final String? differenceTime;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.flag,
                  color: Colors.grey[800],
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  "$index",
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w300,
                      fontSize: 22),
                ),
              ],
            ),
            Text(
              "$differenceTime",
              style: TextStyle(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w300,
                  fontSize: 22),
            ),
            Text(
              "$lapTime",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
