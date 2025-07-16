import 'package:flutter/material.dart';
import 'package:mindful_app/data/sp_helper.dart';
import 'package:mindful_app/screens/settings_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  String name = '';
  String image = '';
  @override
  void initState() {
    super.initState();
    final spHelper = SPHelper();
    spHelper.getSettings().then((settings) {
      setState(() {
        name = settings[SPHelper.keyName] ?? '';
        image = settings[SPHelper.keyImage] ?? 'Lake';
      });
    });
    // Load settings if needed
    // SPHelper().getSettings().then((settings) {
    //   setState(() {
    //     name = settings['name'] ?? '';
    //     image = settings['image'] ?? '';
    //   });
    // });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/$image.jpg', fit: BoxFit.cover),
          ),
          Align(
            alignment: Alignment(0, -0.5),
            child: Text(
              'Welcome $name',
              style: TextStyle(
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    blurRadius: 10,
                    offset: Offset(5, 5),
                  ),
                ],
                fontSize: 24,
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.5),
            child: ElevatedButton(onPressed: () {
              Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => SettingsScreen())
              );
            }, 
            child: Text('Start')),
          ),
        ],
      ),
    );
  }
}
