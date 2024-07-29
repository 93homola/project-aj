import 'package:flutter/material.dart';
import 'package:project_aj/helpers/functions.dart';
import 'package:project_aj/models/data_model.dart';
import 'package:provider/provider.dart';

import '../provider/data_provider.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  History _history = History(days: {});

  @override
  void initState() {
    Provider.of<FirebaseDataProvider>(context, listen: false)
        .loadHistory()
        .then((history) {
      _history = history;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historie'),
      ),
      body: ListView.builder(
        itemCount: _history.days.length,
        itemBuilder: (context, index) {
          final day = _history.days.values.elementAt(index);
          return ListTile(
            tileColor: index % 2 == 0 ? Colors.black12 : null,
            title: Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(formatDate(_history.days.keys.elementAt(index))),
            ),
            leading: Text(
              '${(day.verbs ?? 0) + (day.words ?? 0)}',
              style: const TextStyle(fontSize: 22, color: Colors.white),
            ),
            subtitle: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    'Verbs: ${day.verbs ?? 0}',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                Text(
                  'Words: ${day.words ?? 0}',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          );
        },
      ),
    );
  }
}
