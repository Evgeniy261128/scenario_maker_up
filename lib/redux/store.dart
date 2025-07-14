import 'package:redux/redux.dart';
import 'package:scenario_maker_up/redux/reducers.dart';
import 'package:scenario_maker_up/redux/state.dart';

// Инициализация Redux-хранилища приложения.
// Использует scenarioReducer и начальное состояние ScenarioState.
final store = Store<ScenarioState>(
  scenarioReducer,
  initialState: ScenarioState(),
);
