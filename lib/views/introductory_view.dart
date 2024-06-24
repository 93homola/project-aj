import 'package:flutter/material.dart';
import 'package:project_aj/components/introductory_button_component.dart';
import 'package:project_aj/provider/data_provider.dart';
import 'package:project_aj/views/levels_view.dart';
import 'package:provider/provider.dart';

class IntroductoryView extends StatefulWidget {
  const IntroductoryView({super.key});

  @override
  State<IntroductoryView> createState() => _IntroductoryViewState();
}

class _IntroductoryViewState extends State<IntroductoryView> {
  @override
  void initState() {
    super.initState();
    Provider.of<FirebaseDataProvider>(context, listen: false)
        .loadData()
        .then((_) {
      print(Provider.of<FirebaseDataProvider>(context, listen: false)
          .verbs
          .first
          .cs);
      print(Provider.of<FirebaseDataProvider>(context, listen: false)
          .words
          .first
          .cs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Project_AJ',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
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
                        purpose: 'slovesa',
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
                        purpose: 'slovicka',
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
                        purpose: 'fraze',
                      );
                    }),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
