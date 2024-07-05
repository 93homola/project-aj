import 'package:flutter/material.dart';
import 'package:project_aj/components/item_text_field.dart';
import 'package:project_aj/models/data_model.dart';
import 'package:project_aj/models/enums.dart';

class QuessView extends StatefulWidget {
  final ItemType type;
  final List<Item> items;
  final int level;

  const QuessView({
    super.key,
    required this.type,
    required this.items,
    required this.level,
  });

  @override
  State<QuessView> createState() => _QuessViewState();
}

class _QuessViewState extends State<QuessView> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('${widget.type.name} - Level ${widget.level}'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Běhat',
                  style: TextStyle(fontSize: 28),
                ),
              ),
              ItemTextField(controller: textController),
            ],
          ),
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
      ),
    );
  }
}
