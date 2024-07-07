import 'package:flutter/material.dart';
import 'package:project_aj/models/data_model.dart';
import 'package:project_aj/models/enums.dart';

class ResultWidget extends StatelessWidget {
  final ItemStatus status;
  final Item? actualItem;

  const ResultWidget({
    super.key,
    required this.status,
    this.actualItem,
  });

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case ItemStatus.correctly:
        return const Icon(
          Icons.check_circle_outline_outlined,
          size: 50,
          color: Colors.green,
        );
      case ItemStatus.badly:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cancel_outlined, size: 50, color: Colors.red),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                actualItem!.en,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        );
      default:
        return Container();
    }
  }
}
