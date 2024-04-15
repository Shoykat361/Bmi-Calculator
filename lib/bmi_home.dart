import 'package:bmi_calculator/constants.dart';
import 'package:flutter/material.dart';
class BmiHome extends StatefulWidget {
  const BmiHome({super.key});

  @override
  State<BmiHome> createState() => _BmiHomeState();
}

class _BmiHomeState extends State<BmiHome> {
  double heightValue = 1.5;
  double weightValue = 50.00;
  String status = '';
  double bmi = 0.0;
  Color color = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Column(
        children: [
          BmiSlidder(
              label: 'Height',
              unit: BmiUnit.m,
              sliderValue: heightValue,
              sliderDivision: 100,
              sliderMax: 2.2,
              sliderMin: 1.2,
              onChanged: (newValue){
                setState(() {
                  heightValue = newValue;
                });
              }
          ),
          BmiSlidder(
              label: 'Weight',
              unit: BmiUnit.kg,
              sliderValue: weightValue,
              sliderDivision: 200,
              sliderMax: 180,
              sliderMin: 20,
              onChanged: (newValue){
                setState(() {
                  weightValue = newValue;
                });
              }
          ),
        ],
      ),
    );
  }
}


class BmiSlidder extends StatelessWidget {
  const BmiSlidder({super.key,
    required this.label,
    required this.unit,
    required this.sliderValue,
    required this.sliderDivision,
    required this.sliderMax,
    required this.sliderMin,
    required this.onChanged,
  });

  final String label;

  final BmiUnit unit;

  final double sliderValue;

  final int sliderDivision;
  final double sliderMax, sliderMin;
  final Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment:  CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label,style: txtLabelStyle,),
            const SizedBox(width: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: RichText(
                text: TextSpan(
                    text: sliderValue.toStringAsFixed(1),
                    style: txtLabelStyle,
                    children: [
                      TextSpan(
                        text: ' ${unit.name}',
                        style: txtLabelStyle.copyWith(fontSize: 20),
                      )
                    ]),
              ),
            )
          ],
        ),
        Slider(
          activeColor: Colors.white70,
          inactiveColor: Colors.white30,
          label: sliderValue.toStringAsFixed(1),
          value: sliderValue,
          divisions: sliderDivision,
          max: sliderMax,
          min: sliderMin,
          onChanged: (value){
            onChanged(value);
          },

        ),
      ],
    );
  }
}
