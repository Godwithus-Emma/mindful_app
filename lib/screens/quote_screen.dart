import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mindful_app/data/bible_verse.dart';
import 'package:mindful_app/data/db_helper.dart';
import 'package:mindful_app/screens/quotes_list_screen.dart';
import 'package:mindful_app/screens/settings_screen.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  String address = 'https://bolls.life/get-random-verse/KJV';
BibleVerse verse = BibleVerse(text: '');
  @override
  void initState() {
    super.initState();
    // fetchQuote().then((value) {
    //   verse = value;
    //   setState(() {});
    // });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inspirational Quote"),
      actions: [
        IconButton(
          icon: const Icon(Icons.list),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const QuotesListScreen()),
            );
          },
        ),
           IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
        )
      ],
      ),
      body: FutureBuilder(
        future: fetchQuote(),
        builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } 
        else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'));
        }
        else{
          verse = snapshot.data as BibleVerse;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (verse.text.isNotEmpty)
                  Text(
                    verse.text,
                    style: const TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  )
                else
                  const CircularProgressIndicator(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    fetchQuote().then((value) {
                      verse = value;
                      setState(() {});
                    });
                  },
                  child: const Text('Fetch New Quote'),
                ),
              ],
            ),
          );
        }}
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DBHelper dbHelper = DBHelper();
          dbHelper.insertVerse(verse).then((value) {
            final messenger = (value < 1) ? 'An error occurred while saving the verse.' : 'Verse saved successfully!';
             ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(messenger),
                duration: const Duration(seconds: 3),
              ));
          });
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  Future fetchQuote() async {
    try {
      final response = await http.get(Uri.parse(address));
      if (response.statusCode == 200) {
        final quoteJson = jsonDecode(response.body);
        BibleVerse quote = BibleVerse.fromMap(quoteJson);
        return quote; // Assuming the body contains the quote
      } else {
        throw Exception('Failed to load quote');
      }
    } catch (e) {
      return 'Error fetching quote: $e';
    }
  }
  void goToList() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const QuotesListScreen()),
    );
  }
}