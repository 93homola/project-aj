import 'package:flutter/material.dart';
import 'package:project_aj/components/introductory_button_component.dart';
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
  final TextEditingController _firstWordController = TextEditingController();

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
                        );
                      }),
                    ).then((value) {
                      Provider.of<FirebaseDataProvider>(context, listen: false)
                          .loadData(widget.type);
                      if (value == true) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /* setState(() {
            _items = Provider.of<FirebaseDataProvider>(context, listen: false)
                .getFilterItems(widget.type, firstWord: 'a');
          }); */
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                color: Theme.of(context).colorScheme.surface,
                width: double.infinity,
                height: 300,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Filtrování podle počátečního písmene:',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: ItemTextField(
                        controller: _firstWordController,
                        normalMode: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Align(
                        alignment: Alignment.center,
                        child: IntroductoryButton(
                          buttonText: 'Uložit',
                          onPressed: () {
                            _items = Provider.of<FirebaseDataProvider>(context,
                                    listen: false)
                                .getFilterItems(widget.type,
                                    firstWord: _firstWordController
                                        .text.characters.first);
                            setState(() {});
                            Navigator.pop(context, true);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        heroTag: 'filter',
        child: const Icon(Icons.filter_list),
      ),
    );
  }
}
