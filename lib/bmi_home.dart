import 'package:bmi_calculator/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  _updateBmi(){
    bmi = weightValue /(heightValue*heightValue);
    _updateStatus();
    _updateColor();
  }
  _updateStatus(){
    status = _getStatus();

  }
  _updateColor(){
    if(bmi<16.0){
      color = Colors.green.shade100 ;
    }
    else if(bmi>=16.0 && bmi <= 16.9){
      color = Colors.green.shade200 ;
    }
    else if(bmi>=17.0 && bmi <= 18.4){
      color = Colors.green.shade300 ;
    }
    else if(bmi>=18.5 && bmi <= 24.9){
      color = Colors.green ;
    }
    else if(bmi>=25.0 && bmi <= 29.9){
      color = Colors.red.shade400 ;
    }
    else if(bmi>=30.0 && bmi <= 34.9){
      color = Colors.red.shade500 ;
    }
    else if(bmi>=35.0 && bmi <= 39.9){
      color = Colors.red.shade600 ;
    }
    else {
      color = Colors.red.shade900 ;
    }

  }
  String _getStatus(){
    if(bmi<16.0){
      return Bmi.underWeightSevere;
    }
    if(bmi>=16.0 && bmi <= 16.9){
      return Bmi.underWeightModerate;
    }
    if(bmi>=17.0 && bmi <= 18.4){
      return Bmi.underWeightMild;
    }
    if(bmi>=18.5 && bmi <= 24.9){
      return Bmi.normal;
    }
    if(bmi>=25.0 && bmi <= 29.9){
      return Bmi.normal;
    }
    if(bmi>=30.0 && bmi <= 34.9){
      return Bmi.obese_1;
    }
    if(bmi>=35.0 && bmi <= 39.9){
      return Bmi.obese_2;
    }
    return Bmi.obese_3;
  }
  @override
  void initState() {
    _updateBmi();
    super.initState();
  }

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
                _updateBmi();
              }
          ),
          BmiSlidder(
              label: 'Weight',
              unit: BmiUnit.kg,
              sliderValue: weightValue,
              sliderDivision: 200,
              sliderMax: 130,
              sliderMin: 30,
              onChanged: (newValue){
                setState(() {
                  weightValue = newValue;
                });
                _updateBmi();
              }
          ),
          Expanded(child: BmiResult(color: color, bmi: bmi, status: status))
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

class BmiResult extends StatelessWidget {
  final Color color;
  final double bmi;
  final String status;
  const BmiResult({
    super.key,
    required this.color,
    required this.bmi,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       AnimatedContainer(
         duration:  Duration(milliseconds: 500),
         alignment: Alignment.center,
         width: 160,
         height: 160,
         decoration: BoxDecoration(
           shape: BoxShape.circle,
           border: Border.all(color: color,width: 10),
         ),
         child: Text(bmi.toStringAsFixed(1),style: txtValueStyle,),

       ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(status,style: txtResultStyle,),
        )
      ],
    );
  }
}

