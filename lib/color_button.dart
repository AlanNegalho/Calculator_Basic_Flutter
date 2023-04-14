import 'package:flutter/material.dart';

Color getcolor(String text) {
  if (text == '/' || text == '*' || text == '+' || text == '-' || text == '=') {
    return Colors.orangeAccent;
  }
  if (text == 'AC') {
    return Color.fromARGB(255, 59, 31, 29);
  }
  if (text == 'C' || text == '%' || text == '+/-') {
    return Color.fromARGB(255, 193, 228, 245);
  }

  return Color.fromARGB(255, 56, 59, 66);
}
