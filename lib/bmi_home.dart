import 'package:bmi_calculator/bmi_provider.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BmiHome extends StatefulWidget {
  const BmiHome({super.key});

  @override
  State<BmiHome> createState() => _BmiHomeState();
}

class _BmiHomeState extends State<BmiHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('BMI Calculator'),
      ),
      body: Column(
        children: [
          Consumer<BmiProvider>(
            builder: (context, provider, child) => BmiSlider(
              label: 'Height',
              unit: BmiUnit.m,
              sliderValue: provider.heightValue,
              sliderDivision: 100,
              sliderMax: 2.2,
              sliderMin: 1.2,
              onChange: (newValue) {
                provider.changeHeight(newValue);
              },
            ),
          ),
          Consumer<BmiProvider>(
            builder: (context, provider, child) => BmiSlider(
              label: 'Weight',
              unit: BmiUnit.kg,
              sliderValue: provider.weightValue,
              sliderDivision: 200,
              sliderMax: 130.0,
              sliderMin: 30.0,
              onChange: (newValue) {
                provider.changeWeight(newValue);
              },
            ),
          ),
          Expanded(
            child: Consumer<BmiProvider>(
              builder: (context, provider, child) => BmiResult(
                bmi: provider.bmi,
                status: provider.status,
                color: provider.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BmiSlider extends StatelessWidget {
  const BmiSlider({
    super.key,
    required this.label,
    required this.unit,
    required this.sliderValue,
    required this.sliderDivision,
    required this.sliderMax,
    required this.sliderMin,
    required this.onChange,
  });

  final String label;
  final BmiUnit unit;
  final double sliderValue;
  final int sliderDivision;
  final double sliderMax, sliderMin;
  final Function(double) onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: txtLabelStyle,
            ),
            const SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: RichText(
                text: TextSpan(
                    text: sliderValue.toStringAsFixed(1),
                    style: txtValueStyle,
                    children: [
                      TextSpan(
                        text: ' ${unit.name}',
                        style: txtLabelStyle.copyWith(fontSize: 20),
                      )
                    ]),
              ),
            ),
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
          onChanged: (value) {
            onChange(value);
          },
        ),
      ],
    );
  }
}

class BmiResult extends StatelessWidget {
  final Color color;
  final double bmi;
  final String status;
  const BmiResult({super.key, required this.color, required this.bmi, required this.status,});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          alignment: Alignment.center,
          width: 160,
          height: 160,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 10,)
          ),
          child: Text(bmi.toStringAsFixed(1), style: txtValueStyle.copyWith(fontSize: 60),),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(status, style: txtResultStyle,),
        )
      ],
    );
  }
}

