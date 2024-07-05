import 'package:flutter/material.dart';
import 'package:project_aj/components/introductory_button_component.dart';
import 'package:project_aj/provider/data_provider.dart';
import 'package:project_aj/views/levels_view.dart';
import 'package:provider/provider.dart';
import '../models/enums.dart';

class IntroductoryView extends StatefulWidget {
  const IntroductoryView({super.key});

  @override
  State<IntroductoryView> createState() => _IntroductoryViewState();
}

class _IntroductoryViewState extends State<IntroductoryView> {
  bool _isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    Provider.of<FirebaseDataProvider>(context, listen: false)
        .loadAllData()
        .then((_) {
      setState(() {
        _isDataLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: (_isDataLoaded)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Project_AJ',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Vyber si sekci kterou chceš procvičit',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 60),
                  IntroductoryButton(
                      buttonText: 'Slovesa',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const LevelsView(
                              type: ItemType.verbs,
                            );
                          }),
                        );
                      }),
                  const SizedBox(height: 12),
                  IntroductoryButton(
                      buttonText: 'Slovíčka',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const LevelsView(
                              type: ItemType.words,
                            );
                          }),
                        );
                      }),
                  const SizedBox(height: 12),
                  IntroductoryButton(
                      buttonText: 'Fráze',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const LevelsView(
                              type: ItemType.phrase,
                            );
                          }),
                        );
                      }),
                  const SizedBox(height: 12),
                  IntroductoryButton(
                      buttonText: 'Add item',
                      onPressed: () {
                        /* Provider.of<FirebaseDataProvider>(context,
                                listen: false)
                            .editItem(
                          Verb(
                            cs: "běhat",
                            en: "run",
                            level: 1,
                            id: 1,
                          ),
                          ItemType.words,
                        ); */
                      }),
                  const SizedBox(height: 12),
                  IntroductoryButton(
                      buttonText: 'Load settings',
                      onPressed: () {
                        /* Provider.of<FirebaseDataProvider>(context,
                                listen: false)
                            .loadSettings(); */
                      }),
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
