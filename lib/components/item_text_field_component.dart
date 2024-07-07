import 'package:flutter/material.dart';
import 'package:project_aj/models/enums.dart';

class ItemTextField extends StatelessWidget {
  final TextEditingController controller;
  final ItemStatus? status;

  const ItemTextField({
    super.key,
    required this.controller,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),
      ),
      cursorColor: Colors.white,
      readOnly: (status == ItemStatus.unfilled) ? false : true,
      style: TextStyle(color: setColor(status), fontSize: 22),
      textCapitalization: TextCapitalization.none,
      textAlign: TextAlign.center,
    );
  }

  setColor(ItemStatus? status) {
    switch (status) {
      case ItemStatus.correctly:
        return Colors.green;
      case ItemStatus.badly:
        return Colors.red;
      default:
        return Colors.white;
    }
  }
}
