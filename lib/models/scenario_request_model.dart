// Импорт вспомогательных типов и функций, в частности SocialPlatform
import 'package:scenario_maker_up/services/helpers.dart';

// Модель данных для запроса генерации сценария.
// Используется для передачи параметров генерации (например, в ChatGPT).
class ScenarioRequestModel {
  // Социальная платформа (YouTube, VK и др.)
  final SocialPlatform platform;
  // Тематика видео
  final String videoTheme;
  // Целевая аудитория видео
  final String targetAudience;
  // Длина видео в секундах
  final int videoLengthInSeconds;
  // Стиль контента (например, юмористический, образовательный и т.д.)
  final String contentStyle;
  // Призыв к действию (например, "подписаться", "лайкнуть")
  final String callToAction;
  // Заголовок видео
  final String title;
  // Основной текст/описание видео
  final String body;

  // Конструктор модели с обязательными параметрами
  ScenarioRequestModel({
    required this.platform,
    required this.videoTheme,
    required this.targetAudience,
    required this.videoLengthInSeconds,
    required this.contentStyle,
    required this.callToAction,
    required this.title,
    required this.body,
  });

  // Преобразование объекта в JSON-словарь для передачи по сети или сохранения
  Map<String, dynamic> toJSON() {
    return {
      'platform': platform.toString(), // enum сериализуется как строка
      'videoTheme': videoTheme,
      'targetAudience': targetAudience,
      'videoLengthInSeconds': videoLengthInSeconds,
      'contentStyle': contentStyle,
      'callToAction': callToAction,
      'title': title,
      'body': body,
    };
  }

  // Создание объекта из JSON-словаря (например, после получения с сервера)
  static ScenarioRequestModel fromJSON(Map<String, dynamic> json) {
    return ScenarioRequestModel(
      platform: SocialPlatform.values.firstWhere(
        (e) => e.toString() == json['platform'],
      ),
      videoTheme: json['videoTheme'],
      targetAudience: json['targetAudience'],
      videoLengthInSeconds: json['videoLengthInSeconds'],
      contentStyle: json['contentStyle'],
      callToAction: json['callToAction'],
      title: json['title'],
      body: json['body'],
    );
  }
}
