import 'package:clock_poco/Pages/ClockPage/custom%20widgets/custom_slider.dart';
import 'package:clock_poco/Pages/ClockPage/custom%20widgets/ticker_shape.dart';
import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget {
  SliderWidget(
      {Key? key,
      this.sliderHeight = 48,
      this.max = 10,
      this.min = 0,
      this.initialValue = 0,
      required this.changeValue,
      this.fullWidth = false})
      : super(key: key);

  final double sliderHeight;
  final int min;
  final int max;
  final fullWidth;
  final double initialValue;
  final Function changeValue;

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double valuees = 0;

  @override
  void initState() {
    super.initState();
    valuees = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    double paddingFactor = .3;

    if (widget.fullWidth) paddingFactor = .15;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "00",
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
                const Text(
                  "06",
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
                const Text(
                  "12",
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
                Container(
                  margin: EdgeInsets.only(left: 00),
                  child: const Text(
                    "18",
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 0),
                  child: Text(
                    "24",
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width:
              widget.fullWidth ? double.infinity : (widget.sliderHeight) * 5.5,
          height: (widget.sliderHeight),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular((widget.sliderHeight * .5)),
              ),
              color: Colors.black.withOpacity(0.2)),
          child: Padding(
            padding: EdgeInsets.fromLTRB(widget.sliderHeight * paddingFactor, 2,
                widget.sliderHeight * paddingFactor, 2),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.transparent,
                            inactiveTrackColor: Colors.transparent,
                            trackHeight: 20.0,
                            thumbShape: CustomSliderThumbCircle(
                              thumbRadius: widget.sliderHeight * .4,
                              min: widget.min,
                              max: widget.max,
                            ),
                            overlayColor: Colors.white.withOpacity(.4),
                            activeTickMarkColor: Colors.black,
                            disabledInactiveTickMarkColor: Colors.black,
                            disabledActiveTickMarkColor: Colors.black,
                            tickMarkShape:
                                LineSliderTickMarkShape(tickMarkRadius: 1),
                            inactiveTickMarkColor: Colors.black,
                          ),
                          child: Slider(
                            divisions: 24,
                            min: 0,
                            max: 24,
                            value: valuees,
                            onChangeEnd: (vaule) {
                              Future.delayed(Duration(milliseconds: 100), () {
                                setState(() {
                                  valuees = widget.initialValue;
                                  widget.changeValue(widget.initialValue);
                                });
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                valuees = value;
                              });
                              widget.changeValue(value);
                              print("---->>>>>>>Slider Value $valuees");
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
