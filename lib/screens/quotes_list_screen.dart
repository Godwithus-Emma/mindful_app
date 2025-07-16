import 'package:flutter/material.dart';
import '../data/bible_verse.dart';
import '../data/db_helper.dart';

class QuotesListScreen extends StatelessWidget {
  const QuotesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quotes List")),
      body: FutureBuilder<List<BibleVerse>>(
        future: fetchQuotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No quotes available.'));
          } else {
            final quotes = snapshot.data!;
            return ListView.builder(
              itemCount: quotes.length,
              itemBuilder: (context, index) {
                final quote = quotes[index];
                return Dismissible(
                  key: Key(quote.id.toString()),
                  onDismissed: (_) {
                    DBHelper helper = DBHelper();
                    helper.deleteVerse(quote.id!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Quote deleted')),
                    );
                  },
                  child: ListTile(
                    title: Text(quote.text),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<BibleVerse>> fetchQuotes() async {
    final dbHelper = DBHelper();
    return await dbHelper.getAllVerses();
  }
}