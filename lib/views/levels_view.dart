import 'package:flutter/material.dart';
import 'package:project_aj/components/introductory_button_component.dart';
import 'package:project_aj/models/data_model.dart';
import 'package:project_aj/models/enums.dart';
import 'package:project_aj/views/selection_view.dart';
import '../provider/data_provider.dart';
import 'package:provider/provider.dart';

class LevelsView extends StatelessWidget {
  final ItemType type;

  const LevelsView({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final dataProvider =
        Provider.of<FirebaseDataProvider>(context, listen: false);
    final int levelsCount = dataProvider.getLevelsCount(type);
    return Scaffold(
      appBar: AppBar(
        title: Text(type.name),
      ),
      body: Center(
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              child: Text(
                'Vyber si úroveň:',
                style: TextStyle(
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ...List.generate(levelsCount, (index) {
              final List<Item> items =
                  dataProvider.getItemsForLevel(index + 1, type);
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: Align(
                  alignment: Alignment.center,
                  child: IntroductoryButton(
                    buttonText: 'Level ${index + 1} (${items.length})',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return SelectionView(
                            type: type,
                            items: items,
                            level: index + 1,
                          );
                        }),
                      );
                    },
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
