import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../repository/quiz_repository.dart';

class QuizPage extends StatefulWidget {
  final int amount;
  final int? category;
  final String? difficulty;

  const QuizPage({
    super.key,
    required this.amount,
    this.category,
    this.difficulty,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final QuizRepository _repository = QuizRepository();
  late Future<List<QuestionModel>> _future;

  Future<List<QuestionModel>> _load() {
    return _repository.getQuestions(
      amount: widget.amount,
      category: widget.category,
      difficulty: widget.difficulty,
    );
  }

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  void _retry() {
    setState(() {
      _future = _load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: FutureBuilder<List<QuestionModel>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            final message =
            snapshot.error.toString().replaceFirst('Exception: ', '');
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(message, textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _retry,
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              ),
            );
          }

          final questions = snapshot.data!;

          // Вопросы листаются свайпом влево
          return PageView.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) {
              return _QuestionView(
                question: questions[index],
                number: index + 1,
                total: questions.length,
              );
            },
          );
        },
      ),
    );
  }
}

class _QuestionView extends StatelessWidget {
  final QuestionModel question;
  final int number;
  final int total;

  const _QuestionView({
    required this.question,
    required this.number,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text('$number/$total', style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 32),
          Text(
            question.question,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 40),
          ...question.answers.map(
                (answer) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                    foregroundColor: Colors.black87,
                  ),
                  onPressed: () {
                    // пока ничего не происходит
                  },
                  child: Text(answer, textAlign: TextAlign.center),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}