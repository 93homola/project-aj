import 'package:flutter/material.dart';
import 'package:project_aj/components/introductory_button_component.dart';
import '../provider/data_provider.dart';
import 'package:provider/provider.dart';

class LevelsView extends StatelessWidget {
  final String purpose;

  const LevelsView({super.key, required this.purpose});

  @override
  Widget build(BuildContext context) {
    print(purpose);
    final levels = Provider.of<FirebaseDataProvider>(context, listen: false)
        .getRulesByName(purpose);
    return Scaffold(
      appBar: AppBar(
        title: Text(purpose),
      ),
      body: Center(
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Vyber si úroveň:',
                style: TextStyle(
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ...levels.map((level) {
              return Padding(
                padding: const EdgeInsets.all(6),
                child: Align(
                  alignment: Alignment.center,
                  child: IntroductoryButton(
                    buttonText: 'Úroveň ${level.level}',
                    onPressed: () {
                      print(level.level);
                    },
                  ),
                ),
              );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
