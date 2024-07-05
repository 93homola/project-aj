import 'package:flutter/material.dart';
import 'package:project_aj/models/enums.dart';

class QuessView extends StatefulWidget {
  final ItemType type;
  final List<dynamic> items;
  final int level;

  const QuessView({
    super.key,
    required this.type,
    required,
    required this.items,
    required this.level,
  });

  @override
  State<QuessView> createState() => _QuessViewState();
}

class _QuessViewState extends State<QuessView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.type.name} - Level ${widget.level}'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Konec', style: TextStyle(fontSize: 20)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Další', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
