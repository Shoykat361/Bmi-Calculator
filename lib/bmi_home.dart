import 'dart:async';

import 'package:bmi_calculator/bmi_provider.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/container_box.dart';
import 'package:bmi_calculator/data_container.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      body: Expanded(
        child: SafeArea(
          child: Column(
            children: [
              Consumer<BmiProvider>(builder: (context, provider, child) => Person(),),
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
        ),
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
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

class Person extends StatefulWidget {
  const Person({Key? key}) : super(key: key);

  @override
  _PersonState createState() => _PersonState();
}

class _PersonState extends State<Person> {
  Gender selectedGender = Gender.none;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedGender = Gender.male;
              });
              Provider.of<BmiProvider>(context, listen: false).updateMale(true);

            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ContainerBox(
                boxColor: selectedGender == Gender.male ? Colors.green : Colors.red,
                childwidget: DataContainer(
                  title: 'Male',
                  icon: FontAwesomeIcons.male,
                  isSelected: selectedGender == Gender.male,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedGender = Gender.female;
              });
              Provider.of<BmiProvider>(context, listen: false).updateFemale(true);
              Provider.of<BmiProvider>(context, listen: false).resetSliderValue();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ContainerBox(
                boxColor: selectedGender == Gender.female ? Colors.green : Colors.red,
                childwidget: DataContainer(
                  title: 'Female',
                  icon: FontAwesomeIcons.female,
                  isSelected: selectedGender == Gender.female,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
class ContainerBox extends StatelessWidget {
  final Color boxColor;
  final Widget childwidget;

  const ContainerBox({required this.boxColor, required this.childwidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: childwidget,
    );
  }
}







