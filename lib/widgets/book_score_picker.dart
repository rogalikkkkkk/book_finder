import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class BookScorePicker extends StatefulWidget {
  final int? score;
  final Function callBack;

  const BookScorePicker(
      {super.key, required this.score, required this.callBack});

  @override
  _BookScorePickerState createState() => _BookScorePickerState();

}

class _BookScorePickerState extends State<BookScorePicker> {
  int _currentHorizontalIntValue = 5;


  @override
  void initState() {
    widget.score != null ? _currentHorizontalIntValue = widget.score! : {};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NumberPicker(
          value: _currentHorizontalIntValue,
          minValue: 0,
          maxValue: 10,
          step: 1,
          itemHeight: 100,
          axis: Axis.horizontal,
          onChanged: (value) =>
              setState(() {
                _currentHorizontalIntValue = value;
                widget.callBack(value);
              }),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black26),
          ),
        ),
      ],
    );
  }
}
