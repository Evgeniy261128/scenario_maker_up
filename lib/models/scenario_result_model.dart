// Импорт модели запроса для вложенного хранения параметров генерации
import 'package:scenario_maker_up/models/scenario_request_model.dart';

// Модель результата генерации сценария.
// Хранит сгенерированный сценарий и параметры, по которым он был создан.
class ScenarioResultModel {
  // Уникальный идентификатор сценария (например, для хранения или поиска)
  final String id;
  // Заголовок сценария
  final String title;
  // Основной текст сценария
  final String body;
  // Объект запроса, по которому был сгенерирован этот сценарий
  final ScenarioRequestModel request;

  // Конструктор модели результата
  ScenarioResultModel({
    required this.id,
    required this.title,
    required this.body,
    required this.request,
  });

  // Преобразование результата в JSON-словарь (например, для сохранения)
  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'request': request.toJSON(), // вложенный объект запроса
    };
  }

  // Восстановление результата из JSON-словаря
  static ScenarioResultModel fromJSON(Map<String, dynamic> json) {
    return ScenarioResultModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      request: ScenarioRequestModel.fromJSON(json['request']),
    );
  }
}
