import 'package:flutter/material.dart';

const backGroundColor = Colors.lightBlue;
const txtLabelStyle = TextStyle(
  color: Colors.white70,
  fontSize: 40,
);
abstract final class Bmi{
  static const String underWeightSevere = 'UnderWeight(thinnes)';
  static const String underWeightModerate = 'UnderWeight(Moderate thinnes)';
  static const String underWeightMild = 'UnderWeight(Mild thinnes)';
  static const String normal = 'Normal';
  static const String overWeightPre = 'OverWeight(Pre Obese)';
  static const String obese_1 = 'Obese(Class -I)';
  static const String obese_2 = 'Obese(Class -II)';
  static const String obese_3 = 'Obese(Class -III)';

}

enum BmiUnit{
  m,ft,kg,lb
}