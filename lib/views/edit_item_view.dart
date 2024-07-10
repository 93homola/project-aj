import 'package:flutter/material.dart';
import 'package:project_aj/components/introductory_button_component.dart';
import 'package:project_aj/components/item_text_field_component.dart';
import 'package:project_aj/components/level_dropdown_button_component.dart';
import 'package:project_aj/models/data_model.dart';
import 'package:project_aj/models/enums.dart';
import 'package:project_aj/provider/data_provider.dart';
import 'package:provider/provider.dart';

class EditItemView extends StatefulWidget {
  final Item item;
  final bool isCreate;
  final ItemType type;

  const EditItemView({
    super.key,
    required this.item,
    required this.isCreate,
    required this.type,
  });

  @override
  State<EditItemView> createState() => _EditItemViewState();
}

class _EditItemViewState extends State<EditItemView> {
  final TextEditingController _csController = TextEditingController();
  final TextEditingController _enController = TextEditingController();
  int? _selectedValue;
  int? _id;

  @override
  void initState() {
    if (!widget.isCreate) {
      _id = widget.item.id;
      _csController.text = widget.item.cs;
      _enController.text = widget.item.en;
      _selectedValue = widget.item.level;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.isCreate ? 'Vytvořit' : 'Upravit'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Center(
            child: ListView(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text("id: $_id"),
                ),
                const SizedBox(height: 40),
                ItemTextField(
                  controller: _csController,
                  normalMode: true,
                ),
                const SizedBox(height: 40),
                ItemTextField(
                  controller: _enController,
                  normalMode: true,
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LevelDropdownButton(
                        labelText: "Level: ",
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value;
                          });
                        },
                        selectedValue: _selectedValue),
                  ],
                ),
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.center,
                  child: IntroductoryButton(
                    buttonText: 'Uložit',
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Provider.of<FirebaseDataProvider>(context, listen: false)
                          .editItem(
                        cs: _csController.text,
                        en: _enController.text,
                        level: _selectedValue!,
                        id: _id!,
                        type: widget.type,
                      );
                      Navigator.pop(context, true);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
