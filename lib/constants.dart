import 'package:flutter/material.dart';

const backgroundColor = Colors.lightBlue;
const txtLabelStyle = TextStyle(
  color: Colors.white70,
  fontSize: 22,
);
const txtValueStyle = TextStyle(
  color: Colors.white,
  fontSize: 40,
);

const txtResultStyle = TextStyle(
  letterSpacing: 1.2,
  fontSize: 25,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);



abstract final class BMI {
  static const String underweightSevere = 'Underweight (Severe thinnes)';
  static const String underweightModerate = 'Underweight (Moderate thinness)';
  static const String underweightMild = 'Underweight (Mild thinness)';
  static const String normal = 'Normal';
  static const String overweightPre = 'Overweight (Pre-obese)';
  static const String obese_1 = 'Obese (Class I)';
  static const String obese_2 = 'Obese (Class II)';
  static const String obese_3 = 'Obese (Class III)';
}

enum BmiUnit {
  m, ft, kg, lb,
}

enum Gender {
  male,
  female,
  none,
}