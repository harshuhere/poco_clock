import 'package:flutter/material.dart';

class BottomSheetWidget extends StatefulWidget {
  BottomSheetWidget(
      {Key? key,
      required this.value,
      required this.index,
      required this.mainText,
      required this.ontap,
      required this.bottomsheetindexcustom})
      : super(key: key);
  int index;
  String mainText;
  Function ontap;
  bool value;
  int bottomsheetindexcustom;

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${widget.mainText}",
            style: TextStyle(
                color: widget.value ? Colors.lightBlue : Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w300),
          ),
          InkWell(
            onTap: () {
              setState(() {
                widget.value = !widget.value;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.value ? Colors.lightBlue : Colors.grey[800]),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: widget.value
                    ? Icon(
                        Icons.check,
                        size: 15.0,
                        color: Colors.white,
                      )
                    : Icon(
                        Icons.check_box_outline_blank,
                        size: 15.0,
                        color: Colors.grey[800],
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
