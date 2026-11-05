class QuestionModel {
  final String question;
  final String correctAnswer;
  final List<String> answers;

  QuestionModel({
    required this.question,
    required this.correctAnswer,
    required this.answers,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    final correct = json['correct_answer'] as String;
    final incorrect = List<String>.from(json['incorrect_answers'] as List);

    // Перемешиваем, чтобы правильный ответ не стоял всегда на одном месте
    final answers = [...incorrect, correct]..shuffle();

    return QuestionModel(
      question: json['question'] as String,
      correctAnswer: correct,
      answers: answers,
    );
  }
}