import 'package:flutter/material.dart';
import 'quiz_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  static const Map<int?, String> _categories = {
    null: 'Any Category',
    9: 'General Knowledge',
    10: 'Entertainment: Books',
    11: 'Entertainment: Film',
    12: 'Entertainment: Music',
    13: 'Entertainment: Musicals & Theatres',
    14: 'Entertainment: Television',
    15: 'Entertainment: Video Games',
    16: 'Entertainment: Board Games',
    17: 'Science & Nature',
    18: 'Science: Computers',
    19: 'Science: Mathematics',
    20: 'Mythology',
    21: 'Sports',
    22: 'Geography',
    23: 'History',
    24: 'Politics',
    25: 'Art',
    26: 'Celebrities',
    27: 'Animals',
    28: 'Vehicles',
    29: 'Entertainment: Comics',
    30: 'Science: Gadgets',
    31: 'Entertainment: Japanese Anime & Manga',
    32: 'Entertainment: Cartoon & Animations',
  };

  static const Map<String?, String> _difficulties = {
    null: 'All',
    'easy': 'Easy',
    'medium': 'Medium',
    'hard': 'Hard',
  };

  double _amount = 5;
  int? _category;
  String? _difficulty;

  void _start() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuizPage(
          amount: _amount.round(),
          category: _category,
          difficulty: _difficulty,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Game settings')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Questions amount: ${_amount.round()}',
              style: const TextStyle(fontSize: 16),
            ),
            Slider(
              value: _amount,
              min: 1,
              max: 10,
              divisions: 9,
              label: _amount.round().toString(),
              onChanged: (v) => setState(() => _amount = v),
            ),
            const SizedBox(height: 16),
            const Text('Category'),
            const SizedBox(height: 8),
            DropdownButtonFormField<int?>(
              initialValue: _category,
              isExpanded: true,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: _categories.entries
                  .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
                  .toList(),
              onChanged: (v) => setState(() => _category = v),
            ),
            const SizedBox(height: 24),
            const Text('Difficulty'),
            const SizedBox(height: 8),
            DropdownButtonFormField<String?>(
              initialValue: _difficulty,
              isExpanded: true,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: _difficulties.entries
                  .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
                  .toList(),
              onChanged: (v) => setState(() => _difficulty = v),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _start,
                child: const Text(
                  'START',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}