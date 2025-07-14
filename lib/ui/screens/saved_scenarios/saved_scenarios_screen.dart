import 'package:flutter/material.dart';
import 'package:scenario_maker_up/models/scenario_result_model.dart';
import 'package:scenario_maker_up/services/firebase_storage.dart';
import 'package:scenario_maker_up/ui/screens/saved_scenarios/components/scenario_item.dart';
import 'package:scenario_maker_up/ui/screens/saved_scenarios/components/stub.dart';
import 'package:share_plus/share_plus.dart';

// Экран для отображения списка сохранённых сценариев пользователя
class SavedScenariosScreen extends StatefulWidget {
  const SavedScenariosScreen({super.key});

  @override
  State<SavedScenariosScreen> createState() => _SavedScenariosScreenState();
}

class _SavedScenariosScreenState extends State<SavedScenariosScreen>
    with AutomaticKeepAliveClientMixin<SavedScenariosScreen> {
  // Говорим Flutter, что хотим сохранять состояние экрана при переключении вкладок
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // важно для AutomaticKeepAliveClientMixin

    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved scenarios"),
        actions: [
          IconButton(
            onPressed: () {}, // TODO: реализовать логику выхода из аккаунта
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      // Используем StreamBuilder для подписки на поток сценариев из Firestore
      body: StreamBuilder<List<ScenarioResultModel>>(
        stream: FirebaseStorage().getScenariosStream(),
        builder: (context, snapshot) {
          // Пока идёт загрузка — показываем индикатор
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Если произошла ошибка — показываем Stub с ошибкой
          else if (snapshot.hasError) {
            return Stub(
              text: 'Error: ${snapshot.error}',
              icon: Icons.warning,
              iconColor: Colors.red[800],
            );
          }
          // Если есть данные
          else if (snapshot.hasData && snapshot.data != null) {
            final scenarios = snapshot.data!;
            // Если список сценариев пуст — Stub с подсказкой
            if (scenarios.isEmpty) {
              return Stub(
                text: 'No saved scenarios \nGenerate new scenario',
                icon: Icons.dangerous,
                iconColor: Colors.yellow[800],
              );
            }
            // Если есть сценарии — строим список
            return ListView.builder(
              itemCount: scenarios.length,
              itemBuilder: (context, index) {
                final scenario = scenarios[index];
                return ScenarioItem(
                  scenario: scenario,
                  // Удаление сценария из Firestore
                  onDelete: () => FirebaseStorage().deleteScenario(scenario.id),
                  // Поделиться сценарием через share_plus
                  onShare: () => Share.share(scenario.body),
                );
              },
            );
          }
          // Если данных нет вообще — Stub
          else {
            return Stub(
              text: 'No data available',
              icon: Icons.dangerous,
              iconColor: Colors.red[800],
            );
          }
        },
      ),
    );
  }
}
