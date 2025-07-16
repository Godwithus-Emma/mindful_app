import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  String address = 'https://bolls.life/get-random-verse/KJV';

  @override
  void initState() {
    super.initState();
    fetchQuote();
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Future<String> fetchQuote() async {
    try {
      final response = await http.get(Uri.parse(address));
      if (response.statusCode == 200) {
        print(response.body);
        return response.body; // Assuming the body contains the quote
      } else {
        throw Exception('Failed to load quote');
      }
    } catch (e) {
      return 'Error fetching quote: $e';
    }
  }
}