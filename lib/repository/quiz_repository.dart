import 'package:dio/dio.dart';
import '../models/question_model.dart';

class QuizRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://opentdb.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<List<QuestionModel>> getQuestions({
    required int amount,
    int? category,
    String? difficulty,
  }) async {
    final response = await _dio.get(
      '/api.php',
      queryParameters: {
        'amount': amount,
        'type': 'multiple',
        if (category != null) 'category': category,
        if (difficulty != null) 'difficulty': difficulty,
      },
    );

    final data = response.data as Map<String, dynamic>;
    final code = data['response_code'] as int;

    if (code == 1) {
      throw Exception(
        'Для таких настроек не хватает вопросов. Уменьшите количество или смените параметры.',
      );
    }
    if (code == 5) {
      throw Exception('Слишком частые запросы. Подождите 5 секунд.');
    }
    if (code != 0) {
      throw Exception('Ошибка API (код $code)');
    }

    return (data['results'] as List)
        .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}