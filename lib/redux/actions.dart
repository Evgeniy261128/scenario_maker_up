// Экшен для начала загрузки/генерации сценария.
// Обычно диспатчится при запуске процесса генерации (например, при нажатии "Сгенерировать").
class LoadScenarioAction {}

// Экшен, сигнализирующий об успешной генерации сценария.
// Диспатчится после получения успешного ответа от сервиса генерации.
class LoadScenarioSuccessAction {}

// Экшен, сигнализирующий о неудаче при генерации сценария.
// Передаёт строку ошибки для отображения пользователю или логирования.
class LoadScenarioFailureAction {
  final String error;
  LoadScenarioFailureAction(this.error);
}
