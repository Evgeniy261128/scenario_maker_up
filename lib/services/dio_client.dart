import 'package:dio/dio.dart';

const String baseUrl = 'https://api.proxyapi.ru/openai/v1/chat/completions';
const String apiKey = 'sk-Bjd6XdWsuW1J3efnokMT8yBwyJpFoiZU';

class DioClient {
  DioClient._();

  static final DioClient instance = DioClient._();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
    ),
  );

  // Отправка запроса к ChatGPT и получение сгенерированного сценария
  Future<String> getScenario(String userMessage) async {
    try {
      final Map<String, dynamic> data = {
        'model': 'gpt-4o-mini',
        'messages': [
          {'role': 'user', 'content': userMessage},
        ],
        'max_tokens': 500,
        'temperature': 0.7,
      };

      final Response response = await _dio.post('', data: data);
      if (response.statusCode == 200) {
        return response.data['choices'][0]['message']['content'] ??
            'No response generated';
      }
      throw 'Failed to generate response';
    } catch (e) {
      throw 'Error $e';
    }
  }
}
