import 'package:flutter/material.dart';
import 'package:project_aj/models/enums.dart';

class ListOfItemsView extends StatefulWidget {
  final ItemType type;

  const ListOfItemsView({super.key, required this.type});

  @override
  State<ListOfItemsView> createState() => _ListOfItemsViewState();
}

class _ListOfItemsViewState extends State<ListOfItemsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seznam ${widget.type.name}'),
      ),
      body: const Center(
        child: Text('Zde bude seznam položek'),
      ),
    );
  }
}
