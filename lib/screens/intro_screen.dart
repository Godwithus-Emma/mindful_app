import 'package:flutter/material.dart';
import 'package:mindful_app/data/sp_helper.dart';
import 'package:mindful_app/screens/quote_screen.dart'; 
import 'package:mindful_app/screens/settings_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  String name = '';
  String image = 'Lake';

  @override
  void initState() {
    super.initState();
    final helper = SPHelper();
    helper.getSettings().then((settings) {
      name = settings['name'] ?? '';
      image = settings['image'] ?? 'Lake';
      if (image == '') image = 'Lake';
      setState(() {
        
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            'assets/$image.jpg',
            fit: BoxFit.cover,
          )),
          Align(
            alignment: const Alignment(0, -0.5),
              child: Text(
            'Welcome, $name',
            style: const TextStyle(
              color: Colors.white,
              shadows: [Shadow(
                blurRadius: 10,
                color: Colors.black,
                offset: Offset(5, 5)
              )],
              fontSize: 24),

          )),
          Align(
            alignment: const Alignment(0, 0.5),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext contenxt) => const QuoteScreen())
                );
              }, 
              child: const Text('Get Started')),
          )
        ],
      ),
    );
  }
}
