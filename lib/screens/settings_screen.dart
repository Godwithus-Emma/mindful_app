import 'package:flutter/material.dart';
import 'package:mindful_app/data/sp_helper.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController txtName = TextEditingController();
  final List<String> images = ['Lake', 'Sea', 'Mountain', 'Country'];
  String selectedImage = 'Lake';
  final SPHelper spHelper = SPHelper();

  @override
  initState() {
    super.initState();
    loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: txtName,
              decoration: InputDecoration(hintText: 'Enter Your display name and select a background'),
            ),
            DropdownButton<String>(
              value: selectedImage,
              items: images.map((String image) {
                return DropdownMenuItem<String>(
                  value: image,
                  child: Text(image),
                );
              }).toList(),
              onChanged: (newValue) {
                if (newValue != null && images.contains(newValue)) {
                  setState(() {
                    selectedImage = newValue;
                  });
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final messenger = ScaffoldMessenger.of(context);

          bool success = await saveSettings();

          if (!mounted) return;

          messenger.showSnackBar(
            SnackBar(
              content: Text(
                success
                    ? 'Settings saved, kindly restart to see changes.'
                    : 'Failed to save settings.',
              ),
              duration: const Duration(seconds: 3),
            ),
          );
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  Future<bool> saveSettings() async {
    return await spHelper.saveString(txtName.text, selectedImage);
  }

  Future loadSettings() async {
    final settings = await spHelper.getSettings();
    setState(() {
      txtName.text = settings[SPHelper.keyName] ?? '';
      selectedImage = (images.contains(settings[SPHelper.keyImage])
          ? settings[SPHelper.keyImage]
          : 'Lake')!;
    });
  }

  @override
  void dispose() {
    txtName.dispose();
    super.dispose();
  }
}