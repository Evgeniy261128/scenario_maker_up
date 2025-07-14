enum LoadingStatus { defaultStatus, generating, success, failure }

class ScenarioState {
  final LoadingStatus loadingStatus;
  ScenarioState({this.loadingStatus = LoadingStatus.defaultStatus});

  ScenarioState copyWith({LoadingStatus? loadingStatus}) {
    return ScenarioState(loadingStatus: loadingStatus ?? this.loadingStatus);
  }
}
