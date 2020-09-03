import 'dart:math';
import 'package:flutter/material.dart';

class BatteryWidget extends StatelessWidget {
  final int batteryLevel;
  final double height;
  final int bars;
  final double scaleFactor;

  BatteryWidget({this.batteryLevel, this.bars = 4, this.scaleFactor = 1.0})
      : this.height = 50 * scaleFactor,
        assert(bars > 3 && bars <= 8),
        assert(scaleFactor > 0.2, "Scale factor must be more than 0"),
        assert(scaleFactor <= 2, "Scale factor must be less then 2");

  Color _getColorByBatteryLevel() {
    // TODO make more orange on a middle
    double red = cos((batteryLevel * (pi / 2)) / 100) * 255;
    double green = 200 - (cos((batteryLevel * (pi / 2)) / 100) * 200);

    print("R:$red");
    print("G:$green");

    Color result = Color.fromRGBO(red.toInt(), green.toInt(), 0, 1);

    return result;
  }

  // TODO pad must be from bars amount
  // TODO make pad field common

  Iterable<Widget> get _makeBatteryBar sync* {
    double pad = (height - 10) / 10;
    while (true)
      yield Expanded(
        flex: 1,
        child: Container(
          decoration: BoxDecoration(
              color: _getColorByBatteryLevel(),
              borderRadius: BorderRadius.circular(2)),
          margin: EdgeInsets.fromLTRB(pad, 0, pad / 10, 0),
          height: height / 1.8,
        ),
      );
  }

  Iterable<Widget> get _makeEmptyBatteryBar sync* {
    double pad = (height - 10) / 10;
    while (true)
      yield Expanded(
        flex: 1,
        child: Container(
          margin: EdgeInsets.fromLTRB(pad, 0, pad, 0),
          height: height / 1.8,
          color: Colors.white,
        ),
      );
  }

  List<Widget> getBatteryBars() {
    List<Widget> result = List();

    int filledBars = (batteryLevel / (100 / bars)).round();
    int emptyBars = bars - filledBars;

    result = _makeBatteryBar.take(filledBars).toList();
    result.addAll(_makeEmptyBatteryBar.take(emptyBars).toList());

    return result;
  }

  @override
  Widget build(BuildContext context) {
    Color borderColor = _getColorByBatteryLevel();
    double pad = ((height - 10) / 10);
    return Transform.scale(
      scale: scaleFactor,
      child: Container(
        width: height * 1.6 + height / 3,
        child: Row(
          children: [
            Container(
              height: height,
              width: height * 1.6,
              decoration: BoxDecoration(
                  border: Border.all(color: borderColor, width: height / 10),
                  borderRadius:
                      BorderRadius.all(Radius.circular((height + 30) / 10)),
                  color: Colors.white),
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, pad, 0),
                child: Row(
                  children: getBatteryBars(),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(-height / 10, 0),
              child: Container(
                height: height / 3,
                width: height / 3,
                decoration: BoxDecoration(
                    border: Border.all(color: borderColor),
                    borderRadius:
                        BorderRadius.all(Radius.circular((height - 10) / 10)),
                    color: borderColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
