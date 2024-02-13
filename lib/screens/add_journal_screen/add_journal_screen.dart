import 'package:daily/helpers/weekday.dart';
import 'package:daily/services/journal_service.dart';
import 'package:flutter/material.dart';
import '../../models/journal.dart';

class AddJournalScreen extends StatelessWidget {
  final Journal journal;

  AddJournalScreen({Key? key, required this.journal}) : super(key: key);

  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${WeekDay(journal.createdAt.weekday).long.toLowerCase()}, ${journal.createdAt.day}  |  ${journal.createdAt.month}  |  ${journal.createdAt.year}"),
        actions: [
          IconButton(
            onPressed: () {
              registerJournal(context);
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _contentController,
          keyboardType: TextInputType.multiline,
          style: const TextStyle(fontSize: 16),
          expands: true,
          minLines: null,
          maxLines: null,
        ),
      ),
    );
  }

  registerJournal(BuildContext context) async {
    JournalService service = JournalService();
    String content = _contentController.text;

    journal.content = content;
    bool result = await service.register(journal);

    Navigator.pop(context, result);
  }
}
