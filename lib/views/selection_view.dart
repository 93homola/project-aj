import 'package:flutter/material.dart';
import 'package:project_aj/components/item_text_field.dart';
import 'package:project_aj/models/data_model.dart';
import 'package:project_aj/models/enums.dart';
import 'package:project_aj/provider/selection_provider.dart';
import 'package:provider/provider.dart';

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

  Item? actualItem;
  ItemStatus status = ItemStatus.unfilled;

  @override
  void initState() {
    SelectionProvider provider =
        Provider.of<SelectionProvider>(context, listen: false);
    provider.entryItems = widget.items;
    actualItem = provider.getActualItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SelectionProvider provider =
        Provider.of<SelectionProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('${widget.type.name} - Level ${widget.level}'),
        ),
        body: (actualItem != null)
            ? Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      actualItem!.cs,
                      style: const TextStyle(fontSize: 28),
                    ),
                    const Text(
                      '3/65',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 10),
                    ItemTextField(controller: textController),
                    const SizedBox(height: 30),
                    if (status == ItemStatus.correctly)
                      const Icon(Icons.check_circle_outline_outlined,
                          size: 50, color: Colors.green),
                    if (status == ItemStatus.badly)
                      const Icon(Icons.cancel_outlined,
                          size: 50, color: Colors.red),
                    const SizedBox(height: 30),
                    if (status == ItemStatus.unfilled)
                      ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());

                          if (textController.text == actualItem!.en) {
                            //zmněna levelu o jeden nahoru pokud neni nejvyssi level!
                            status = ItemStatus.correctly;
                          } else {
                            //zmněna levelu o jeden dolu pokud neni nejnizsi level!
                            status = ItemStatus.badly;
                          }
                          setState(() {});
                        },
                        child: const Text('Ověřit',
                            style: TextStyle(fontSize: 20)),
                      ),
                    if (status != ItemStatus.unfilled)
                      ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          //zpět na pocatecni uroven, tzn. pokud je dobre tak o jeden dolu, pokud spatne tak o jeden nahoru, a to pokud je kam
                        },
                        child: const Text('Ponechat na stejné úrovni',
                            style: TextStyle(fontSize: 20)),
                      ),
                  ],
                ),
              )
            : const Center(
                child: Text(
                  'Nemáte žádné další položky',
                  style: TextStyle(fontSize: 20),
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
                    provider.nextItemFunction();
                    actualItem = provider.actualItem;
                    textController.clear();
                    status = ItemStatus.unfilled;
                    setState(() {});
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
