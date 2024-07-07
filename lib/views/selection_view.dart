import 'package:flutter/material.dart';
import 'package:project_aj/components/item_text_field_component.dart';
import 'package:project_aj/components/result_component.dart';
import 'package:project_aj/models/data_model.dart';
import 'package:project_aj/models/enums.dart';
import 'package:project_aj/provider/data_provider.dart';
import 'package:project_aj/provider/selection_provider.dart';
import 'package:provider/provider.dart';

class SelectionView extends StatefulWidget {
  final ItemType type;
  final List<Item> items;
  final int level;

  const SelectionView({
    super.key,
    required this.type,
    required this.items,
    required this.level,
  });

  @override
  State<SelectionView> createState() => _SelectionViewState();
}

class _SelectionViewState extends State<SelectionView> {
  TextEditingController textController = TextEditingController();
  Item? _actualItem;
  ItemStatus _status = ItemStatus.unfilled;
  bool _isSameLevel = false;
  int _count = 1;
  bool _isCzechToEnglish = true;

  @override
  void initState() {
    SelectionProvider provider =
        Provider.of<SelectionProvider>(context, listen: false);
    provider.entryItems = widget.items;
    _actualItem = provider.getActualItem();
    if (widget.level == 3) {
      _isCzechToEnglish = false;
      setState(() {});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final SelectionProvider provider =
        Provider.of<SelectionProvider>(context, listen: false);
    final dataProvider =
        Provider.of<FirebaseDataProvider>(context, listen: false);
    final int settingsCount = dataProvider.getLevelsCount(widget.type);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('${widget.type.name} - Level ${widget.level}'),
        ),
        body: (_actualItem != null)
            ? Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      (_isCzechToEnglish) ? _actualItem!.cs : _actualItem!.en,
                      style: const TextStyle(fontSize: 28),
                    ),
                    Text(
                      '$_count/${provider.entryItemsCount + 1}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 10),
                    ItemTextField(controller: textController, status: _status),
                    const SizedBox(height: 30),
                    ResultWidget(status: _status, actualItem: _actualItem),
                    const SizedBox(height: 30),
                    if (_status == ItemStatus.unfilled)
                      ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (textController.text ==
                              ((_isCzechToEnglish)
                                  ? _actualItem!.en
                                  : _actualItem!.cs)) {
                            if (widget.level < settingsCount) {
                              dataProvider.updateItemLevel(
                                  _actualItem!, widget.type, widget.level + 1);
                            }
                            _status = ItemStatus.correctly;
                          } else {
                            if (widget.level >= 2) {
                              dataProvider.updateItemLevel(
                                  _actualItem!, widget.type, widget.level - 1);
                            }
                            _status = ItemStatus.badly;
                          }
                          setState(() {});
                        },
                        child: const Text('Ověřit',
                            style: TextStyle(fontSize: 20)),
                      ),
                    if (_status != ItemStatus.unfilled)
                      ElevatedButton(
                        onPressed: (!_isSameLevel)
                            ? () {
                                _isSameLevel = true;
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                dataProvider.updateItemLevel(
                                    _actualItem!, widget.type, widget.level);
                                setState(() {});
                              }
                            : null,
                        child: Text(
                            (!_isSameLevel)
                                ? 'Ponechat na stejné úrovni'
                                : 'Úroveň byla změněna',
                            style: const TextStyle(fontSize: 20)),
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
                  onPressed: () async {
                    provider.resetSelection();
                    Navigator.pop(context);
                    Navigator.pop(context);
                    await dataProvider.loadData(widget.type);
                  },
                  child: const Text('Konec', style: TextStyle(fontSize: 20)),
                ),
                ElevatedButton(
                  onPressed: (_status != ItemStatus.unfilled)
                      ? () {
                          provider.nextItemFunction();
                          _actualItem = provider.actualItem;
                          textController.clear();
                          _status = ItemStatus.unfilled;
                          _isSameLevel = false;
                          _count++;
                          setState(() {});
                        }
                      : null,
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
