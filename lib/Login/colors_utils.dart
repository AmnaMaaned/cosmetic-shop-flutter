import 'package:flutter/material.dart';




/*hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("a", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  */

  hexStringToColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("A", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Colors.green; // Utilisation de la couleur vertern Color(int.parse(hexColor, radix: 16));
}
