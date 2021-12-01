import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  // final String text;
  final int selectedPage;
  final IconData icon;
  final int pageNumber;
  final double iconsize;

  final VoidCallback onPressed;
  const TabButton(
      {Key? key,
      // required this.text,
      required this.icon,
      required this.iconsize,
      required this.selectedPage,
      required this.pageNumber,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.fastLinearToSlowEaseIn,
        // decoration: BoxDecoration(
        //   color: selectedPage == pageNumber ? Colors.blue : Colors.transparent,
        //   borderRadius: BorderRadius.circular(4.0),
        // ),
        padding: EdgeInsets.symmetric(
          vertical: selectedPage == pageNumber ? 12.0 : 0,
          horizontal: selectedPage == pageNumber ? 13.0 : 0,
        ),
        margin: EdgeInsets.symmetric(
          vertical: selectedPage == pageNumber ? 0 : 12.0,
          horizontal: selectedPage == pageNumber ? 0 : 13.0,
        ),
        child: Icon(
          icon,
          color: selectedPage == pageNumber
              ? Colors.lightBlue[400]
              : Colors.grey[700],
          size: iconsize,
        ),
        // Text(
        //   text,
        //   style: TextStyle(
        //     color: selectedPage == pageNumber ? Colors.white : Colors.black,
        //   ),
        // ),
      ),
    );
  }
}
