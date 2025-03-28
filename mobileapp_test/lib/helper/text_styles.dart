import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle regular(double size, Color color, {FontWeight weight = FontWeight.normal}) {
    return TextStyle(fontSize: size, fontWeight: weight, color: color);
  }

  static TextStyle bold(double size, Color color) {
    return TextStyle(fontSize: size, fontWeight: FontWeight.bold, color: color);
  }
}