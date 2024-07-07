import 'package:flutter/material.dart';

class ItemTextField extends StatelessWidget {
  final TextEditingController controller;

  const ItemTextField({super.key, required this.controller});

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
      style: const TextStyle(color: Colors.white, fontSize: 22),
      textCapitalization: TextCapitalization.none,
      textAlign: TextAlign.center,
    );
  }
}
