import 'dart:convert';

import 'package:scenario_maker_up/constants.dart';
import 'package:scenario_maker_up/models/scenario_request_model.dart';
import 'package:scenario_maker_up/models/scenario_result_model.dart';
import 'package:scenario_maker_up/services/dio_client.dart';

// Валидация email (простая проверка наличия и позиции символа '@')
String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return "Email cannot be empty";
  }

  int atIndex = email.indexOf('@');
  if (atIndex == -1 || atIndex == 0 || atIndex == email.length - 1) {
    return "Please enter a valid email address";
  }

  return null;
}

// Перечисление поддерживаемых платформ
enum SocialPlatform { youtube, vk }

// Получение и обработка сценария (асинхронно)
Future<ScenarioResultModel> getScenario({
  required SocialPlatform socialPlatform,
  required String videoTheme,
  required String targetAudience,
  required String videoLength,
  required String contentStyle,
  required String callToAction,
  required DioClient client,
}) async {
  final scenarioPrompt = kScenarioPrompt
      .replaceAll('{platform}', socialPlatform.name)
      .replaceAll('{videoTheme}', videoTheme)
      .replaceAll('{targetAudience}', targetAudience)
      .replaceAll('{videoLength}', videoLength)
      .replaceAll('{contentStyle}', contentStyle)
      .replaceAll('{callToAction}', callToAction);

  String result = await client.getScenario(scenarioPrompt);
  result = result.substring(7, result.length - 3); // обрезка лишних символов

  final jsonResult = json.decode(result);
  jsonResult['id'] = DateTime.now().millisecondsSinceEpoch.toString();
  jsonResult['request'] =
      ScenarioRequestModel(
        platform: socialPlatform,
        videoTheme: videoTheme,
        targetAudience: targetAudience,
        videoLengthInSeconds: int.parse(videoLength),
        contentStyle: contentStyle,
        callToAction: callToAction,
        title: jsonResult['title'] ?? videoTheme,
        body: jsonResult['body'] ?? '',
      ).toJSON();

  return ScenarioResultModel.fromJSON(jsonResult);
}
