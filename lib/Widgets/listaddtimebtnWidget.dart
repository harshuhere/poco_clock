import 'package:flutter/material.dart';

class ListAddTimeButton extends StatefulWidget {
  ListAddTimeButton({Key? key, required this.timeforselecttimebtn})
      : super(key: key);
  final String timeforselecttimebtn;
  @override
  _ListAddTimeButtonState createState() => _ListAddTimeButtonState();
}

class _ListAddTimeButtonState extends State<ListAddTimeButton> {
  List<List<dynamic>> listOfTimeWidget = [];
  // List<bool>
  int indexofitem = 0;

  @override
  void initState() {
    super.initState();
    listOfTimeWidget.add([0, false]);
    listOfTimeWidget.add([1, false]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 400,
      height: 100,
      child: ListView.builder(
          reverse: true,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: listOfTimeWidget.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return _buildView(index);
          }),
    );
  }

  _buildView(int index) {
    if (index == 0) {
      return _buildtimeAddbtn();
    } else {
      return _buildtimeValuebtn(index);
    }
  }

  GestureDetector _buildtimeValuebtn(int index) {
    return GestureDetector(
      onTap: () {
        if (listOfTimeWidget[index][1] == true) {
          print(index);
          setState(() {
            listOfTimeWidget.removeAt(index);
          });
        }
      },
      onLongPress: () {
        setState(() {
          if (listOfTimeWidget[index][1] == true) {
            // listOfTimeWidget =
            //     listOfTimeWidget.map((e) => e[1] = false).toList();
            listOfTimeWidget[index][1] = false;
          } else {
            listOfTimeWidget.forEach((e) {
              e[1] = false;
            });
            listOfTimeWidget[index][1] = true;
          }
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, bottom: 30),
        height: 70,
        width: 70,
        child: CircleAvatar(
            backgroundColor: Colors.grey[800],
            // onPressed: () {},
            child: listOfTimeWidget[index][1]
                ? Text("delete")
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("${widget.timeforselecttimebtn}",
                          style: TextStyle(
                              color: Colors.white,
                              // fontWeight: FontWeight.w300,
                              fontSize: 25)),
                      Text("mins",
                          style: TextStyle(
                              color: Colors.grey[300],
                              fontWeight: FontWeight.w300,
                              fontSize: 12)),
                    ],
                  )),
      ),
    );
  }

  Container _buildtimeAddbtn() {
    return Container(
      margin: EdgeInsets.only(left: 10, bottom: 30),
      height: 70,
      width: 70,
      child: FloatingActionButton(
        backgroundColor: Colors.grey[800],
        onPressed: () {
          // _showBottomSheet();
        },
        child: Icon(
          Icons.add,
          color: Colors.grey[500],
          size: 40,
        ),
      ),
    );
  }
}
