import 'package:flutter/material.dart';

class LevelDropdownButton extends StatefulWidget {
  final String labelText;
  final int? selectedValue;
  final ValueChanged<int?> onChanged;

  const LevelDropdownButton({
    super.key,
    required this.labelText,
    this.selectedValue,
    required this.onChanged,
  });

  @override
  State<LevelDropdownButton> createState() => _LevelDropdownButtonState();
}

class _LevelDropdownButtonState extends State<LevelDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.labelText,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        DropdownButton<int>(
          value: widget.selectedValue,
          iconEnabledColor: Colors.white,
          underline: Container(
            height: 2,
            color: Colors.white,
          ),
          dropdownColor: Colors.black,
          style: const TextStyle(color: Colors.white, fontSize: 20),
          items: List.generate(
            6,
            (index) => DropdownMenuItem<int>(
              value: index + 1,
              child: Text(
                "${index + 1}",
              ),
            ),
          ),
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
