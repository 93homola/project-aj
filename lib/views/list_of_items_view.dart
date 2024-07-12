import 'package:flutter/material.dart';
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
  List<Verb> _verbs = [];
  List<Word> _words = [];
  /* final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController(); */

  @override
  void initState() {
    if (widget.type == ItemType.verbs) {
      _verbs = Provider.of<FirebaseDataProvider>(context, listen: false).verbs;
    } else {
      _words = Provider.of<FirebaseDataProvider>(context, listen: false).words;
    }
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
              itemCount: (widget.type == ItemType.verbs)
                  ? _verbs.length
                  : _words.length,
              itemBuilder: (context, index) {
                return ListTile(
                  tileColor: index % 2 == 0 ? Colors.black12 : null,
                  title: Center(
                    child: Text(
                      (widget.type == ItemType.verbs)
                          ? _verbs[index].cs
                          : _words[index].cs,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  subtitle: Column(
                    children: [
                      Text(
                        (widget.type == ItemType.verbs)
                            ? _verbs[index].en
                            : _words[index].en,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        (widget.type == ItemType.verbs)
                            ? _verbs[index].id.toString()
                            : _words[index].id.toString(),
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
                          item: (widget.type == ItemType.verbs)
                              ? _verbs[index]
                              : _words[index],
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
    );
  }
}
