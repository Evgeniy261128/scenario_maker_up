import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:scenario_maker_up/redux/actions.dart';
import 'package:scenario_maker_up/redux/state.dart';
import 'package:scenario_maker_up/services/dio_client.dart';
import 'package:scenario_maker_up/services/firebase_storage.dart';
import 'package:scenario_maker_up/services/helpers.dart';
import 'package:scenario_maker_up/ui/screens/saved_scenarios/components/stub.dart';
import 'package:scenario_maker_up/ui/screens/scenario_generation/scenario_description_form.dart';

// Экран генерации нового сценария для выбранной платформы
class ScenarioGenerationScreen extends StatefulWidget {
  const ScenarioGenerationScreen({required this.socialPlatform, super.key});
  final SocialPlatform socialPlatform; // Платформа (YouTube, VK и др.)

  @override
  State<ScenarioGenerationScreen> createState() =>
      _ScenarioGenerationScreenState();
}

class _ScenarioGenerationScreenState extends State<ScenarioGenerationScreen> {
  // Контроллеры для каждого поля формы
  final videoThemeController = TextEditingController();
  final targetAudienceController = TextEditingController();
  final videoLengthController = TextEditingController();
  final contentStyleController = TextEditingController();
  final callToActionController = TextEditingController();
  final formKey = GlobalKey<FormState>(); // Ключ формы для валидации

  final client = DioClient.instance; // Экземпляр клиента для работы с API

  @override
  void dispose() {
    super.dispose();
    // Освобождаем ресурсы контроллеров при удалении экрана
    videoThemeController.dispose();
    targetAudienceController.dispose();
    videoLengthController.dispose();
    contentStyleController.dispose();
    callToActionController.dispose();
  }

  // Функция генерации сценария и сохранения его в Firebase
  void LoadScenario(Store store) async {
    if (formKey.currentState!.validate()) {
      // Проверяем валидность формы
      // Проверка авторизации пользователя
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        if (mounted) {
          // Проверяем, что виджет не удалён из дерева
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Чтобы сохранить сценарий, войдите в систему'),
            ),
          );
        }
      }

      try {
        store.dispatch(LoadScenarioAction()); // Redux: статус "генерация"
        final res = await getScenario(
          socialPlatform: widget.socialPlatform,
          videoTheme: videoThemeController.text,
          targetAudience: targetAudienceController.text,
          videoLength: videoLengthController.text,
          contentStyle: contentStyleController.text,
          callToAction: callToActionController.text,
          client: client,
        );

        await FirebaseStorage().saveScenario(
          res,
        ); // Сохраняем сценарий в Firebase
        store.dispatch(LoadScenarioSuccessAction()); // Redux: статус "успех"
      } catch (error) {
        store.dispatch(
          LoadScenarioFailureAction(error.toString()),
        ); // Redux: статус "ошибка"
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<ScenarioState>(
      context,
    ); // Получаем Redux store

    return Scaffold(
      appBar: AppBar(title: const Text("Generate new video scenario")),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: StoreConnector<ScenarioState, ScenarioState>(
            converter: (store) => store.state, // Получаем состояние из Redux
            builder: (context, state) {
              // Если статус "по умолчанию" или "успех" — показываем форму и кнопку отправки
              if (state.loadingStatus == LoadingStatus.defaultStatus ||
                  state.loadingStatus == LoadingStatus.success) {
                return Column(
                  children: [
                    Expanded(
                      child: ScenarioDescriptionForm(
                        formKey: formKey,
                        videoThemeController: videoThemeController,
                        targetAudienceController: targetAudienceController,
                        videoLengthController: videoLengthController,
                        contentStyleController: contentStyleController,
                        callToActionController: callToActionController,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed:
                          () =>
                              LoadScenario(store), // Запуск генерации сценария
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 60,
                        ),
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                );
              }
              // Если статус "ошибка" — Stub с сообщением об ошибке
              if (state.loadingStatus == LoadingStatus.failure) {
                return Center(
                  child: Stub(
                    text: 'An error occured!\\nTry again later',
                    icon: Icons.warning,
                    iconColor: Colors.red[800],
                  ),
                );
              }
              // Если статус "генерация" — показываем индикатор загрузки
              return const Center(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
