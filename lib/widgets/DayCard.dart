import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DayCard extends StatelessWidget {
  final String dName;
  final String dNum;
  final bool isSelected;
  final VoidCallback onTap;

  const DayCard({
    required this.dName,
    required this.dNum,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(
            width: 0.5,
            color: Color.fromRGBO(236, 229, 223, 1),
          ),
          borderRadius: BorderRadius.circular(15),
          color: isSelected
              ? Color.fromRGBO(214, 125, 97, 1.0)
              : Color.fromRGBO(245, 243, 238, 1.0),
        ),
        child: isSelected
            ? Column(
                children: [
                  Text(
                    dName,
                    style: TextStyle(
                      fontSize: 13,
                      color: Color.fromRGBO(106, 60, 44, 1),
                    ),
                  ),
                  Text(
                    dNum,
                    style: GoogleFonts.literata(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color.fromRGBO(68, 25, 15, 1),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(68, 25, 15, 1),
                    ),
                    width: 6,
                    height: 6,
                  ),
                ],
              )
            : Column(
                children: [
                  Text(dName, style: TextStyle(fontSize: 13)),
                  Text(dNum, style: GoogleFonts.literata(fontSize: 16)),
                ],
              ),
      ),
    );
  }
}
