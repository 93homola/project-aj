import 'package:flutter/material.dart';
import 'package:project_aj/components/item_text_field_component.dart';
import 'package:project_aj/models/data_model.dart';
import 'package:project_aj/models/enums.dart';
import 'package:project_aj/provider/data_provider.dart';
import 'package:project_aj/views/edit_item_view.dart';
import 'package:provider/provider.dart';

class ListOfItemsView extends StatefulWidget {
  final ItemType type;

  const ListOfItemsView({super.key, required this.type});

  @override
  State<ListOfItemsView> createState() => _ListOfItemsViewState();
}

class _ListOfItemsViewState extends State<ListOfItemsView> {
  List<Item> _items = [];
  final TextEditingController _wordsController = TextEditingController();

  @override
  void initState() {
    _items = Provider.of<FirebaseDataProvider>(context, listen: false)
        .getFilterItems(widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seznam ${widget.type.name}'),
      ),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).colorScheme.surface,
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                const Text(
                  'Vyhledávání:',
                  style: TextStyle(fontSize: 16),
                ),
                ItemTextField(
                  controller: _wordsController,
                  normalMode: true,
                  onChanged: (value) {
                    _items = Provider.of<FirebaseDataProvider>(context,
                            listen: false)
                        .getFilterItems(widget.type, firstWords: value);
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  tileColor: index % 2 == 0 ? Colors.black12 : null,
                  title: Center(
                    child: Text(
                      _items[index].cs,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  subtitle: Column(
                    children: [
                      Text(
                        _items[index].en,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        _items[index].id.toString(),
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ],
                  ),
                  contentPadding: const EdgeInsets.all(4),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return EditItemView(
                          item: _items[index],
                          isCreate: false,
                          type: widget.type,
                          isDelate: true,
                        );
                      }),
                    ).then((_) async {
                      await Provider.of<FirebaseDataProvider>(context,
                              listen: false)
                          .loadData(widget.type)
                          .then((_) {
                        _items = Provider.of<FirebaseDataProvider>(context,
                                listen: false)
                            .getFilterItems(widget.type);
                        _wordsController.clear();
                        setState(() {});
                      });
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
