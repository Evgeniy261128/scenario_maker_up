import 'package:flutter/material.dart';
import 'package:scenario_maker_up/ui/screens/scenario_generation/components/scenario_description_textfield.dart';

// Форма для ввода параметров сценария
class ScenarioDescriptionForm extends StatelessWidget {
  const ScenarioDescriptionForm({
    super.key,
    required this.formKey, // Ключ формы для валидации
    required this.videoThemeController, // Контроллер для темы видео
    required this.targetAudienceController, // Контроллер для целевой аудитории
    required this.videoLengthController, // Контроллер для длины видео
    required this.contentStyleController, // Контроллер для стиля контента
    required this.callToActionController, // Контроллер для призыва к действию
  });

  final GlobalKey<FormState> formKey; // Ключ формы
  final TextEditingController videoThemeController; // Контроллер поля "Тема"
  final TextEditingController
  targetAudienceController; // Контроллер поля "Аудитория"
  final TextEditingController videoLengthController; // Контроллер поля "Длина"
  final TextEditingController contentStyleController; // Контроллер поля "Стиль"
  final TextEditingController
  callToActionController; // Контроллер поля "Призыв"

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Обеспечивает скролл, если форма не помещается на экране
      child: Form(
        key: formKey, // Привязка ключа для валидации всей формы
        child: Column(
          children: [
            // Поле для ввода темы видео
            ScenarioDescriptionTextfield(
              title:
                  'Enter the theme of the video \\\\n(e.g., Travel, Food)', // Заголовок поля
              hintText: 'Video theme', // Подсказка в поле
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a video theme"; // Проверка на пустое значение
                }
                return null;
              },
              controller:
                  videoThemeController, // Контроллер для доступа к значению
            ),

            const SizedBox(height: 16.0), // Отступ между полями
            // Поле для ввода целевой аудитории
            ScenarioDescriptionTextfield(
              title:
                  'Enter the target audience \\\\n(e.g., Teenagers, Professionals)', // Заголовок
              hintText: 'Target audience', // Подсказка
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter the target audience"; // Проверка на пустое значение
                }
                return null;
              },
              controller: targetAudienceController, // Контроллер
            ),

            const SizedBox(height: 16.0),

            // Поле для ввода длины видео
            ScenarioDescriptionTextfield(
              title:
                  'Enter the length of the video in seconds \\\\n(e.g., 15, 30, 60)', // Заголовок
              hintText: 'Video length', // Подсказка
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a video length'; // Проверка на пустое значение
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number'; // Проверка, что введено число
                }
                return null;
              },
              controller: videoLengthController, // Контроллер
            ),

            const SizedBox(height: 16.0),

            // Поле для ввода стиля контента
            ScenarioDescriptionTextfield(
              title:
                  'Enter the style of content \\\\n(e.g., Informative, Humorous)', // Заголовок
              hintText: 'Content style', // Подсказка
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a content style'; // Проверка на пустое значение
                }
                return null;
              },
              controller: contentStyleController, // Контроллер
            ),

            const SizedBox(height: 16.0),

            // Поле для ввода призыва к действию
            ScenarioDescriptionTextfield(
              title:
                  'Enter a call to action \\\\n(e.g., Subscribe, Comment)', // Заголовок
              hintText: 'Call to action', // Подсказка
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a call to action'; // Проверка на пустое значение
                }
                return null;
              },
              controller: callToActionController, // Контроллер
            ),
          ],
        ),
      ),
    );
  }
}
