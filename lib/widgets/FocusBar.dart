import 'package:flutter/material.dart';

class Focusbar extends StatelessWidget {
  final String dName;
  final double focusValue;
  final double hieghestValue;
  final double maxHeight;
  final bool isSelected;

  const Focusbar({
    required this.dName,
    required this.focusValue,
    required this.isSelected,
    required this.hieghestValue,
    required this.maxHeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double barHeight;
    if (hieghestValue == 0) {
      barHeight = 0;
    } else {
      barHeight = (focusValue / hieghestValue) * maxHeight;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            color: !isSelected
                ? Color.fromRGBO(228, 235, 228, 1)
                : Color.fromRGBO(206, 126, 96, 1),
          ),
          width: 25,
          height: barHeight,
        ),
        SizedBox(height: 9),
        Text(dName),
      ],
    );
  }
}
