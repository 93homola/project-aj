import 'package:flutter/material.dart';
import 'package:project_aj/components/introductory_button_component.dart';
import 'package:project_aj/views/levels_view.dart';

class IntroductoryView extends StatelessWidget {
  const IntroductoryView({super.key});

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
