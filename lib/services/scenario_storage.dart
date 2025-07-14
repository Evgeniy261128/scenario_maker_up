import 'dart:convert';
import 'package:scenario_maker_up/models/scenario_result_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScenarioStorage {
  static const String _kScenarioKey = 'scenario';

  // Сохраняет сценарий локально (перезаписывает предыдущий)
  Future<void> saveScenario(ScenarioResultModel scenario) async {
    final prefs = await SharedPreferences.getInstance();
    final scenarioJson = json.encode(scenario.toJSON());
    await prefs.setString(_kScenarioKey, scenarioJson);
  }

  // Загружает сценарий из локального хранилища (или null, если не найден)
  Future<ScenarioResultModel?> loadScenario() async {
    final prefs = await SharedPreferences.getInstance();
    final scenarioJson = prefs.getString(_kScenarioKey);
    if (scenarioJson == null) return null;
    return ScenarioResultModel.fromJSON(json.decode(scenarioJson));
  }
}
