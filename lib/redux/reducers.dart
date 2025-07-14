import 'package:scenario_maker_up/redux/actions.dart';
import 'package:scenario_maker_up/redux/state.dart';

// Главный редьюсер для управления состоянием генерации сценария.
// Принимает текущее состояние и экшен, возвращает новое состояние.
ScenarioState scenarioReducer(ScenarioState state, dynamic action) {
  if (action is LoadScenarioAction) {
    // Устанавливаем статус "генерация в процессе"
    return state.copyWith(loadingStatus: LoadingStatus.generating);
  } else if (action is LoadScenarioSuccessAction) {
    // Устанавливаем статус "успех"
    return state.copyWith(loadingStatus: LoadingStatus.success);
  } else if (action is LoadScenarioFailureAction) {
    // Устанавливаем статус "ошибка"
    return state.copyWith(loadingStatus: LoadingStatus.failure);
  }
  // Если экшен не распознан, возвращаем текущее состояние без изменений
  return state;
}
